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
public class ProjectDetailInterceptor implements HandlerInterceptor {
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
		if(realUser.isAdmin()) {
			return HandlerInterceptor.super.preHandle(request, response, handler);
		}
		boolean f = false;
		log.info("len : {}", split.length);
		if (realUser != null && split.length >= 5) {// 프로젝트 상세페이지는 localhost/navi/project/{proId} 로 이루어져있기 때문에 상세 파악 조건
			String proId = split[4];
			if(!proId.contains("P")) {	//프로젝트 id P로 프로젝트 상세인지 아닌지 확인
				return HandlerInterceptor.super.preHandle(request, response, handler);
			}
			List<TeamVO> selectTeam = teamDao.selectTeam(proId);	//해당 프로젝트 팀원 전체 조회
			log.info("selectTeam : {}", selectTeam);
			log.info("userName : {}", user.getName());
			for (TeamVO t : selectTeam) {		
				String empId = t.getEmpId();
				log.info("f : {}", f);
				if (empId.equals(user.getName())) {	//팀원중 현재 요청보낸 클라이언트가 있는지 확인
					if ("Y".equals(t.getTeamYn())) {
						f = true;
					}
				}
			}
			if(StringUtils.isBlank(proId)) {
				return true;
			}
			if (!f) {	//검증에 통과히지 못했다면 프로젝트 목록 페이지로 이동
				request.getSession().setAttribute("contMsg", "접근할 수 없습니다.");
				response.sendRedirect(request.getContextPath() + "/project");
				return false;
			}
			
		}
		// 정상적으로 검증에 통과했다면 상세로 이동
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}
}