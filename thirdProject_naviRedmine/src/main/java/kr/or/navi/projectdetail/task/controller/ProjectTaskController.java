package kr.or.navi.projectdetail.task.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.navi.common.paging.BootstrapFormBasePaginationRenderer;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.common.paging.PaginationRenderer;
import kr.or.navi.security.RealUser;
import kr.or.navi.task.service.TaskService;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.TaskFileVO;
import kr.or.navi.vo.TaskVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/project/task")
public class ProjectTaskController {
	@Inject
	TaskService taskService;
	@GetMapping("{proId}")
	public String taskPage(@PathVariable(name = "proId") String proId
			,@RequestParam(name="page", required = false, defaultValue = "1") int currentPage
			,@RequestParam Map<String, Object> detailCondition
			,Model model) {
		//1. 페이지네이션에대한 객체를 가져와서 선언을 해줘야 페이지네이션 설정 가능 및 서비스로직에 넘겨줄 파라미터값을 줄 수 있음
		PaginationInfo paging = new PaginationInfo(10,10); // 스크린 사이즈와, 블럭 사이즈
		//2.현재페이지 설정하기 : 현재페이지의 타입은 PaginationInfo에 int로 선언되어있기 때문에 int로 받아야하며, required는 필수 값 
		paging.setCurrentPage(currentPage); 
		paging.setDetailCondition(detailCondition);
		//3.목록조회 및 페이지네이션과 검색조건에 맞는 데이터를 서버와 클라이언트 사이에서 데이터를 전달해주기 위한 서비스로직
		List<TaskVO> taskList =taskService.taskProjectList(paging,proId);
		log.info("taskList: {} ",taskList);
		model.addAttribute("taskList",taskList); 
		
		List<TaskVO> taskListAll = taskService.retriveTaskListAll(proId);
		Map<String, Integer> addTaskCnt = addTaskCnt(taskListAll);
		model.addAttribute("addTaskCnt",addTaskCnt); 
		
		//4.페이지네이션 그려주기
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		//5.페이지네이션 html String값으로 넘겨주기
		String pagingHTML = renderer.renderPagination(paging);
		//6.모델에 담아서 뷰로 보내기
		model.addAttribute("pagingHTML",pagingHTML);
		model.addAttribute("paging",paging);
		log.info("pagingHTML: {} ",pagingHTML);
		log.info("paging: {} ",paging);
		return "project/task/task"; // ViewResolver로 보내기
	}
	public Map<String, Integer> addTaskCnt(List<TaskVO> taskListAll){
		Map<String, Integer> taskCntMap = new HashedMap();
		taskCntMap.put("T00001",0);
		taskCntMap.put("T00002",0);
		taskCntMap.put("T00003",0);
		log.info("taskListAll : {}",taskListAll);
		int total=0;
		int cnt=0;
		if(taskListAll.size()==0) {
			return taskCntMap;
		}
		for(TaskVO vo : taskListAll) {
			cnt++;
			String tpsIng = vo.getTaskProcessStatus().getTpsIng();
			total+=Integer.parseInt(tpsIng.replace("%", ""));
			taskCntMap.put(vo.getTaskStatus().getTsId(),taskCntMap.get(vo.getTaskStatus().getTsId())+1);
		}
		taskCntMap.put("totalIng", (total/cnt));
		return taskCntMap;
	}
	@GetMapping("{proId}/taskRegister")
	public String taskRegister(@ModelAttribute("task") TaskVO insertTask, @RealUser EmpVO realUser) {
		log.info("realUser : {}",realUser);
		return "project/task/taskRegister";
	}
	@GetMapping("{proId}/{taskId}")
	public String taskDetail(@PathVariable String taskId, Model model) {
		log.info(taskId);
		TaskVO taskVO = taskService.retriveTask(taskId);
		List<TaskFileVO> fileList = taskService.retriveTaskFileList(taskId);
		model.addAttribute("fileList",fileList);
		log.info("taskVO : {}",taskVO);
		model.addAttribute("task",taskVO);
		
		return "project/task/taskDetail";
	}
	@GetMapping("{proId}/mod/{taskId}")
	public String modifyPage(@PathVariable String taskId,Model model) {
		log.info(taskId);
		TaskVO taskVO = taskService.retriveTask(taskId);
		model.addAttribute("task",taskVO);
		List<TaskFileVO> fileList = taskService.retriveTaskFileList(taskId);
		model.addAttribute("fileList",fileList);
		return "project/task/taskModify";
	}
}
