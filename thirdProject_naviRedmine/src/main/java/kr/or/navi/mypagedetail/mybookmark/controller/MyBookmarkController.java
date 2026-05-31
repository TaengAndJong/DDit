package kr.or.navi.mypagedetail.mybookmark.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.navi.common.paging.BootstrapFormBasePaginationRenderer;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.common.paging.PaginationRenderer;
import kr.or.navi.mypage.service.MypageService;
import kr.or.navi.security.RealUser;
import kr.or.navi.vo.BoardPostVO;
import kr.or.navi.vo.BookmarkBoardVO;
import kr.or.navi.vo.BookmarkIssueVO;
import kr.or.navi.vo.BookmarkVO;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/mypage/bookmark")
public class MyBookmarkController {
	
	@Inject
	MypageService service;
	
	@GetMapping
	public String mypageBook(@RealUser EmpVO realUser, Model model
			, @RequestParam Map<String, Object> detailCondition
			, @RequestParam(name = "page", required = false, defaultValue = "1") int currentPage) {
		
		PaginationInfo paging = new PaginationInfo(10, 10);
		paging.setCurrentPage(currentPage);
		paging.setDetailCondition(detailCondition);
		List<BookmarkVO> bookmarkList = service.bookmarkList(realUser.getEmpId(),paging);
		model.addAttribute("list", bookmarkList);
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML", pagingHTML);
		model.addAttribute("paging", paging);
		return "mypage/bookmark/myBookmark";
	}
	
    @PostMapping("/issue")
    @ResponseBody
    public String insertIssueBookmark(@RequestBody BookmarkIssueVO insertVO,@RealUser EmpVO emp) {
    	insertVO.setEmpId(emp.getEmpId());
    	int cnt = service.createIssueBookmark(insertVO);
		if(cnt>0) {
			return "ok";
		}
		return "no";
    }

    @PostMapping("/board")
    @ResponseBody
    public String insertBoardBookmark(@RequestBody BookmarkBoardVO insertVO, @RealUser EmpVO emp) {
    	insertVO.setEmpId(emp.getEmpId());
    	int cnt = service.createBoardBookmark(insertVO);
		if(cnt>0) {
			return "ok";
		}
		return "no";
    }
    
    @DeleteMapping("issue/{issueId}")
    public String deleteIssueBookmark(@PathVariable String issueId, @RealUser EmpVO emp, Model model) {
    	int cnt = service.removeBookMarkIssue(emp.getEmpId(), issueId);
    	if(cnt>0) {
    		model.addAttribute("msg","ok");
    	}else {
    		model.addAttribute("msg","fail");
    	}
    	return "jsonView";
    }
    
    @DeleteMapping("board/{bpId}")
    public String deleteBoardBookmark(@PathVariable String bpId, @RealUser EmpVO emp, Model model) {
    	int cnt = service.removeBookMarkBoard(bpId, emp.getEmpId());
    	if(cnt>0) {
    		model.addAttribute("msg","ok");
    	}else {
    		model.addAttribute("msg","fail");
    	}
    	return "jsonView";
    }
}
