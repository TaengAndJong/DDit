package kr.or.ddit.student.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import kr.or.ddit.common.paging.BootstrapFormBasePaginationRenderer;
import kr.or.ddit.common.paging.PaginationInfo;
import kr.or.ddit.common.paging.PaginationRenderer;
import kr.or.ddit.common.paging.SearchCondition;
import kr.or.ddit.student.service.StudentService;
import kr.or.ddit.student.service.StudentServiceImpl;
import kr.or.ddit.vo.ClassVO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.SubjectVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@WebServlet("/student/enrollment.do")
public class StudentEnrolllmentController extends HttpServlet{
	private StudentService service=new StudentServiceImpl();
	@Override
		protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			String stdNo = req.getParameter("stdNo");
			// 현재 페이지를 가져오는 부분
			String pageStr = req.getParameter("page");
			int currentPage = 1;

			// 페이지 파라미터가 숫자인지 확인하고 현재 페이지 설정
			if (StringUtils.isNumeric(pageStr)) {// isNumeric 메서드는 문자열이 숫자로만 이루어져 있는지 확인하는 메서드
				currentPage = Integer.parseInt(pageStr);
			}

			// PaginationInfo 객체 생성 및 현재 페이지 설정
			PaginationInfo paging = new PaginationInfo();
			paging.setCurrentPage(currentPage);// setCurrentPage = 현재 페이지( currentPage ) 설정 시, 시작/끝 레코드 및 시작/끝 페이지 계산
			
			

			// 서비스를 통해 교수 리스트를 조회
			List<SubjectVO> subjcetList = service.retrieveSubjectList(stdNo,paging);
			PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
			// 페이징 HTML 생성
			String pagingHTML = renderer.renderPagination(paging);

			// request 속성에 제품 리스트와 페이징 HTML을 저장
			req.setAttribute("subjcetList", subjcetList);
			req.setAttribute("pagingHTML", pagingHTML);
			
			
			String logicalViewName ="student/enrollment";
			req.getRequestDispatcher("/" + logicalViewName + ".miles").forward(req, resp);
		}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try(
				InputStream is = req.getInputStream();
			){
				ClassVO vo = new ObjectMapper()
										.registerModule(new JavaTimeModule())
										.readValue(is, ClassVO.class);
				boolean success = service.registerClass(vo);
				req.setAttribute("success", success);
				String view = "/jsonView.do";
				req.getRequestDispatcher(view).forward(req, resp);
			}
	}

}
