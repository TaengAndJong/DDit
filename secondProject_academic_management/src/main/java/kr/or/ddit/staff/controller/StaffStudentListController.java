package kr.or.ddit.staff.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

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
import kr.or.ddit.staff.service.StaffService;
import kr.or.ddit.staff.service.StaffServiceImpl;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.StudentVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@WebServlet("/staff/staffStudentList.do")
public class StaffStudentListController extends HttpServlet {
	private StaffService service = new StaffServiceImpl();
	
	
	
	private int single(String stdName, HttpServletRequest req){
		StudentVO student = service.retrieveStudent(stdName);
		int status = 200;
		if(student==null) {
			status = 404;
		}else {
			req.setAttribute("student", student);
		}
		return status;
}
	
	
	

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		SearchCondition simpleCondition = new SearchCondition();
		String searchType = req.getParameter("searchType");
		String searchWord = req.getParameter("searchWord");
		simpleCondition.setSearchType(searchType);
		simpleCondition.setSearchWord(searchWord);
		// Enumeration을 통해 모든 파라미터를 돌면서 Map에 저장

		// 검색 조건을 request 속성에 저장
		req.setAttribute("condition", simpleCondition);
		log.info("detailCondition={}",simpleCondition);
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

		// 검색 조건 설정
		paging.setSimpleCondition(simpleCondition);// 상세 검색 조건 일괄 설정

		// 서비스를 통해 학생 리스트를 조회
		List<StudentVO> staffStudentList = service.retrieveStudentList(paging);
		// 페이징 렌더러 선택 (BootstrapFormBasePaginationRenderer 사용)
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");

		// 페이징 HTML 생성
		String pagingHTML = renderer.renderPagination(paging);

		// request 속성에 제품 리스트와 페이징 HTML을 저장
		req.setAttribute("staffStudentList", staffStudentList);
		req.setAttribute("pagingHTML", pagingHTML);

		// 뷰의 논리적 이름 설정
		String logicalViewName = "staff/staffStudentList";
		// 뷰로 포워딩
		req.getRequestDispatcher("/" + logicalViewName + ".miles").forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try(
				InputStream is = req.getInputStream();
			){
				StudentVO stuVO = new ObjectMapper()
										.registerModule(new JavaTimeModule())
										.readValue(is, StudentVO.class);
				boolean success = service.modifyStudent(stuVO);
				req.setAttribute("success", success);
				String view = "/jsonView.do";
				req.getRequestDispatcher(view).forward(req, resp);
			}
	}
}
