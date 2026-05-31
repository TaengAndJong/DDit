package kr.or.ddit.professor.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.ddit.professor.service.ProfessorService;
import kr.or.ddit.professor.service.ProfessorServiceImpl;
import kr.or.ddit.vo.SubjectVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@WebServlet("/professor/professorList.do")
public class ProfessorListController extends HttpServlet{
	private ProfessorService service = new ProfessorServiceImpl();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		String proNo = (String)session.getAttribute("proNo");
		List<SubjectVO> subject = service.retriveMySubject(proNo);
		log.info("subject{}",subject);
		System.out.println(subject);
		req.setAttribute("subjcetList", subject);
		String logicalViewName ="professor/professorList";
		req.getRequestDispatcher("/" + logicalViewName + ".miles").forward(req, resp);
	}
}
