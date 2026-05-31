package kr.or.navi.admin.board.controller;

import java.io.IOException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.navi.admin.board.service.AdminBoardService;
import kr.or.navi.board.photo.service.PhotoService;
import kr.or.navi.board.prais.service.PraisService;
import kr.or.navi.board.share.service.ShareService;
import kr.or.navi.common.paging.BootstrapFormBasePaginationRenderer;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.common.paging.PaginationRenderer;
import kr.or.navi.common.paging.SearchCondition;
import kr.or.navi.mypage.service.MypageService;
import kr.or.navi.security.RealUser;
import kr.or.navi.vo.BoardPostVO;
import kr.or.navi.vo.BookmarkBoardVO;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminBoardController {
	@Inject
	public ShareService shareService;
	@Inject
	public AdminBoardService adminService;

	@Inject
	public PhotoService photoService;
	
	@Inject
	private MypageService mservice;
	
	@Inject
	private PraisService praisService;
	
//	public PraisService praisService;

	
// 나눔게시판 조회 및 삭제
	@GetMapping("board/share")
	public String shareBoardPage(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@ModelAttribute("simpleCondition") SearchCondition simpleCondition, Model model) {
		PaginationInfo paging = new PaginationInfo(5, 3);
		paging.setCurrentPage(currentPage);
		paging.setSimpleCondition(simpleCondition);
		List<BoardPostVO> shareList = shareService.retrieveShareList(paging);
		model.addAttribute("shareList", shareList);
		newCheck(shareList);
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML", pagingHTML);
		model.addAttribute("paging", paging);
		return "admin/board/adminShareList";
	}
	
	@DeleteMapping("board/share")
	public String shareDeleteController(@RequestBody List<BoardPostVO> deleteShareBoard, Errors error, Model model) {

		log.info("deleteShareBoard : {}", deleteShareBoard);
		log.info("error : {}", error);
		if (deleteShareBoard.size() == 0) {
			model.addAttribute("msg", "empty");
		} else {
			int cnt = adminService.boardCheckedDelete(deleteShareBoard);
			if (cnt > 0) {
				model.addAttribute("msg", "ok");
			} else {
				model.addAttribute("msg", "fail");
			}
		}
		return "jsonView";
	}
	// 나눔게시판 조회 및 삭제
	
	
	
	
	
	
	// 포토게시판 조회 및 삭제
	@GetMapping("board/photo")
	public String photoBoardPage(
			@RealUser EmpVO realUser
			,@RequestParam(name="page",required = false, defaultValue = "1") int currentPage
			, Model model
			, @ModelAttribute("simpleCondition") SearchCondition simpleCondition
			) throws IOException {
		String empId = realUser.getEmpId();
		List<BookmarkBoardVO> bkList = mservice.retriveBookMarkBoardList(empId);
		model.addAttribute("bkList", bkList);
		log.info("simpleConditon:{}",simpleCondition);
		PaginationInfo paging = new PaginationInfo(5,3);
		paging.setCurrentPage(currentPage);
		paging.setSimpleCondition(simpleCondition);
		List<BoardPostVO> photoList = photoService.retrievePhotoList(paging);
		List<BoardPostVO> photoList2 = photoService.retrievePhotoList(paging);
		model.addAttribute("photoList",photoList);
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML", pagingHTML);
		log.info("pagingHTML : {}",pagingHTML);
		model.addAttribute("paging", paging);
		return "admin/board/adminPhotoList";
	}

	
	@DeleteMapping("board/photo")
	public String photoDeleteController(@RequestBody List<BoardPostVO> deletePhotoBoard, Errors error, Model model) {

		log.info("deleteShareBoard : {}", deletePhotoBoard);
		log.info("error : {}", error);
		if (deletePhotoBoard.size() == 0) {
			model.addAttribute("msg", "empty");
		} else {
			int cnt = adminService.boardCheckedDelete(deletePhotoBoard);
			if (cnt > 0) {
				model.addAttribute("msg", "ok");
			} else {
				model.addAttribute("msg", "fail");
			}
		}
		return "jsonView";
	}
	
	
	
	@GetMapping("/board/prais")
	public String praisBoardPage(
			@RealUser EmpVO realUser
			,@RequestParam(name="page", required = false, defaultValue = "1") int currentPage
			, Model model
			, @ModelAttribute("simpleCondition") SearchCondition simpleCondition
			) {
		String empId = realUser.getEmpId();
		List<BookmarkBoardVO> bkList = mservice.retriveBookMarkBoardList(empId);
		model.addAttribute("bkList", bkList);
		log.info("simpleCondition : {}", simpleCondition);
		PaginationInfo paging = new PaginationInfo(5,3);
		paging.setCurrentPage(currentPage);
		paging.setSimpleCondition(simpleCondition);
		List<BoardPostVO> praisList = praisService.retrievePraisList(paging);
		model.addAttribute("praisList", praisList);
		newCheck(praisList);
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML", pagingHTML);
		model.addAttribute("paging", paging);
		return "admin/board/adminPraisList";
	}
	
	private void newCheck(List<BoardPostVO> praisList) {
		LocalDateTime now = LocalDateTime.now();
		for(BoardPostVO vo : praisList) {
			LocalDateTime bpRegDt = vo.getBpRegDt();
	        Duration duration = Duration.between(bpRegDt, now);
	        long days = duration.toDays();
	        if (days >= 1) {
	        	vo.setNowCheck("1");
	        }
		}
	}

}
