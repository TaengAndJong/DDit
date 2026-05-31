package kr.or.navi.admin.qna.controller;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
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
import kr.or.navi.security.RealUser;
import kr.or.navi.validate.InsertGroup;
import kr.or.navi.vo.BoardPostVO;
import kr.or.navi.vo.BookmarkBoardVO;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminQnaController {
	@Inject
	private QnaService service;

	@GetMapping("qna")
	public String qnaPage(@RealUser EmpVO realUser,
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage, Model model,
			@ModelAttribute("simpleCondition") SearchCondition simpleCondition) {
		String empId = realUser.getEmpId();
		PaginationInfo paging = new PaginationInfo(6, 5);
		paging.setSimpleCondition(simpleCondition);
		paging.setCurrentPage(currentPage);
		List<BoardPostVO> qnaList = service.retrieveQnaList(paging);
		model.addAttribute("qnaList", qnaList);
		newCheck(qnaList);
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML", pagingHTML);
		model.addAttribute("paging", paging);
		return "admin/qnaboard/adminQnaList";
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


	@GetMapping("qna/answer/{bpId}")
	public String qnaAnswerPage(@PathVariable String bpId, Model model) {
		BoardPostVO qna = service.retrieveQna(bpId);
		model.addAttribute("qna", qna);
		return "admin/qnaboard/adminQnaAnswer";
	}
	@Inject
	private SseEmitters message;
	@PutMapping("qna/answer/{bpId}")
	public String qnaAnswerController(@RequestBody BoardPostVO updateAnswerQna, @PathVariable String bpId,
			@RealUser EmpVO realUser,
			Model model) {
		log.info("updateAnswerQna : {}", updateAnswerQna);
		if (StringUtils.isNotBlank(updateAnswerQna.getBpQnaAs())) {
			updateAnswerQna.setBpId(bpId);
			int cnt = service.modifyAnswerQna(updateAnswerQna);
			if (cnt > 0) {
				model.addAttribute("msg", "ok");
				message.qnaAnser(realUser, bpId);
			} else {
				model.addAttribute("msg", "fail");
			}
		} else {
			model.addAttribute("msg", "empty");
		}
		return "jsonView";
	}

	@GetMapping("qna/faq")
	public String qnaOftenPage(@RealUser EmpVO realUser,
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage, Model model,
			@ModelAttribute("simpleCondition") SearchCondition simpleCondition) {
		String empId = realUser.getEmpId();
		PaginationInfo paging = new PaginationInfo(6, 5);
		paging.setSimpleCondition(simpleCondition);
		paging.setCurrentPage(currentPage);
		List<BoardPostVO> qnaList = service.retrieveFaqList(paging);
		model.addAttribute("qnaList", qnaList);
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML", pagingHTML);
		model.addAttribute("paging", paging);
		return "admin/qnaboard/adminQnaOftenList";
	}

	@GetMapping("qna/faq/add")
	public String qnaOftenAddPage(@ModelAttribute("faq") BoardPostVO vo, Model model) {
		return "admin/qnaboard/adminQnaOftenAdd";
	}

	@PostMapping("qna/faq/add")
	public String qnaOftenAddController(@Validated(InsertGroup.class) @ModelAttribute("qna") BoardPostVO vo,
			Errors errors, Model model, @RealUser EmpVO realUser) {
		log.info("vo :{}" , vo);
		log.info("errors :{}" , errors);
		if (!errors.hasErrors()) {
			vo.setEmpId(realUser.getEmpId());
			int cnt = service.createQna(vo);
			if (cnt > 0) {
				return "redirect:/admin/qnaboard/adminQnaOftenList";
			} else {
				return "admin/qnaboard/adminQnaOftenAdd";
			}
		} else {
			return "admin/qnaboard/adminQnaOftenAdd";
		}
	}
}
