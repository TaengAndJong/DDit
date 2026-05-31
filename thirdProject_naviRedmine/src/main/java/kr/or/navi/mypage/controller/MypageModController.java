package kr.or.navi.mypage.controller;

import java.io.IOException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.navi.enumpkg.ServiceResult;
import kr.or.navi.mypage.service.MypageService;
import kr.or.navi.quick.book.service.BookService;
import kr.or.navi.quick.book.vo.BookNameVO;
import kr.or.navi.security.RealUser;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/mypage/modify")
public class MypageModController {
	private static final String MODPAGE = "mypage/mypageMod";
	
	@Inject
	MypageService service;

	@Inject
	BookService bookService;
	
	@GetMapping
	public String mypageMod(@ModelAttribute("modEmp") EmpVO modEmp, Model model, @RealUser EmpVO vo) {
		vo = service.selectOne(vo.getEmpId());
	    // 기존 전화번호에서 앞 3자리와 뒷 8자리를 분리
	    String[] phoneParts = splitPhone(vo.getEmpPhone());
	    String phoneFirst = phoneParts[0]; // 앞 3자리
	    String phoneMiddle = phoneParts[1]; // 가운데 4자리
	    String phoneLast = phoneParts[2]; // 뒷 4자리
	    
	    model.addAttribute("phoneFirst", phoneFirst);
	    model.addAttribute("phoneMiddle", phoneMiddle);
	    model.addAttribute("phoneLast", phoneLast);
	    
	    // 기존 주민등록번호에서 앞6자리와 뒷 7자리 분리
	    String[] rrnoParts = splitRrno(vo.getEmpRrno());
	    String rrnoFirst = rrnoParts[0];
	    String rrnoLast = rrnoParts[1];
	    
	    model.addAttribute("rrnoFirst", rrnoFirst);
	    model.addAttribute("rrnoLast", rrnoLast);

	    // 기존 email에서 @기준으로 분리
	    String[] emailParts = splitEmail(vo.getEmpMail());
	    String userName = emailParts[0];
	    String domain = emailParts[1];
	    
	    model.addAttribute("userName", userName);
	    model.addAttribute("domain", domain);
	    
	    List<BookNameVO> bookList = bookService.selectBookNameList();
	    
	    model.addAttribute("vo", vo);
	    model.addAttribute("bookList", bookList);
	    return MODPAGE;
	}

	@PostMapping
	   public String modProcess(@ModelAttribute("modEmp") EmpVO modEmp, Errors error, @RealUser EmpVO vo, HttpServletRequest request, Model model) throws IOException {
        String logicalViewName = null;

        String empId = vo.getEmpId();
        modEmp.setEmpId(empId);

        // 전화번호 재구성
        String modPhone = reNum(request.getParameter("phoneFirst"), request.getParameter("phoneMiddle"), request.getParameter("phoneLast"));
        modEmp.setEmpPhone(modPhone); // 수정된 전화번호를 VO에 설정

        String modRrno = reRrno(request.getParameter("rrnoFirst"), request.getParameter("rrnoLast"));
        modEmp.setEmpRrno(modRrno);

        String modEmail = reEmail(request.getParameter("userName"), request.getParameter("domain"));
        modEmp.setEmpMail(modEmail);

        ServiceResult result = service.modifyEmp(modEmp);

        String message = null;
        switch (result) {
            case INVALIDPASSWORD:
                logicalViewName = MODPAGE;
                message = "인증실패";
                break;
            case OK:
                logicalViewName = "redirect:/mypage/me";
                break;
            default:
                logicalViewName = MODPAGE;
                message = "서버오류";
                break;
        }
        model.addAttribute("message", message);

        return logicalViewName;
    }

    // 전화번호를 분리하는 메서드
    private String[] splitPhone(String phone) {
        return phone.split("-");
    }

    // 전화번호를 재구성하는 메서드
    private String reNum(String first, String middle, String last) {
        return first + "-" + middle + "-" + last;
    }

    // 주민등록번호 분리하는 메서드
    private String[] splitRrno(String rrno) {
        return rrno.split("-");
    }

    // 주민등록번호 재구성하는 메서드
    private String reRrno(String first, String last) {
        return first + "-" + last;
    }

    // 이메일 주소를 분리하는 메서드
    private String[] splitEmail(String email) {
        return email.split("@");
    }

    // 이메일주소 재구성
    private String reEmail(String username, String domain) {
        return username + "@" + domain;
    }
}