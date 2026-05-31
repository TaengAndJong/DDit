package kr.or.ddit.student.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.ddit.student.service.StudentService;
import kr.or.ddit.student.service.StudentServiceImpl;
import kr.or.ddit.utils.PopulateUtills;
import kr.or.ddit.vo.StudentVO;

@WebServlet("/student/studentEdit.do")
public class StudentUpdateController extends HttpServlet{
		
	// controller는 서비스와 의존관계
	StudentService service = new StudentServiceImpl();
		
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//여기에서 파라미터 리퀘스트에 담아서보내야해씀...
		HttpSession session = req.getSession();
		String stdNo = (String)session.getAttribute("stdNo");
		StudentVO info = service.retrieveStudent(stdNo);
		
		req.setAttribute("info", info);
		
		String logicalViewName ="student/studentEdit";
		req.getRequestDispatcher("/"+logicalViewName+".miles").forward(req, resp);
	
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			
				
				String logicalViewName ="student/studentList";
				req.getRequestDispatcher("/"+logicalViewName+".miles").forward(req, resp);
				
	}
	
	

}
