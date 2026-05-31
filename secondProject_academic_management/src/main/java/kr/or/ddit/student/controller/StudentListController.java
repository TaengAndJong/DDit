package kr.or.ddit.student.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.ddit.student.service.StudentService;
import kr.or.ddit.student.service.StudentServiceImpl;
import kr.or.ddit.vo.StudentVO;
import lombok.extern.slf4j.Slf4j;
import oracle.net.ns.SessionAtts;

@Slf4j
@WebServlet("/student/studentList.do")
public class StudentListController extends HttpServlet {
	StudentService service = new StudentServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		System.out.println("List Do");

		String logicalViewName = "student/studentList";
		req.getRequestDispatcher("/" + logicalViewName + ".miles").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		HttpSession session = req.getSession();
		String stdNo = (String) session.getAttribute("stdNo");
		String stdTelno = req.getParameter("stdTelno");
		String stdAddress = req.getParameter("stdAddress");

		StudentVO vo = new StudentVO();
		// vo 객체에 변경된 파라미터 받아서 담아주기 커맨드 오브젝트
		vo.setStdNo(stdNo);
		vo.setStdTelno(stdTelno);
		vo.setStdAddress(stdAddress);

		System.out.println(vo.toString());

		int success = service.modifyStudent(vo);
		System.out.println("success" + success);

		String message = "";
		String logicalViewName = "";
		
		if (!(success > 0)) {

			message = "정상 수정되었습니다.";

			session.setAttribute("modifyMsg", message);
			logicalViewName = "redirect:student/studentList";

		} else {

			message = "수정 오류";
			logicalViewName = "redirect:student/studentCheck";

		}

		if (logicalViewName.startsWith("redirect:")) {
			String redirectViewPath = req.getContextPath() + "/" + logicalViewName.substring("redirect:".length());
			redirectViewPath = redirectViewPath + ".do";

			resp.sendRedirect(redirectViewPath);
		} else {

			req.getRequestDispatcher("/" + logicalViewName + ".miles").forward(req, resp);
		}
	}

}