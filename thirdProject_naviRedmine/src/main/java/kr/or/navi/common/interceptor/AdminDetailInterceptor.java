package kr.or.navi.common.interceptor;

import java.security.Principal;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;

import kr.or.navi.mapper.dao.EmpDAO;
import kr.or.navi.project.dao.ProjectDAO;
import kr.or.navi.project.dao.TeamDAO;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.TeamVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AdminDetailInterceptor implements HandlerInterceptor {
	@Inject
	private EmpDAO mapper;
	@Inject
	private ProjectDAO proDao;

	@Inject
	private TeamDAO teamDao;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		Principal user = request.getUserPrincipal();
		EmpVO realUser = mapper.selectOne(user.getName());
		String requestURI = request.getRequestURI();
		log.info("requestURI : {}", requestURI);
		String[] split = requestURI.split("/");
		boolean f = false;
		if(requestURI.contains("/admin")) {	//현재 url이 admin이 포함되어 있다면 검증 시작
			if(realUser.isAdmin()) { //해당 요청을 보낸 클라이언트(principal)가 어드민이라면 정상적으로 이동
				return HandlerInterceptor.super.preHandle(request, response, handler);
				
			}else {// 아닐경우 에러메세지 발생 이후 메인 페이지 이동
				request.getSession().setAttribute("contMsg", "접근할 수 없습니다.");
				response.sendRedirect(request.getContextPath());
				return false;
			}
		}
		// 아닐경우 에러메세지 발생 이후 메인 페이지 이동
		request.getSession().setAttribute("contMsg", "접근할 수 없습니다.");
		response.sendRedirect(request.getContextPath());
		return false;
	}
}