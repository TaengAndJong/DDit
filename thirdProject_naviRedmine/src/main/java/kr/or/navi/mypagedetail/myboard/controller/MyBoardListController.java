package kr.or.navi.mypagedetail.myboard.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.navi.common.paging.BootstrapFormBasePaginationRenderer;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.common.paging.PaginationRenderer;
import kr.or.navi.mypage.service.MypageService;
import kr.or.navi.security.RealUser;
import kr.or.navi.vo.BoardPostVO;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/mypage/board")
public class MyBoardListController {
	
	@Inject
	public MypageService service;
	/**
	 * 내가 작성한 커뮤니티 게시글을 조회하는 페이지 컨트롤러
	 * @param vo 세션에 저장된 principal 객체
	 * @param state 상태에 따른 프로젝트 목록을 조회하기 위한 파라미터
	 * @param detailCondition 검색조건을 확인하기 위한 파라미터
	 * @param currentPage 요청보낸 페이지가 몇번 째 페이지인지 확인하기 위한 파라미터
	 * @param model 데이터를 담아 view(jsp)까지 전달하기 위한 객체
	 * @return
	 */
	@GetMapping()
	public String boardList(@RealUser EmpVO vo,
			@RequestParam(value = "state", required = false, defaultValue = "") String state
			, @RequestParam Map<String, Object> detailCondition
			, @RequestParam(name = "page", required = false, defaultValue = "1") int currentPage, Model model) {
		
        if (state.equals("")) {
        	detailCondition.remove("state");
        } else if(state.equals("ing")){
        	detailCondition.put("state", "ing");
        } else {
            detailCondition.put("state", "end");
        }
     // 페이징 처리를 위한 객체
        PaginationInfo paging = new PaginationInfo(10, 10);
		paging.setCurrentPage(currentPage);
		paging.setDetailCondition(detailCondition);
		// 페이지에 보여줄 커뮤니티 게시글 리스트 조회
		List<BoardPostVO> boardList = service.myBoardList(vo.getEmpId(), paging);
		model.addAttribute("boardList", boardList);
		// 페이징 처리를 위한 html 생성 객체
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML", pagingHTML);
		model.addAttribute("paging", paging);		
		
		return "mypage/board/myboard";
	}
}
