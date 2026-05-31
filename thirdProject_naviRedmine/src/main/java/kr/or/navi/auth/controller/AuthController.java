package kr.or.navi.auth.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/auth/mypage")
public class AuthController {
	
	@GetMapping
	public String mypage() {
		return "auth/mypage";
	}
}