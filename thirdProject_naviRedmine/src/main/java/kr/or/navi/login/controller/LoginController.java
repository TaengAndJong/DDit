package kr.or.navi.login.controller;

import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.security.web.csrf.CsrfTokenRepository;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.navi.alarm.service.SseEmitters;
import kr.or.navi.login.service.LoginService;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.proxy.annotation.Post;

@Slf4j
@Controller
public class LoginController {
	@Inject
	private LoginService service;
	@Inject
	private CsrfTokenRepository csrfTokenRepository;
	@GetMapping("/myLogin")
	public String loginForm() {
		return "login";
	}
	@GetMapping("/myLogout")
	public String logoutForm() {
		return "logout";
	}
	
	@PostMapping("/findEmpId")
	@ResponseBody
	public Map<String, String> findEmpId(@RequestBody EmpVO findEmp) {
		Map<String, String> map = service.checkAuthEmpId(findEmp);
		log.info("map : {}",map);
		return map;
	}
	@PostMapping("/findEmpPs")
	@ResponseBody
	public Map<String, String> findEmpPs(@RequestBody EmpVO findEmp) {
		Map<String, String> map = service.checkAuthEmpPs(findEmp);
		log.info("map : {}",map);
		return map;
	}
}
