package kr.or.navi.projectdetail.issue.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.validation.groups.Default;

import org.apache.commons.collections.map.HashedMap;
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
import kr.or.navi.mypage.service.MypageService;
import kr.or.navi.project.service.ProjectService;
import kr.or.navi.projectdetail.dashboard.controller.ProjectDashBaordController;
import kr.or.navi.projectdetail.issue.controller.service.IssueService;
import kr.or.navi.security.RealUser;
import kr.or.navi.validate.UpdateGroup;
import kr.or.navi.vo.BookmarkIssueVO;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.IssueCommentVO;
import kr.or.navi.vo.IssueFileVO;
import kr.or.navi.vo.IssueVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/project/issue")
@Slf4j
public class ProjectIssueController {
	@Inject
	public SseEmitters message;
	@Inject
	public ProjectService projectService;
	
	@Inject
	private MypageService mservice;
	
	@Inject
	private IssueService service;
	
	//페이징 처리 및 목록 조회
	@GetMapping("{proId}")
	public String issuePage(@PathVariable(name = "proId") String proId
			,@RequestParam Map<String, Object> detailCondition
			, @RequestParam(name="page", required = false, defaultValue = "1") int currentPage
			,@RealUser EmpVO realUser
			,Model model) {
		String empId = realUser.getEmpId();
		List<BookmarkIssueVO> bkList = mservice.retriveBookMarkIssueList(empId,proId);
		model.addAttribute("bkList", bkList);
		PaginationInfo paging = new PaginationInfo(10,10);
		paging.setCurrentPage(currentPage);
		paging.setDetailCondition(detailCondition);
		List<IssueVO> issueList = projectService.issueList(proId, paging);
		List<IssueVO> all = projectService.issueList(proId,new PaginationInfo());
		Map<String, Integer> issueComp = issueComp(all);
		model.addAttribute("comp", issueComp);
		model.addAttribute("issueList",issueList);
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML",pagingHTML);
		model.addAttribute("paging",paging);
		return "project/issue/issue";
	}
	public Map<String,Integer> issueComp(List<IssueVO> list){
		Map<String, Integer> map = new HashedMap();
		map.put("IG0001", 0);
		map.put("IG0002", 0);
		map.put("IG0003", 0);
		map.put("IG0004", 0);
		map.put("IG0005", 0);
		for(IssueVO is : list) {
			map.put(is.getClsfcId(), map.get(is.getClsfcId())+1);
		}
		return map;
	}
	@PostMapping("file/del/{issffId}")
	@ResponseBody
	public Map<String, String> isssueFileDelController(@PathVariable String issffId) throws IOException {
		int cnt = service.removeIssueFile(issffId);
		Map<String, String> msg = new HashedMap();
		if(cnt>0) {
			msg.put("msg", "ok");
		}else {
			msg.put("msg", "fail");
		}
		return msg;
	}
	
	//단건 조회 상세페이지
	@GetMapping("detail/{proId}/{issueId}")
	public String issueDetail(@PathVariable(name = "proId") String proId,@PathVariable(name = "issueId") String issueId, Model model) {
		IssueVO issue = service.selectIssueOne(issueId);
		List<IssueCommentVO> commentList = service.retrieveIssueCommentList(issueId);
		log.info("commentList :{}",commentList);
		model.addAttribute("issue", issue);
		model.addAttribute("commentList", commentList);
		List<IssueFileVO> fileList = service.retriveFileList(issueId);
		model.addAttribute("fileList", fileList);
		log.info("cmList : {}",commentList);
		return "project/issue/issueDetail";
	}
	
	@PostMapping("comment/reg")
	@ResponseBody
	public String issueInsertCommentController(
			@RequestBody IssueCommentVO icVO
			,@RealUser EmpVO realUser
			, Errors error
			, Model model) 
	{
		log.info("icVO : {}",icVO);
		icVO.setIcRegId(realUser.getEmpId());
		int cnt = service.createIssueComment(icVO);
		if(cnt>0) {
			return "ok";
		}else {
			return "fail";
		}
	}
	
	//단건 조회 댓글 삭제
	@DeleteMapping("delcomment")
	public String issueDeleteCommentController(@RequestParam String icId, Model model) {
		
		log.info("icId : {}",icId);
		int cnt = service.removeIssueComment(icId);
		if (cnt > 0) {
			model.addAttribute("msg", "ok");
		} else {
			model.addAttribute("msg", "fail");
		}
		return "jsonView";
	}
	
	//수정 페이지
	@GetMapping("modify/{proId}/{issueId}")
	public String issueModify(@PathVariable(name = "proId") String proId,@PathVariable(name = "issueId") String issueId, Model model) {
		IssueVO issue = service.selectIssueOne(issueId);
		issue.setProId(proId);
		model.addAttribute("issue", issue);
		List<IssueFileVO> fileList = service.retriveFileList(issueId);
		model.addAttribute("fileList", fileList);
		return "project/issue/issueModify";
	}
	
	//수정 비동기 처리
	@PostMapping("modfiy/{issueId}")
	public String issueModifyController(@ModelAttribute IssueVO modifytIssue, @PathVariable("issueId") String issueId,Model model,@RealUser EmpVO realUser) throws IOException {
		log.info("modifytIssue : {}",modifytIssue );
		modifytIssue.setIssueId(issueId);
		int cnt = service.modifyIssue(modifytIssue);
		if(cnt>0) {
			message.issueMod(realUser, issueId);
			return "redirect:/project/issue/detail/"+modifytIssue.getProId()+"/"+modifytIssue.getIssueId();
		}else {
			return "project/issue/issueModify";
		}
	}
	
	//삭제 비동기처리
	@DeleteMapping("{issueId}")
	public String issueDeleteController(@PathVariable("issueId") String issueId,Model model,@RealUser EmpVO realUser) {
		int cnt = service.removeIssue(issueId);
		String msg="";
		if(cnt>0) {
			message.issueDel(realUser, issueId);
			msg="ok";
		}else {
			msg="fail";
		}
		model.addAttribute("msg", msg);
		return "jsonView";
	}
	
	//등록페이지
	@GetMapping("register/{proId}")
	public String issueRegister(@PathVariable String proId, @ModelAttribute IssueVO issue,@RealUser EmpVO realUser,Model model) {
		model.addAttribute("realUser",realUser);
		return "project/issue/issueRegister";
	}
	
	//등록 비동기 처리
	@PostMapping("register/{proId}")
	public String issueRegisterController(@PathVariable String proId,@Validated(Default.class) @ModelAttribute IssueVO issue,Errors error, @RealUser EmpVO realUser,Model model) throws IOException {
		log.info("issue : {}",issue);
		log.info("error : {}",error);
		issue.setProId(proId);
		model.addAttribute("realUser",realUser);
		model.addAttribute("msg", "필수항목을 입력해 주세요");
		if(!error.hasErrors()) {
			int cnt = service.createIssue(issue);
			if(cnt>0) {
				message.issueReg(realUser, issue.getIssueId());
				return "redirect:/project/issue/"+proId;
			}else {
				return "project/issue/issueRegister";
			}
		}else {
			return "project/issue/issueRegister";
		}
		
	}
	
	@GetMapping("download/{issfId}")
	public ResponseEntity<Resource> downloadFile(@PathVariable String issfId) throws IOException{
		return service.downloadFile(issfId);
	}
}
