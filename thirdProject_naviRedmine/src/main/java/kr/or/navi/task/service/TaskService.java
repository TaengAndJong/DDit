package kr.or.navi.task.service;

import java.io.IOException;
import java.util.List;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.TaskFileVO;
import kr.or.navi.vo.TaskVO;
import kr.or.navi.vo.TeamVO;

public interface TaskService {

		//task 레코드 전체조회
		//public List<TaskVO> taskList(PaginationInfo paging);
		public List<TaskVO> taskList(PaginationInfo paging);
		public List<TaskVO> taskProjectList(PaginationInfo paging,String proId);
		public TaskVO retriveTask(String taskId);
		public int removeTask(String taskId,EmpVO realUser);
		public List<TeamVO> selectListTeamList(String proId);
		public int modifyTask(TaskVO modifyTask) throws IOException;
		public int createTask(TaskVO insertTask) throws IOException;
		public List<TaskVO> retriveChildTaskList(String taskId);
		public List<TaskFileVO> retriveTaskFileList(String taskId);
		public ResponseEntity<Resource> downloadFile(String tfId) throws IOException;
		public int removeTaskFile(String tfId) throws IOException;
		public List<TaskVO> retriveTaskListAll(String proId);
}
