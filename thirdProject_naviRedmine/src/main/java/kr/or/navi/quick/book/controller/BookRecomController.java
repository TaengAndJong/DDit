package kr.or.navi.quick.book.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.navi.quick.book.service.BookService;
import kr.or.navi.quick.book.vo.BookVO;
import kr.or.navi.security.RealUser;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/quick/book")
public class BookRecomController {
	@Inject
	private BookService service;

	@GetMapping
	public String bookPage(@RealUser EmpVO vo, Model model) {
		List<BookVO> bookList = service.selectbookList();
		List<BookVO> recomList = service.recomBookList(vo);
		model.addAttribute("bookList", bookList);
		log.info("bookList", bookList);
		model.addAttribute("recomList", recomList);
		log.info("recomList", recomList);
		
		return "quick/bookList";
	}

	@PostMapping
	@ResponseBody
	public String clickCnt(@RealUser EmpVO vo, @RequestParam("bkListId") String bkListId) {
		int cnt = service.insertBook(vo.getEmpId(), bkListId);
		if (cnt > 0) {
			return "ok";
		}
		return "no";
	}
}
