package kr.or.ddit.professor.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.professor.service.ProfessorService;
import kr.or.ddit.professor.service.ProfessorServiceImpl;

@WebServlet("/professor/professorCheck.do")
public class ProfessorCheckController extends HttpServlet{
	private ProfessorService service = new ProfessorServiceImpl();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String proNo = req.getParameter("proNo");
		String message="교수번호 입력";
		HttpSession session = req.getSession();
		String logicalViewName ="professor/professorCheck";
		boolean check=false;
		if(StringUtils.isNotBlank(proNo)) {
			check = service.checkProfessor(proNo);
			if(check) {
				session.setAttribute("proNo", proNo);
				logicalViewName ="redirect:/professor/professorList.do";
			}else {
				message="없는 교수번호";
			}	
		}
		if(check) {
			String redirectViewName = req.getContextPath() + logicalViewName.substring("redirect:".length());
			resp.sendRedirect(redirectViewName);
		}else {
			req.setAttribute("message", message);
			req.getRequestDispatcher("/"+logicalViewName+".miles").forward(req, resp);
		}
		
	}
}
