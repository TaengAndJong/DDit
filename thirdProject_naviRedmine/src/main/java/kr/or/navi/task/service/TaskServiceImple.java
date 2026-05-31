package kr.or.navi.task.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.task.dao.TaskDAO;
import kr.or.navi.todaylist.dao.TodayListDAO;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.IssueFileVO;
import kr.or.navi.vo.TaskFileVO;
import kr.or.navi.vo.TaskVO;
import kr.or.navi.vo.TeamVO;
import kr.or.navi.vo.TodayListVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class TaskServiceImple implements TaskService{

	//1.dao injection 하기
	@Inject
	private TaskDAO taskDao;
	@Inject
	private TodayListDAO tdDao;
	@Override
	public List<TaskVO> taskList(PaginationInfo paging) {
		int totalRecord = taskDao.selectTotalRecord(paging);
		paging.setTotalRecord(totalRecord); // 컨트롤러로부터 받아오는 정보를 셋팅해서, paginationInfo 에게 넘겨주기
		log.info("taskDao",taskDao.selectList(paging));
		return taskDao.selectList(paging);
	}

	@Override
	public TaskVO retriveTask(String taskId) {
		return taskDao.select(taskId);
	}

	@Override
	public int removeTask(String taskId,EmpVO realUser) {
		String empId = realUser.getEmpId();
		List<TodayListVO> tdList = tdDao.selectTodayList(empId, taskId);
		int cnt=0;
		for(TodayListVO vo : tdList) {
			String taskId2 = vo.getTaskId();
			if(taskId2.equals(taskId)) {
				cnt+= tdDao.deleteTodayListOne(vo);
			}
		}
		cnt+= taskDao.deleteTask(taskId);
		return cnt;
	}

	@Override
	public List<TeamVO> selectListTeamList(String proId) {
		return taskDao.selectTeamList(proId);
	}
	@Value("file:D:/saveFiles/")
	private Resource saveFolder;
	@Override
	public int modifyTask(TaskVO modifyTask) throws IOException {
		List<TaskFileVO> taskFileList = modifyTask.getTaskFileList();
		int cnt=0;
		for(TaskFileVO bpfVO : taskFileList) {
			MultipartFile bpAttchFile = bpfVO.getBpAttchFile();
			String uuid = saveToResource(bpAttchFile, saveFolder);
			bpfVO.setTaskUuidName(uuid); 
			bpfVO.setTaskId(modifyTask.getTaskId());
			cnt+=taskDao.insertFile(bpfVO);
		}
		cnt+= taskDao.updateTask(modifyTask);
		return cnt;
	}
	private String saveToResource(MultipartFile single, Resource saveFolder) throws IOException {
		String saveName = UUID.randomUUID().toString(); //겹치지 않는 걸로 만들어주기 위해 random으로 생성
		Resource saveFileRes = saveFolder.createRelative(saveName);
		File saveFile = saveFileRes.getFile(); //저장을 하기 위해선 File로 변환
		try(
				InputStream is = single.getInputStream();
				){
			FileUtils.copyInputStreamToFile(is, saveFile); //저장
		}
		return saveName;
	}
	@Override
	public List<TaskVO> taskProjectList(PaginationInfo paging, String proId) {
		int totalRecord = taskDao.selectProjectTotalRecord(paging,proId);
		paging.setTotalRecord(totalRecord); // 컨트롤러로부터 받아오는 정보를 셋팅해서, paginationInfo 에게 넘겨주기
		return taskDao.selectProjectList(paging,proId);
	}

	@Override
	public int createTask(TaskVO insertTask) throws IOException {
		int cnt = taskDao.insertTask(insertTask);
		List<TaskFileVO> taskFileList = insertTask.getTaskFileList();
		for(TaskFileVO bpfVO : taskFileList) {
			MultipartFile bpAttchFile = bpfVO.getBpAttchFile();
			String uuid = saveToResource(bpAttchFile, saveFolder);
			bpfVO.setTaskUuidName(uuid); 
			bpfVO.setTaskId(insertTask.getTaskId());
			cnt+=taskDao.insertFile(bpfVO);
		}
		return cnt;
	}

	@Override
	public List<TaskVO> retriveChildTaskList(String taskId) {
		return taskDao.selectChildTaskList(taskId);
	}

	@Override
	public List<TaskFileVO> retriveTaskFileList(String taskId) {
		return taskDao.selectTaskFileList(taskId);
	}

	@Override
	public ResponseEntity<Resource> downloadFile(String tfId) throws IOException {
		TaskFileVO attach = taskDao.selectTaskFile(tfId);
		String bpUuidName = attach.getTaskUuidName();
		String bpOrgNm = attach.getTfOrgNm();
		Resource imageFile = saveFolder.createRelative(bpUuidName);
//		Content-Disposition: attachment; filename="filename.jpg"
		if(!imageFile.exists()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND,String.format("%s 파일을 찾을 수 없음",bpOrgNm));
		}
		HttpHeaders headers = new HttpHeaders();
		headers.setContentLength(imageFile.contentLength());
		ContentDisposition disposition = ContentDisposition.attachment()
				.filename(bpOrgNm, Charset.forName("UTF-8"))
				.build();
		headers.setContentDisposition(disposition);
		return ResponseEntity.ok()
				.headers(headers)
				.body(imageFile);
	}

	@Override
	public int removeTaskFile(String tfId) throws IOException {
		TaskFileVO attach = taskDao.selectTaskFile(tfId);
		String bpUuidName = attach.getTaskUuidName();
		String bpOrgNm = attach.getTfOrgNm();
		Resource imageFile = saveFolder.createRelative(bpUuidName);
		File file = imageFile.getFile();
		int cnt=0;
		if(file.delete()) {
			 cnt+= taskDao.deleteTaksFile(tfId);
		}else {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND,String.format("%s 파일을 찾을 수 없음",bpOrgNm));
		}
		return cnt;
	}

	@Override
	public List<TaskVO> retriveTaskListAll(String proId) {
		return taskDao.selectProjectList(new PaginationInfo(), proId);
	}

	
	

	
}
