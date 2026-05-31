package kr.or.navi.admin.emp.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.navi.admin.emp.service.AdminEmpService;
import kr.or.navi.common.paging.BootstrapFormBasePaginationRenderer;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.common.paging.PaginationRenderer;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminEmpController {
	@Inject
	private AdminEmpService service;

	@GetMapping("emp")
	public String empPage(@RequestParam Map<String, Object> detailCondition,
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(name = "pms", required = false, defaultValue = "") String pms, Model model) {
		if (pms.equals("")) {
			// 파라미터가 없고 pms 사원 조회를 안함
			detailCondition.put("pms", "");
		} else {
			// 파라미터가 있고 pms 사원조회를 함
			detailCondition.put("pms", "pms");
		}
		log.info("detailCondition : {}", detailCondition);
		
		PaginationInfo paging = new PaginationInfo(7, 5);
		paging.setCurrentPage(currentPage);
		paging.setDetailCondition(detailCondition);
		List<EmpVO> empList = service.retrieveEmpList(paging);
		model.addAttribute("empList", empList);
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML", pagingHTML);
		log.info("pagingHTML : {}", pagingHTML);
		model.addAttribute("paging", paging);
		return "admin/emp/adminEmpList";
	}

	@GetMapping("emp/invite")
	public String empInvitePage(@RequestParam Map<String, Object> detailCondition,
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(name = "notpms", required = false, defaultValue = "") String notpms, Model model) {
		detailCondition.put("notpms", "notpms");
		log.info("detailCondition : {}", detailCondition);
		PaginationInfo paging = new PaginationInfo(7, 5);
		paging.setCurrentPage(currentPage);
		paging.setDetailCondition(detailCondition);
		List<EmpVO> empList = service.retrieveEmpList(paging);
		
		model.addAttribute("empList", empList);
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML", pagingHTML);
		log.info("pagingHTML : {}", pagingHTML);
		model.addAttribute("paging", paging);
		return "admin/emp/adminEmpInvite";
	}

	@PutMapping("emp/invite")
	public String empInvitePage(@RequestBody List<EmpVO> inviteEmp, Errors error, Model model) {
		log.info("inviteEmp : {}", inviteEmp);
		log.info("error : {}", error);
		if (inviteEmp.size() == 0) {
			model.addAttribute("msg", "empty");
		} else {
			int cnt = service.inviteCheckedEmp(inviteEmp);
			if (cnt > 0) {
				model.addAttribute("msg", "ok");
			} else {
				model.addAttribute("msg", "fail");
			}
		}
		return "jsonView";
	}

	@GetMapping("emp/empo")
	public String empEmpowermentPage(@RequestParam Map<String, Object> detailCondition,
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(name = "pms", required = false, defaultValue = "emp") String pms, Model model) {
		detailCondition.put("pms", "pms");
		log.info("detailCondition : {}", detailCondition);
		PaginationInfo paging = new PaginationInfo(7, 5);
		paging.setCurrentPage(currentPage);
		paging.setDetailCondition(detailCondition);
		List<EmpVO> empList = service.retrieveEmpList(paging);
		model.addAttribute("empList", empList);
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML", pagingHTML);
		log.info("pagingHTML : {}", pagingHTML);
		model.addAttribute("paging", paging);
		return "admin/emp/adminEmpEmpowerment";
	}

	@PostMapping("emp/empo")
	public String empEmpowermentController(@RequestParam("empId") String empId, @RequestParam("roleId") String roleId,
			Model model) {
		log.info("empId : {}", empId);
		log.info("roleId : {}", roleId);
		int cnt = service.modifyEmpRole(empId, roleId);
		if (cnt > 0) {
			model.addAttribute("msg", "ok");
		} else {
			model.addAttribute("msg", "fail");
		}
		return "jsonView";
	}

	@GetMapping("emp/block")
	public String empBlockingPage(@RequestParam Map<String, Object> detailCondition,
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(name = "pms", required = false, defaultValue = "") String pms, 
			@RequestParam(name = "block", required = false, defaultValue = "") String block, 
			@RequestParam(name = "notblock", required = false, defaultValue = "") String notblock, 
			Model model) {
		// 파라미터가 있고 pms 사원조회를 함
		detailCondition.put("pms", "pms");
		if (block.equals("")) {
			detailCondition.put("notblock", "notblock");
		} else {
			detailCondition.put("block", "block");
		}
		log.info("detailCondition : {}", detailCondition);
		PaginationInfo paging = new PaginationInfo(7, 5);
		paging.setCurrentPage(currentPage);
		paging.setDetailCondition(detailCondition);
		List<EmpVO> empList = service.retrieveEmpList(paging);
		model.addAttribute("empList", empList);
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML", pagingHTML);
		log.info("pagingHTML : {}", pagingHTML);
		model.addAttribute("paging", paging);
		return "admin/emp/adminEmpBlocking";
	}

	@PutMapping("emp/block")
	public String empRestorationController(@RequestBody List<EmpVO> restoreEmp, Errors error, Model model) {

		log.info("modifyProject : {}", restoreEmp);
		log.info("error : {}", error);
		if (restoreEmp.size() == 0) {
			model.addAttribute("msg", "empty");
		} else {
			int cnt = service.empCheckRestore(restoreEmp);
			if (cnt > 0) {
				model.addAttribute("msg", "ok");
			} else {
				model.addAttribute("msg", "fail");
			}
		}
		return "jasonView";
	}

	@DeleteMapping("emp/block")
	public String empBlockController(@RequestBody List<EmpVO> blockEmp, Errors error, Model model) {

		log.info("modifyProject : {}", blockEmp);
		log.info("error : {}", error);
		if (blockEmp.size() == 0) {
			model.addAttribute("msg", "empty");
		} else {
			int cnt = service.empCheckDelete(blockEmp);
			if (cnt > 0) {
				model.addAttribute("msg", "ok");
			} else {
				model.addAttribute("msg", "fail");
			}
		}
		return "jasonView";
	}

}
