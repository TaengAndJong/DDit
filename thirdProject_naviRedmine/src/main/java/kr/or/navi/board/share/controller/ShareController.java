package kr.or.navi.board.share.controller;

import java.io.IOException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.lang3.StringUtils;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
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
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.navi.alarm.service.SseEmitters;
import kr.or.navi.board.share.service.ShareService;
import kr.or.navi.common.paging.BootstrapFormBasePaginationRenderer;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.common.paging.PaginationRenderer;
import kr.or.navi.common.paging.SearchCondition;
import kr.or.navi.mypage.service.MypageService;
import kr.or.navi.security.RealUser;
import kr.or.navi.validate.InsertGroup;
import kr.or.navi.vo.BoardCommentVO;
import kr.or.navi.vo.BoardPostFileVO;
import kr.or.navi.vo.BoardPostVO;
import kr.or.navi.vo.BookmarkBoardVO;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.IssueCommentVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board/share")
public class ShareController {
	@Inject
	private SseEmitters msg;
	
	@Inject
	private ShareService service;
	
	@Inject
	private MypageService mservice;
	
	@GetMapping
	public String sharePage(
		@RealUser EmpVO realUser
		,@RequestParam(name="page", required = false, defaultValue = "1") int currentPage
		,Model model, @ModelAttribute("simpleCondition") SearchCondition simpleCondition
	) {
		String empId = realUser.getEmpId();
		List<BookmarkBoardVO> bkList = mservice.retriveBookMarkBoardList(empId);
		model.addAttribute("bkList", bkList);
		
		List<BoardPostVO> anoList = service.retrieveAnoListBoard();
		model.addAttribute("anoList",anoList);
		newCheck(anoList);
//		log.info("simpleCondition : {}",simpleCondition);
		PaginationInfo paging = new PaginationInfo(10,10);
		paging.setCurrentPage(currentPage);
		paging.setSimpleCondition(simpleCondition);
		List<BoardPostVO> shareList = service.retrieveShareList(paging);
		model.addAttribute("shareList",shareList);
		newCheck(shareList);
		Map<String, Integer> shareCntTotal = service.shareCntTotal();
//		log.info("shareCntTotal:{}",shareCntTotal.get("SCOUNT") + "/" + shareCntTotal.get("TCOUNT"));
		model.addAttribute("shareCntTotal", shareCntTotal.get("SCOUNT") + "/" + shareCntTotal.get("TCOUNT"));
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML",pagingHTML);
		model.addAttribute("paging",paging);
		return "board/share";
	}
	
	
	/**
	 * 새로 등록된 게시글 표시
	 * @param shareList
	 */
	private void newCheck(List<BoardPostVO> shareList) {
		LocalDateTime now = LocalDateTime.now();
		for(BoardPostVO vo : shareList) {
			LocalDateTime bpRegDt = vo.getBpRegDt();
	        Duration duration = Duration.between(bpRegDt, now); //현재 시간 저장
	        long days = duration.toDays();
	        if (days >= 1) {
	        	vo.setNowCheck("1");
	        }
		}
	}

	@GetMapping("{bpId}")
	public String shareDetailPage(@PathVariable String bpId, Model model) {
		BoardPostVO share = service.retrieveShare(bpId);
		List<BoardCommentVO> commentList = service.retrieveBoardCommentList(bpId);
//		log.info("commentList :{}",commentList);
		model.addAttribute("share", share);
		model.addAttribute("commentList", commentList);
		List<BoardPostFileVO> bpfv = service.retrieveShareFile(bpId);
//		log.info("bpfv:{}",bpfv);
		model.addAttribute("bpfv", bpfv);
		service.viewCnt(bpId);
		return "board/share_detail";
	}
	
	@PostMapping("comment/reg")
	@ResponseBody
	public String boardInsertCommentController(
			@RequestBody BoardCommentVO bcVO
			,@RealUser EmpVO realUser
			, Errors error
			, Model model) 
	{
//		log.info("bcVO : {}",bcVO);
		bcVO.setEmpId(realUser.getEmpId());
		int cnt = service.createBoardComment(bcVO);
		if(cnt>0) {
			msg.boardReg(realUser, bcVO.getBpId(),"A00009");
			return "ok";
		}else {
			return "fail";
		}
	}
	
	@DeleteMapping("delcomment")
	public String boardDeleteCommentController(@RequestParam String bcId, Model model) {
//		log.info("bcId : {}",bcId);
		int cnt = service.removeBoardComment(bcId);
		if (cnt > 0) {
			model.addAttribute("msg", "ok");
		} else {
			model.addAttribute("msg", "fail");
		}
		return "jsonView";
	}
	
	
	
	
	
	
	
	@GetMapping("download/{bpFileId}")
	public ResponseEntity<Resource> downloadFile(@PathVariable String bpFileId) throws IOException{
		return service.downloadFile(bpFileId);
	}

	
	@GetMapping("/mod/{bpId}")
	public String formModPage(@PathVariable("bpId") String bpId, Model model) {
		BoardPostVO updateForm = service.retrieveShare(bpId);
		model.addAttribute("share", updateForm);
		List<BoardPostFileVO> bpfv = service.retrieveShareFile(bpId);
		log.info("bpfv:{}",bpfv);
		model.addAttribute("bpfv", bpfv);
		
		return "board/share_mod";
	}
	
	@PostMapping("mod/{bpId}")
	@ResponseBody
	public Map<String, String> sharePutController(
			@ModelAttribute("share")
			BoardPostVO updateShare, 
			@PathVariable String bpId, Model model, @RealUser EmpVO realUser) throws IOException {
		Map<String, String> msg = new HashMap<String, String>();
		if(StringUtils.isNotBlank(updateShare.getBpCn()) && StringUtils.isNotBlank(updateShare.getBpTitle())) {
			updateShare.setBpId(bpId);
			updateShare.setEmpId(realUser.getEmpId());
			
			int cnt = service.modifyShare(updateShare);
			if(cnt>0) {
				log.info("bpId : {}",bpId);
				msg.put("msg", "ok");
			}else {
				msg.put("msg", "fail");
			}
		}else {
			msg.put("msg", "fail");
		}
		return msg;
	}
	
	@DeleteMapping("del/{bpId}")
	public String shraeDelController(@PathVariable String bpId, Model model,@RealUser EmpVO realUser) {
		log.info("bpId:{}",bpId);
		int cnt = service.removeShare(bpId);
		if(cnt>0) {
			model.addAttribute("msg", "ok");
			message.boardDel(realUser, bpId);
		}else {
			model.addAttribute("msg", "fail");
		}
		return "jsonView";
	}
	
	
	@GetMapping("/add")
	public String shareRegisterPage(
				@ModelAttribute("fileVO") BoardPostFileVO fileVO
			,@ModelAttribute("share") BoardPostVO vo, Model model) {
		return "board/share_register";
	}
	@Inject
	private SseEmitters message;
	
	@PostMapping("/add")
	public String shareAddController(
			@Validated(InsertGroup.class) @ModelAttribute("share") BoardPostVO vo, Errors errors, Model model, @RealUser EmpVO realUser
			,@RequestPart(value="files", required = false) MultipartFile[] files //파일을 받음
			) throws IOException {
		log.info("share : {}",vo);
		log.info("files: {}", files);
		log.info("realUser:{}", realUser);
		
		if(!errors.hasErrors()) {
			vo.setEmpId(realUser.getEmpId()); //사원정보 바인딩
			
			int cnt = service.createShare(vo);
			if(cnt>0) {
				message.boardReg(realUser, vo.getBpId(),"A00009"); //유효성 검사
				return "redirect:/board/share";
			}else {
				return  "board/share_register";
			}
		}else {
			return "board/share_register";
		}
	}
	
	@PostMapping("file/del/{bpFileId}")
	@ResponseBody
	public Map<String, String> boardPostFileDelController(@PathVariable String bpFileId) throws IOException {
		int cnt = service.removeBoardPostFile(bpFileId);
		Map<String, String> msg = new HashedMap();
		if(cnt>0) {
			msg.put("msg", "ok");
		}else {
			msg.put("msg", "fail");
		}
		return msg;
	}
}


