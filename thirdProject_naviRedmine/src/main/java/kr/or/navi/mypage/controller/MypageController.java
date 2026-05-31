package kr.or.navi.mypage.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.navi.mypage.service.MypageService;
import kr.or.navi.quick.book.service.BookService;
import kr.or.navi.security.RealUser;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/mypage/me")
public class MypageController {
	@Inject
	MypageService service;

	@Inject
	BookService bookService;
	
	/**
	 * 사용자의 마이페이지를 표시
	 * 
	 * @param model 사용자에게 전달할 데이터를 포함하는 Spring의 Model 객체
	 * @param vo 현재 로그인한 사용자의 정보를 포함하는 EmpVO 객체
	 * @return 마이페이지
	 */
	@GetMapping
	public String mypage(Model model, @RealUser EmpVO vo) {
	    // 사용자의 도서관심분야 명
	    String bookName = bookService.getBookNameByBkId(vo.getEmpBkId());
	    // 현재 로그인한 사용자의 정보를 데이터베이스에서 가져와 업데이트
	    vo = service.selectOne(vo.getEmpId());
	    
	    // 모델에 사용자의 대여 책 이름과 사용자 정보를 추가
	    model.addAttribute("bkNm", bookName);
	    model.addAttribute("vo", vo);
	    
	    return "mypage/mypage";
	}
}