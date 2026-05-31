package kr.or.navi.project.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.validation.groups.Default;

import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.annotations.Param;
import org.springframework.security.access.prepost.PreAuthorize;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.navi.common.paging.BootstrapFormBasePaginationRenderer;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.common.paging.PaginationRenderer;
import kr.or.navi.project.dao.TeamDAO;
import kr.or.navi.project.service.ProjectService;
import kr.or.navi.projectdetail.gantt.service.GanttServiceImpl;
import kr.or.navi.projectdetail.gantt.vo.GanttEventVO;
import kr.or.navi.security.RealUser;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.IssueVO;
import kr.or.navi.vo.ProjectVO;
import kr.or.navi.vo.TeamVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/project")
public class ProjectController {
	
//	public static class TestUtils{
//		public static boolean authorize(Authentication authentcation, String projId) {
//			return true;
//		}
//	}
	
	@Inject
	public TeamDAO teamDao;
	/** 프로젝트 서비스
	 * 
	 */
	@Inject
	public ProjectService projectService;
	/**
	 * 프로젝트 목록을 조회하는 페이지 컨트롤러
	 * @param ing 진행중인 프로젝트인지 마감한 프로젝트인지 확인하기 위한 파라미터
	 * @param detailCondition 검색조건 을 확인하기 위한 파라미터
	 * @param currentPage 현재 요청보낸 페이지가 몇번째 페이지인지 확인하기 위한 컨트롤러
	 * @param emp 현제 보낸 요청에서 세션에 저장된 principal 객체
	 * @param model 데이터를 담아 view(jsp)까지 전달하기 위한 객체
	 * @return
	 */
	@GetMapping
//	@PreAuthorize("T(kr.or.navi.project.controller.ProjectController.TestUtils).authorize(authentication, projId)")
	public String list(
			@RequestParam(value = "ing",required = false, defaultValue = "ing") String ing
			,@RequestParam Map<String, Object> detailCondition
			, @RequestParam(name="page", required = false, defaultValue = "1") int currentPage
			,@RealUser EmpVO emp
			,Model model) {
		// 세션정보를 model에 담아 view로 전달
		model.addAttribute("realUser", emp);
		log.info("detailCondition : {}",detailCondition);
		// 페이징 처리를 위한 객체
		PaginationInfo paging = new PaginationInfo(10,10);
		paging.setCurrentPage(currentPage);
		paging.setDetailCondition(detailCondition);
		//현재 진행중인 프로젝트를 전체 조회하여 대시보드화면 구성
		Map<String, Object> projectTo = projectService.projectAllIng();
		model.addAttribute("projectTo", projectTo);
		//페이징에 보여줄 프로젝트 리스트 조회
		List<ProjectVO> projectList = projectService.projectList(paging);
		model.addAttribute("projectList", projectList);
		// 현재 요청보낸 클라이언트가 참여중인 프로젝트를 확인하기 위해 메서드 실행
		participateProjectMap(projectList, emp);
		// 페이징 처리를 위한 html 생성 객체
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML",pagingHTML);
		model.addAttribute("paging",paging);
		return "project/projectList";
	}
	/**
	 * 프로젝트중 요청을 보낸 클라이언트가 해당 프로젝트를 참여하고 있는지 확인하는 메서드
	 * {@link ProjectVO} 안에 myProject 필드 변수를 통해 해당 프로젝트에 참여하고 있다면 "ok"를 보내 jsp에서 조건문을 통해 확인
	 * @param projectList 현재 조회된 프로젝트 목록
	 * @param realUser 세션에 저장되어 있는 유저
	 */
	public void participateProjectMap(List<ProjectVO> projectList, EmpVO realUser){
		if(!projectList.isEmpty()) {
			for(ProjectVO vo : projectList) {
				List<TeamVO> teamList = teamDao.selectTeamAll(vo.getProId());
				for(TeamVO team : teamList) {
					if(team.getEmpId().equals(realUser.getEmpId())) {
						vo.setMyProject("ok");
					}
				}
			}
		}
	}
	/**
	 * 프로젝트 등록을 위한 페이지 요청 컨트롤러
	 * @param registerProject 등록을 위한 비어있는 projectVO
	 * @param model 데이터를 담기 위한 model 객체
	 * @param realUser 세션에 저장된 유저
	 * @return jsp 경로
	 */
	@GetMapping("/register.do")
	public String projectRegsterPage(@ModelAttribute("registerProject") ProjectVO registerProject, Model model,@RealUser EmpVO realUser) {
		List<EmpVO> empList = projectService.selectEmpList();
		model.addAttribute("realUser",realUser);
		model.addAttribute("empList",empList);
		model.addAttribute("title","프로젝트 등록");
		return "project/projectRegister";
	}
	/**
	 * PMS 사원 전체 조회 리스트
	 * @return 사원정보를 담고 있는 리스트
	 */
	@PostMapping("emp/list")
	@ResponseBody
	public List<EmpVO> getEmpList(){
		return projectService.selectEmpList();
	}
	/**
	 * 등록페이지에서 입력된 정보를 통해 에러 검출 및 등록하는 컨트롤러
	 * @param registerProject 입력된 정보를 담고 있는 projectVO (hibernate-validator 를 통한 검증을 거침)
	 * @param error 잘못된 정보를 입력하였거나 필수 값이 입력되지 않았을 경우 정보를 가지고 있는 객체
	 * @param empIds 등록을 위한 사원번호를 담고 있는 문자열
	 * @param roleIds 등록을 위한 권한 정보를 담고 있는 문자열
	 * @param realUser 등록 요청을 보낸 클라이언트
	 * @param model 
	 * @param redirectAttributes validate를 통한 검증은 통과했으나 팀원 정보를 입력하지 않았을 경우 세션을 통해 에러 메세지르 보내줌
	 * @return
	 */
	@PostMapping("/register.do")
	public String projectRegster(@Validated(Default.class) @ModelAttribute("registerProject") ProjectVO registerProject, Errors error,@RequestParam("empIds") String empIds,@RequestParam("roleIds") String roleIds,@RealUser EmpVO realUser,Model model ,RedirectAttributes redirectAttributes) {
		log.info("empIds : {}",empIds);
		log.info("registerProject : {}",registerProject);
		model.addAttribute("realUser",realUser);
		if(!error.hasErrors()&& StringUtils.isNotBlank(empIds)&&StringUtils.isNotBlank(roleIds)) {
			int cnt = projectService.createProject(registerProject,empIds,roleIds,realUser);
			if(cnt>0) {
				return "redirect:/project";
			}else {
				return "project/projectRegister";
			}
		}else {
			if(StringUtils.isNotBlank(empIds)&&StringUtils.isNotBlank(roleIds)) {
				redirectAttributes.addFlashAttribute("msg", "팀원을 선택해 주세요");
			}
			redirectAttributes.addFlashAttribute("title","프로젝트 등록");
			return "project/projectRegister";
		}
	}
	
	/**
	 * 프로젝트 수정을 위한 컨트롤러
	 * @param modifyProject 프로젝트 수정 정보를 가지고 있는 vo
	 * @param model 정보를 담고 jsp 로 이동하기 위한 객체
	 * @return 
	 */
	@PutMapping
	public String projectModifyController(@RequestBody ProjectVO modifyProject, Model model) {
		log.info("modifyProject : {}",modifyProject);
		int cnt = projectService.modifyProject(modifyProject);
		if(cnt>0) {
			model.addAttribute("msg","ok");	
		}else {
			model.addAttribute("msg","fail");
		}
		return "jsonView";
	}
	/**
	 * @param deleteProject 삭제될 프로젝트 정보를 담고 있는 projectVO
	 * @param model 정보를 담고 jsp 로 이동하기 위한 객체
	 * @return
	 */
	@DeleteMapping
	public String projectDeleteController(@RequestBody ProjectVO deleteProject, Model model) {
		log.info("modifyProject : {}",deleteProject);
		int cnt = projectService.projectDelete(deleteProject);
		if(cnt>0) {
			model.addAttribute("msg","ok");	
		}else {
			model.addAttribute("msg","fail");
		}
		return "jsonView";
	}
	
	/**
	 * 마감처리를 위한 컨트롤러
	 * @param proId 마감할 프로젝트의 id 정보
	 * @return
	 */
	@PostMapping("end/{proId}")
	@ResponseBody
	public String projectEndController(@PathVariable String proId) {
		int cnt = projectService.endProject(proId);
		if(cnt>0) {
			return "ok";
		}else {
			return "fail";
		}
	}
}
