package kr.or.navi.task.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.validation.constraints.NotBlank;
import javax.validation.groups.Default;

import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.lang3.StringUtils;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.navi.alarm.service.SseEmitters;
import kr.or.navi.common.paging.BootstrapFormBasePaginationRenderer;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.common.paging.PaginationRenderer;
import kr.or.navi.security.RealUser;
import kr.or.navi.task.service.TaskService;
import kr.or.navi.validate.InsertGroup;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.TaskVO;
import kr.or.navi.vo.TeamVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/task")
public class TaskController {
	
	/*
	 * @RequestParam의 name을 설정하지 않으면 매개변수의 이름의 파라미터를 그대로 받아서 적용함.
	 * RequestParam의 required는 기본값으로 true로 적용되어 있으며, 매개변수의 값을 필수적으로 요구함 
	 * 따라서, 초기값을 설정하기 위해서는 required의 값을 false로 설정 후, defaultValue를 따로 기입해준다.
	 * @RequestParam의 defaultValue는 매개변수(파라미터)의 값이 전달되지 않을 때 기본설정을 1로 맞춤, 즉 현재페이지의 초기값은 1
	 * 
	 * */
	@Inject
	private SseEmitters message;
	
	@Inject
	TaskService taskService;
	
	@GetMapping
	public String task(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage
			,@RequestParam Map<String, Object> detailCondition
			,Model model) {
		//1. 페이지네이션에대한 객체를 가져와서 선언을 해줘야 페이지네이션 설정 가능 및 서비스로직에 넘겨줄 파라미터값을 줄 수 있음
		PaginationInfo paging = new PaginationInfo(10,10); // 스크린 사이즈와, 블럭 사이즈
		//2.현재페이지 설정하기 : 현재페이지의 타입은 PaginationInfo에 int로 선언되어있기 때문에 int로 받아야하며, required는 필수 값 
		paging.setCurrentPage(currentPage); 
		paging.setDetailCondition(detailCondition);
		//3.목록조회 및 페이지네이션과 검색조건에 맞는 데이터를 서버와 클라이언트 사이에서 데이터를 전달해주기 위한 서비스로직
		List<TaskVO> taskList =taskService.taskList(paging);
		log.info("taskList: {} ",taskList);
		model.addAttribute("taskList",taskList); 
		//4.페이지네이션 그려주기
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		//5.페이지네이션 html String값으로 넘겨주기
		String pagingHTML = renderer.renderPagination(paging);
		//6.모델에 담아서 뷰로 보내기
		model.addAttribute("pagingHTML",pagingHTML);
		model.addAttribute("paging",paging);
		log.info("pagingHTML: {} ",pagingHTML);
		log.info("paging: {} ",paging);
		return "task/task"; // ViewResolver로 보내기
	}

	@GetMapping("taskRegister")
	public String taskRegister(@RealUser EmpVO realUser) {
		log.info("realUser : {}",realUser);
		
		return "task/taskRegister";
	}
	
	

	//detailpage는 selectOne으로 데이터 가져오기
	@GetMapping("{taskId}")
	public String taskDetail(@PathVariable String taskId, Model model) {
		log.info(taskId);
		TaskVO taskVO = taskService.retriveTask(taskId);
		model.addAttribute("task",taskVO);
		return "task/taskDetail";
	}
	
	@DeleteMapping("{taskId}")
	public String deleteTaskController(@PathVariable String taskId,Model model,@RealUser EmpVO empVO) {
		log.info("taskId : {}",taskId);
		int cnt = taskService.removeTask(taskId,empVO);
		if(cnt>0) {
			model.addAttribute("msg","ok");
			message.taskDel(empVO,taskId);
		}else {
			model.addAttribute("msg","fail");
		}
		return "jsonView";
	}
	
	@GetMapping("mod/{taskId}")
	public String modifyPage(@PathVariable String taskId,Model model) {
		log.info(taskId);
		TaskVO taskVO = taskService.retriveTask(taskId);
		model.addAttribute("task",taskVO);
		return "task/taskModify";
	}
	@PostMapping("mod/{taskId}/list/{proId}")
	@ResponseBody
	public List<TeamVO> empListController(@PathVariable String taskId,@PathVariable String proId,Model model) {
		log.info("taskId : {}",taskId);
		log.info("proId : {}",proId);
		List<TeamVO> teamList = taskService.selectListTeamList(proId);
		log.info("teamList : {}",teamList);
		return teamList;
	}
	@PostMapping("add/list/{proId}")
	public List<TeamVO> addEmpListController(@PathVariable String proId,Model model) {
		log.info("proId : {}",proId);
		List<TeamVO> teamList = taskService.selectListTeamList(proId);
		log.info("teamList : {}",teamList);
		return teamList;
	}
	@PostMapping("add/task/{proId}")
	@ResponseBody
	public List<TaskVO> addTaskListController(@PathVariable String proId,Model model) {
		log.info("proId : {}",proId);
		List<TaskVO> taskList = taskService.taskProjectList(new PaginationInfo(), proId);
		log.info("taskList : {}",taskList);
		return taskList;
	}
	@PostMapping("add/{proId}")
	public String addTaskController(
			@Validated @ModelAttribute("task") TaskVO insertTask
			,Errors errors
			,@RealUser EmpVO realUser
			,@PathVariable String proId,Model model) throws IOException {
		log.info("insertTask : {}",insertTask);
		log.info("errors : {}",errors);
		log.info("proId : {}",proId);
		insertTask.setTaskRegId(realUser.getEmpId());
		if(!errors.hasErrors()) {
			int cnt = taskService.createTask(insertTask);
			if (cnt>0) {
				message.taskReg(realUser, insertTask.getTaskId());
				return "redirect:/project/task/"+proId+"/"+insertTask.getTaskId();
			}else {
				return "project/task/taskRegister";
			}
		}else {
			return "project/task/taskRegister";
		}
		
		
	}
	@PostMapping("mod")
	@ResponseBody
	public Map<String, Object> taskModfiyController(@ModelAttribute("task") TaskVO modifyTask,@RealUser EmpVO empVO) throws IOException {
		log.info("modifyTask : {}",modifyTask);
		Map<String, Object> msg = new HashedMap();
		if(
			StringUtils.isNotBlank(modifyTask.getTaskId())
			&&StringUtils.isNotBlank(modifyTask.getTaskTitle())
			&&StringUtils.isNotBlank(modifyTask.getTsId())
			&&StringUtils.isNotBlank(modifyTask.getTpsId())
			&&StringUtils.isNotBlank(modifyTask.getTaskManId())
			&&StringUtils.isNotBlank(modifyTask.getTaskCn())
			&&modifyTask.getTaskEstTime()!=null
		) {
			int cnt = taskService.modifyTask(modifyTask);
			if(cnt>0) {
				if("T00007".equals(modifyTask.getTpsId())){
					message.taskComp(empVO,modifyTask.getTaskId());
				}else {
					message.taskMod(empVO,modifyTask.getTaskId());
				}
				msg.put("msg", "ok");
				
			}else {
				msg.put("msg", modifyTask);
			}
		}else {
			msg.put("msg", modifyTask);
		}
		return msg;
	}
	
	@GetMapping("child/{taskId}")
	@ResponseBody
	public List<TaskVO> getChildTaskController(@PathVariable String taskId){
		return taskService.retriveChildTaskList(taskId);
	}
	@GetMapping("download/{tfId}")
	public ResponseEntity<Resource> downloadFile(@PathVariable String tfId) throws IOException{
		return taskService.downloadFile(tfId);
	}
	@PostMapping("file/del/{tfId}")
	@ResponseBody
	public Map<String, String> isssueFileDelController(@PathVariable String tfId) throws IOException {
		int cnt = taskService.removeTaskFile(tfId);
		Map<String, String> msg = new HashedMap();
		if(cnt>0) {
			msg.put("msg", "ok");
		}else {
			msg.put("msg", "fail");
		}
		return msg;
	}
}
