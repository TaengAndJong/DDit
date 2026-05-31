package kr.or.navi.board.qna.controller;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
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

import kr.or.navi.alarm.service.SseEmitters;
import kr.or.navi.board.qna.service.QnaService;
import kr.or.navi.common.paging.BootstrapFormBasePaginationRenderer;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.common.paging.PaginationRenderer;
import kr.or.navi.common.paging.SearchCondition;
import kr.or.navi.mypage.service.MypageService;
import kr.or.navi.security.RealUser;
import kr.or.navi.validate.InsertGroup;
import kr.or.navi.vo.BoardPostVO;
import kr.or.navi.vo.BookmarkBoardVO;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board/qna")
public class QnaController {
	
	@Inject
	private QnaService service;
	
	@Inject
	private MypageService mservice;
	@Inject
	private SseEmitters message;
	@GetMapping
	public String qnaPage(
			@RealUser EmpVO realUser
			,@RequestParam(name="page", required = false, defaultValue = "1") int currentPage
			, Model model
			, @ModelAttribute("simpleCondition") SearchCondition simpleCondition
			) {
		String empId = realUser.getEmpId();
		List<BookmarkBoardVO> bkList = mservice.retriveBookMarkBoardList(empId);
		model.addAttribute("bkList", bkList);
		List<BoardPostVO> anoList = service.retrieveAnoListBoard();
		model.addAttribute("anoList",anoList);
		newCheck(anoList);
		PaginationInfo paging = new PaginationInfo(10,10);
		paging.setSimpleCondition(simpleCondition);
		paging.setCurrentPage(currentPage);
		List<BoardPostVO> qnaList = service.retrieveQnaList(paging);
		model.addAttribute("qnaList", qnaList);
		newCheck(qnaList);
		Map<String, Integer> qnaCntTotal = service.qnaCntTotal();
		log.info("qnaCntTotal:{}",qnaCntTotal.get("QCOUNT") + "/" + qnaCntTotal.get("TCOUNT"));
		model.addAttribute("qnaCntTotal", qnaCntTotal.get("QCOUNT") + "/" + qnaCntTotal.get("TCOUNT"));
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML", pagingHTML);
		model.addAttribute("paging", paging);
		return "board/qna";
	}

	private void newCheck(List<BoardPostVO> qnaList) {
		LocalDateTime now = LocalDateTime.now();
		for(BoardPostVO vo : qnaList) {
			LocalDateTime bpRegDt = vo.getBpRegDt();
	        Duration duration = Duration.between(bpRegDt, now);
	        long days = duration.toDays();
	        if (days >= 1) {
	        	vo.setNowCheck("1");
	        }
		}
	}
	
	@GetMapping("{bpId}")
	public String qnaDetailPage(@PathVariable String bpId, Model model) {
		BoardPostVO qna = service.retrieveQna(bpId);
		model.addAttribute("qna", qna);
		
		service.viewCnt(bpId);
		
		return "board/qna_detail";
	}
	
	@GetMapping("/mod/{bpId}")
	public String qnaModPage(@PathVariable("bpId") String bpId, Model model) {
		BoardPostVO qnaForm = service.retrieveQna(bpId);
		model.addAttribute("qna", qnaForm);
		return "board/qna_mod";
	}

	@PutMapping("mod/{bpId}")
	public String qnaModController(@RequestBody BoardPostVO updateQna, @PathVariable String bpId, Model model, @RealUser EmpVO realUser ) {
		log.info("updateQna:{}", updateQna);
		
		if(StringUtils.isNotBlank(updateQna.getBpCn()) && StringUtils.isNotBlank(updateQna.getBpTitle())) {
			updateQna.setBpId(bpId);
			updateQna.setEmpId(realUser.getEmpId());
			int cnt = service.modifyQna(updateQna);
			if(cnt>0) {
				model.addAttribute("msg", "ok");
			}else {
				model.addAttribute("msg", "fail");
			}
		}else {
			model.addAttribute("msg", "empty");
		}
		
		return "jsonView";
	}
	
	@DeleteMapping("del/{bpId}")
	public String qnaDelController(@PathVariable String bpId, Model model) {
		log.info("bpId:{}",bpId);
		int cnt = service.removeQna(bpId);
		if(cnt>0) {
			model.addAttribute("msg", "ok");
		}else {
			model.addAttribute("msg", "fail");
		}
		return "jsonView";
	}
	
	@GetMapping("/add")
	public String qnaRegisterPage(@ModelAttribute("qna") BoardPostVO vo, Model model) {
		return "board/qna_register";
	}
	
	@PostMapping("/add")
	public String qnaAddController(@Validated(InsertGroup.class) @ModelAttribute("qna") BoardPostVO vo, Errors errors, Model model, @RealUser EmpVO realUser) {
		log.info("qna:{}",vo);
		if(!errors.hasErrors()) {
			vo.setEmpId(realUser.getEmpId());
			int cnt = service.createQna(vo);
			if(cnt>0) {
				message.qnaReg(realUser, vo.getBpId());
				return "redirect:/board/qna";
			}else {
				return "board/qna_register";
			}
		}else {
			return "board/qna_register";
		}
	}
}
