package kr.or.navi.admin.project.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.navi.admin.project.service.AdminProjectService;
import kr.or.navi.common.paging.BootstrapFormBasePaginationRenderer;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.common.paging.PaginationRenderer;
import kr.or.navi.project.service.ProjectService;
import kr.or.navi.vo.ProjectVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminProjectController {

	/**
	 * 진행중인 프로젝트를 조회하기 위한 서비스
	 */
	@Inject
	public ProjectService projectService;

	/**
	 * 1. 삭제한 프로젝트를 조회하기 위한 서비스 2. 체크박스를 항목으로한 삭제서비스 3. 체크박스를 항목으로한 복구서비스
	 */
	@Inject
	public AdminProjectService adminProjectService;

	@GetMapping("/project")
	public String projectPage(@RequestParam(value = "ing", required = false, defaultValue = "ing") String ing,
			@RequestParam Map<String, Object> detailCondition,
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage, Model model) {
		if (ing.equals("end")) { // 마감된
			detailCondition.put("ing", "");
			ing = "end";

		} else {
			detailCondition.put("ing", "ing");
		}
		log.info("detailCondition : {}",detailCondition);
		PaginationInfo paging = new PaginationInfo(7, 5);
		paging.setCurrentPage(currentPage);
		paging.setDetailCondition(detailCondition);
		List<ProjectVO> projectList = adminProjectService.projectRestoreList(paging);
		
		int newTotal = adminProjectService.retriveNewTotalCnt();
		int quickTotal = adminProjectService.retriveQuickTotalCnt();
		int safeTotal = adminProjectService.retriveSafeTotalCnt();
		int delTotal = adminProjectService.retriveDelTotalCnt();
		model.addAttribute("newTotal", newTotal);
		model.addAttribute("quickTotal", quickTotal);
		model.addAttribute("safeTotal", safeTotal);
		model.addAttribute("delTotal", delTotal);
		
		model.addAttribute("projectList", projectList);
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML", pagingHTML);
		model.addAttribute("paging", paging);
		if (ing.equals("end")) { // 마감된
			detailCondition.put("ing", "end");
			ing = "end";
		} else {
			detailCondition.put("ing", "ing");
		}
		return "admin/project/adminProjectList";
	}

	@PutMapping("/project")
	public String projectRestoreController(@RequestBody List<ProjectVO> modifyProject, Errors error, Model model) {

		log.info("modifyProject : {}", modifyProject);
		log.info("error : {}", error);
		if (modifyProject.size() == 0) {
			model.addAttribute("msg", "empty");
		} else {
			int cnt = adminProjectService.projectCheckedRestore(modifyProject);
			if (cnt > 0) {
				model.addAttribute("msg", "ok");
			} else {
				model.addAttribute("msg", "fail");
			}
		}
		return "jsonView";
	}

	@DeleteMapping("/project")
	public String projectDeleteController(@RequestBody List<ProjectVO> deleteProject, Errors error, Model model) {

		log.info("modifyProject : {}", deleteProject);
		log.info("error : {}", error);
		if (deleteProject.size() == 0) {
			model.addAttribute("msg", "empty");
		} else {
			int cnt = adminProjectService.projectCheckedDelete(deleteProject);
			if (cnt > 0) {
				model.addAttribute("msg", "ok");
			} else {
				model.addAttribute("msg", "fail");
			}
		}
		return "jsonView";
	}

}
