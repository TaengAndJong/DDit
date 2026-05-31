package kr.or.ddit.professor.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.professor.service.ProfessorService;
import kr.or.ddit.professor.service.ProfessorServiceImpl;
import kr.or.ddit.vo.StudentVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@WebServlet("/professor/professorStudent.do")
public class ProfessorStudentListController extends HttpServlet{
	private ProfessorService service = new ProfessorServiceImpl();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("/professor/professorStudent.do");
		HttpSession session = req.getSession();
		String proNo = (String)session.getAttribute("proNo");
		String subCd = req.getParameter("subCd");
		req.setAttribute("subCd",subCd);
		List<StudentVO> studentList = service.retrieveMyLectureStudentes(proNo, subCd);
		req.setAttribute("studentList", studentList);
		log.info("studentList{}",studentList);
		String logicalViewName ="professor/studentList";
		req.getRequestDispatcher("/" + logicalViewName + ".miles").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String clsScore = req.getParameter("clsScore").trim();
		String stdNo = req.getParameter("stdNo").trim();
		String subCd = req.getParameter("subCd").trim();
		String message="";
		log.info("clasScore={},stdNo={},subCd={}",clsScore,stdNo,subCd);
		if(StringUtils.isBlank(clsScore)) {
			message="점수 잘못 입력";
		}else {
			int iclsScore = Integer.parseInt(clsScore);
			log.info("iclsScore{}",iclsScore);
			boolean registerScore = service.registerScore(stdNo, subCd, iclsScore);
			log.info("registerScore = {}",registerScore);
			if(registerScore) {
				message="점수 등록 완료";
			}else {
				message="점수 등록 실패";
			}
		}
		log.info("message = {}",message);
		req.setAttribute("message",message);
		resp.setContentType("application/json;charset=UTF-8");
		String view = "/jsonView.do";
		req.getRequestDispatcher(view).forward(req, resp);
	}
}
