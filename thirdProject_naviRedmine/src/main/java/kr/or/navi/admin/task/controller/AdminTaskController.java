package kr.or.navi.admin.task.controller;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.navi.admin.task.dao.AdminTaskDAO;
import kr.or.navi.admin.task.service.AdminTaskService;
import kr.or.navi.common.paging.BootstrapFormBasePaginationRenderer;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.common.paging.PaginationRenderer;
import kr.or.navi.task.service.TaskService;
import kr.or.navi.vo.BoardPostVO;
import kr.or.navi.vo.TaskVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminTaskController {
	@Inject
	AdminTaskService adminService;

	@Inject
	TaskService taskService;

	@GetMapping("task")
	public String task(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage
			,@RequestParam Map<String, Object> detailCondition
			,Model model) {
		// 1. 페이지네이션에대한 객체를 가져와서 선언을 해줘야 페이지네이션 설정 가능 및 서비스로직에 넘겨줄 파라미터값을 줄 수 있음
		PaginationInfo paging = new PaginationInfo(7, 5); // 스크린 사이즈와, 블럭 사이즈
		// 2.현재페이지 설정하기 : 현재페이지의 타입은 PaginationInfo에 int로 선언되어있기 때문에 int로 받아야하며,
		// required는 필수 값
		paging.setCurrentPage(currentPage);
		paging.setDetailCondition(detailCondition);
		// 3.목록조회 및 페이지네이션과 검색조건에 맞는 데이터를 서버와 클라이언트 사이에서 데이터를 전달해주기 위한 서비스로직
		List<TaskVO> taskList = taskService.taskList(paging);
		log.info("taskList: {} ", taskList);
		model.addAttribute("taskList", taskList);

		// 4.페이지네이션 그려주기
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		// 5.페이지네이션 html String값으로 넘겨주기
		String pagingHTML = renderer.renderPagination(paging);
		// 6.모델에 담아서 뷰로 보내기
		model.addAttribute("pagingHTML", pagingHTML);
		model.addAttribute("paging", paging);
		log.info("pagingHTML: {} ", pagingHTML);
		log.info("paging: {} ", paging);
		return "admin/task/adminTaskList";
	}

	@DeleteMapping("task")
	public String taskDeleteContoroller(@RequestBody List<TaskVO> deleteTask, Errors error, Model model) {
		log.info("deleteTask : {}", deleteTask);
		log.info("error : {}", error);
		if (deleteTask.size() == 0) {
			model.addAttribute("msg", "empty");
		} else {
			int cnt = adminService.taskCheckedDelete(deleteTask);
			if (cnt > 0) {
				model.addAttribute("msg", "ok");
			} else {
				model.addAttribute("msg", "fail");
			}
		}

		return "jsonView";
	}

}
