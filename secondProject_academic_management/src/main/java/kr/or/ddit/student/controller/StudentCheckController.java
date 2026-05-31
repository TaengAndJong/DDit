package kr.or.ddit.student.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.student.service.StudentService;
import kr.or.ddit.student.service.StudentServiceImpl;
import kr.or.ddit.vo.StudentVO;

@WebServlet("/student/studentCheck.do")
public class StudentCheckController extends HttpServlet{

	// controller는 서비스와 의존관계
	StudentService service = new StudentServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String logicalViewName ="student/studentCheck";
		req.getRequestDispatcher("/"+logicalViewName+".miles").forward(req, resp);
	}
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 응답을 받는 부분은 내용을 포함하고있기때문에 인코딩 셋팅필요
		req.setCharacterEncoding("UTF-8");
		// 보낸 파라미터 받기
		String stdNo = (String) req.getParameter("stdNo");
		// 로그인 세션받기
		HttpSession session = req.getSession();
	
		
		
		//학생 번호가 비어있는지 검증하기
		boolean valid = false;
		//값이 비어있을 때 메시지 
		String message = "";
		String logicalViewName = null;
		if(StringUtils.isBlank(stdNo)) {
			
			message ="학번을 입력해주세요.";
			session.setAttribute("message", message);
			
			logicalViewName ="redirect:student/studentCheck";
		}else {
			valid = true;
			//service의 메소드로 마이바티스에게 SQL mapper에 사용될 학번 보내주기 -> command Object
			//의문점 : 왜 여기서 인포를 보내줘야할까.. list에서 get요청할때 보내주면 안되던데..
			StudentVO info = service.retrieveStudent(stdNo);
		
			req.setAttribute("stdNo", stdNo);
			req.setAttribute("info",info);
			session.setAttribute("stdNo",stdNo);
			session.setAttribute("session", session);
			
			
			logicalViewName ="student/studentList";
		}
		

		
		if(logicalViewName.startsWith("redirect:")) {
			String redirectViewPath = req.getContextPath() + "/"+logicalViewName.substring("redirect:".length());
			redirectViewPath =redirectViewPath+".do";
		
			resp.sendRedirect(redirectViewPath);
		}else {
			req.getRequestDispatcher("/"+logicalViewName+".miles").forward(req, resp);
		}
		
	
	}
	
}


