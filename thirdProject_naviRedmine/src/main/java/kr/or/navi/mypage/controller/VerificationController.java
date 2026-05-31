package kr.or.navi.mypage.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.navi.mypage.service.MypageService;
import kr.or.navi.security.RealUser;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/mypage")
public class VerificationController {
    @Inject
    MypageService service;

    @GetMapping("/verification")
    public String showVerificationPage() {
        return "mypage/verification";
    }

    @PostMapping("/verification")
    public String verifyPassword(HttpServletRequest request, @RealUser EmpVO vo, Model model) {
        String password = request.getParameter("password");
        // 데이터베이스에서 사용자의 비밀번호 조회
        EmpVO user = service.selectOne(vo.getEmpId());
        if (!password.equals(user.getEmpPass())) {
            model.addAttribute("message", "비밀번호 인증에 실패하였습니다.");
            return "mypage/verification";
        }

        // 비밀번호 인증 성공 시 개인정보 수정 페이지로 이동
        return "redirect:/mypage/modify";
    }
}