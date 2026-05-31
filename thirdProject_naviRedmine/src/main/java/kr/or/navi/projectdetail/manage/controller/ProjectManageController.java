package kr.or.navi.projectdetail.manage.controller;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.navi.common.paging.BootstrapFormBasePaginationRenderer;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.common.paging.PaginationRenderer;
import kr.or.navi.project.dao.TeamDAO;
import kr.or.navi.project.service.ProjectService;
import kr.or.navi.security.RealUser;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.ProjectVO;
import kr.or.navi.vo.TeamVO;
import lombok.extern.slf4j.Slf4j;
@Controller
@RequestMapping("/project")
@Slf4j
public class ProjectManageController {
	@Inject
	private ProjectService service;
	
	//수정 페이지
	@GetMapping("manage/{proId}")
	public String managePage(@PathVariable(name = "proId") String proId,Model model) {
		ProjectVO project = service.projectOne(proId);
		LocalDateTime proRD = project.getProRegDt();
		LocalDateTime proDE = project.getProDdlineEx();
		log.info("proRD : {} ",proRD);
		log.info("proDE : {} ",proDE);
		log.info("project : {} ",project);
		
		model.addAttribute("project", project);
		return "project/manage/manage";
	}
	
	//프로젝트 PL 확인절차
	@PostMapping("manage/{proId}/auth")
	public String manageAuth(@PathVariable(name = "proId") String proId, RedirectAttributes redirectAttributes,@RealUser EmpVO vo) {
		ProjectVO project = service.projectOne(proId);
		log.info("proId : {}",project.getEmpId());
		log.info("empId : {}",vo.getEmpId());
		//프로젝트 권한을 읽는다.
		boolean auth = service.authPL(vo, project);
		log.info("PL관리자 성공 여부 확인 : {}",auth);
		if(auth) {
			return "redirect:/project/manage/"+proId;
		}else {
			redirectAttributes.addFlashAttribute("auth",auth);
			return "redirect:/project";
		}
	}
	
	//접근권한 페이지
	@GetMapping("conect/{proId}")
	public String managePage1(@PathVariable(name = "proId") String proId
			,@RequestParam Map<String, Object> detailCondition
			, @RequestParam(name="page", required = false, defaultValue = "1") int currentPage
			,Model model) {
		ProjectVO project = service.projectOne(proId);
		model.addAttribute("project", project);
		log.info("project : {}",project);
		PaginationInfo paging = new PaginationInfo(10,10);
		paging.setCurrentPage(currentPage);
		paging.setDetailCondition(detailCondition);
		
		
		List<TeamVO> teamList = service.retrieveTeamList(paging,proId);
		model.addAttribute("teamList", teamList);
		log.info("teamList : {}",teamList);
		
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML",pagingHTML);
		model.addAttribute("paging",paging);
		return "project/manage/conect";
	}
	
	@PostMapping("conect/{proId}/{empId}")
	public String manageRoleModController(@PathVariable String proId,@PathVariable String empId,Model model) {
		log.info("empId : {}",empId);
		log.info("proId : {}",proId);
		int cnt = service.modifyTeamYN(proId, empId);
		if(cnt>0) {
			model.addAttribute("msg", "ok");
		}else {
			model.addAttribute("msg", "fail");
		}
		return "jsonView";
	}
	@GetMapping("invite/{proId}")
	public String managePage2(@PathVariable(name="proId") String proId
			,@RequestParam Map<String, Object> detailCondition
			, @RequestParam(name="page", required = false, defaultValue = "1") int currentPage
			,Model model) {
	
		PaginationInfo paging = new PaginationInfo(10,10);
		paging.setCurrentPage(currentPage);
		paging.setDetailCondition(detailCondition);
		List<EmpVO> outEmp = service.selectOutEmpList(proId,paging);
		model.addAttribute("outEmp", outEmp);
		log.info("outEmp : {}",outEmp);
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML",pagingHTML);
		model.addAttribute("paging",paging);
		return "project/manage/invite";
	}
	
	
	
	@PostMapping("invite/{proId}/{empId}")
	@ResponseBody
	public String inviteController(@RequestBody EmpVO empVO,@PathVariable String proId) {
		log.info("empVO : {}",empVO);
		int cnt = service.createTeam(empVO,proId);
		if(cnt>0) {
			return "ok";
		}else {
			return "false";
		}
	}
}
