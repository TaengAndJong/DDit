package kr.or.navi.security.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import kr.or.navi.security.EmpVOWrapper;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomAthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws ServletException, IOException {
		EmpVOWrapper principal =(EmpVOWrapper) authentication.getPrincipal();
		EmpVO realUser = principal.getRealUser();
		log.info("custom succses handler 처리. 로그인에 성공한 사용자 {}",realUser.getEmpName());
		if(realUser.isAdmin()) {	//어드민 계정 로그인시 관리페이지로 이동
			response.sendRedirect(request.getContextPath()+"/admin");
		}else { 					//어드민 계정이 아닐 경우 index페이지로 이동(초기 요청에 해당하는 url)
			super.onAuthenticationSuccess(request, response, authentication);
		}
	}
}
