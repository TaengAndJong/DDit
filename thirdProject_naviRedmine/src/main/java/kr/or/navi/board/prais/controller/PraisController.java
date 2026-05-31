package kr.or.navi.board.prais.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.api.client.util.Value;

import kr.or.navi.alarm.service.SseEmitters;
import kr.or.navi.board.prais.service.PraisService;
import kr.or.navi.common.paging.BootstrapFormBasePaginationRenderer;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.common.paging.PaginationRenderer;
import kr.or.navi.common.paging.SearchCondition;
import kr.or.navi.mypage.service.MypageService;
import kr.or.navi.security.RealUser;
import kr.or.navi.validate.InsertGroup;
import kr.or.navi.vo.BoardCommentVO;
import kr.or.navi.vo.BoardPostFileVO;
import kr.or.navi.vo.BoardPostVO;
import kr.or.navi.vo.BookmarkBoardVO;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board/prais")
public class PraisController {

	

	@Inject
	private PraisService service;
	
	@Inject
	private MypageService mservice;
	
	@Inject
	private SseEmitters message;


	/**
	 * 칭찬게시판 목록 조회
	 * @param realUser
	 * @param currentPage
	 * @param model
	 * @param simpleCondition
	 * @return
	 */
	@GetMapping
	public String praisPage(
			@RealUser EmpVO realUser
			,@RequestParam(name="page", required = false, defaultValue = "1") int currentPage
			, Model model
			, @ModelAttribute("simpleCondition") SearchCondition simpleCondition
			) {
		String empId = realUser.getEmpId();
		List<BookmarkBoardVO> bkList = mservice.retriveBookMarkBoardList(empId);
		model.addAttribute("bkList", bkList);
		List<BoardPostVO> anoList = service.retrieveAnoListBoard();
		model.addAttribute("anoList",anoList);
		newCheck(anoList);
		log.info("simpleCondition : {}", simpleCondition);
		PaginationInfo paging = new PaginationInfo(10,10);
		paging.setCurrentPage(currentPage);
		paging.setSimpleCondition(simpleCondition);
		List<BoardPostVO> praisList = service.retrievePraisList(paging);
		model.addAttribute("praisList", praisList);
		newCheck(praisList);
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML", pagingHTML);
		model.addAttribute("paging", paging);
		return "board/prais";
	}
	/**
	 * 등록된 게시글에 1일 동안 new 아이콘 표시
	 * @param shareList
	 */
	private void newCheck(List<BoardPostVO> shareList) {
		LocalDateTime now = LocalDateTime.now();
		for(BoardPostVO vo : shareList) {
			LocalDateTime bpRegDt = vo.getBpRegDt();
	        Duration duration = Duration.between(bpRegDt, now);
	        long days = duration.toDays();
	        if (days >= 1) {
	        	vo.setNowCheck("1");
	        }
		}
	}
	/**
	 * 칭찬게시판 상세조회
	 * @param bpId
	 * @param model
	 * @return
	 */
	@GetMapping("{bpId}")
	public String praisDetailPage(@PathVariable String bpId, Model model) {
		BoardPostVO prais = service.retrievePrais(bpId);
		List<BoardCommentVO> commentList = service.retrieveBoardCommentList(bpId);
		log.info("commentList :{}",commentList);
		model.addAttribute("prais", prais);
		model.addAttribute("commentList", commentList);
		List<BoardPostFileVO> bpfv = service.retrievePraisFile(bpId);
		log.info("bpfv:{}",bpfv);
		model.addAttribute("bpfv", bpfv);
		service.viewCnt(bpId);
		
		return "board/prais_detail";
	}
	
	/**
	 * 댓글 등록
	 * @param bcVO
	 * @param realUser
	 * @param error
	 * @param model
	 * @return
	 */
	@PostMapping("comment/reg")
	@ResponseBody
	public String boardInsertCommentController(
			@RequestBody BoardCommentVO bcVO
			,@RealUser EmpVO realUser
			, Errors error
			, Model model) 
	{
		log.info("bcVO : {}",bcVO);
		bcVO.setEmpId(realUser.getEmpId());
		int cnt = service.createBoardComment(bcVO);
		if(cnt>0) {
			return "ok";
		}else {
			return "fail";
		}
	}
	
	/**
	 * 댓글 삭제
	 * @param bcId
	 * @param model
	 * @return
	 */
	@DeleteMapping("delcomment")
	public String boardDeleteCommentController(@RequestParam String bcId, Model model) {
		log.info("bcId : {}",bcId);
		int cnt = service.removeBoardComment(bcId);
		if (cnt > 0) {
			model.addAttribute("msg", "ok");
		} else {
			model.addAttribute("msg", "fail");
		}
		return "jsonView";
	}
	
	
	
	/**
	 * 파일 다운로드
	 * @param bpFileId
	 * @return
	 * @throws IOException
	 */
	@GetMapping("download/{bpFileId}")
	public ResponseEntity<Resource> downloadFile(@PathVariable String bpFileId) throws IOException{
		return service.downloadFile(bpFileId);
	}
	
	
	
	/**
	 * 칭찬게시판 수정 페이지
	 * @param bpId
	 * @param model
	 * @return
	 */
	@GetMapping("/mod/{bpId}")
	public String praisModPage(@PathVariable("bpId") String bpId, Model model) {
		BoardPostVO praisForm = service.retrievePrais(bpId);
		model.addAttribute("prais", praisForm );
		
		List<BoardPostFileVO> bpfv = service.retrievePraisFile(bpId);
		log.info("bpfv:{}",bpfv);
		model.addAttribute("bpfv", bpfv);
		
		return "board/prais_mod";
	}
	
//	,consumes = "multipart/form-data"
	/**
	 * 칭찬게시판 수정데이터 전송
	 * @param updatePrais
	 * @param bpId
	 * @param model
	 * @param realUser
	 * @return
	 * @throws IOException
	 */
	@PostMapping("mod/{bpId}")
	@ResponseBody
	public Map<String, String> praisPutController(
			@ModelAttribute("prais")
			BoardPostVO updatePrais,
			@PathVariable String bpId, Model model, @RealUser EmpVO realUser) throws IOException {
		log.info("updatePrais : {}",updatePrais);
		Map<String, String> msg = new HashMap<String, String>();
		if(StringUtils.isNotBlank(updatePrais.getBpCn()) && StringUtils.isNotBlank(updatePrais.getBpTitle())) {
			updatePrais.setBpId(bpId);
			updatePrais.setEmpId(realUser.getEmpId());
			
			int cnt = service.modifyPrais(updatePrais);
			if(cnt>0) {
				log.info("bpId : {}",bpId);
				msg.put("msg", "ok");
			}else {
				msg.put("msg", "fail");
			}
		}else {
			msg.put("msg", "fail");
		}
		return msg;
	}
	
	/**
	 * 칭찬게시판 삭제데이터 전송
	 * @param bpId
	 * @param model
	 * @param realUser
	 * @return
	 */
	@DeleteMapping("del/{bpId}")
	public String praisDelController(@PathVariable String bpId, Model model,@RealUser EmpVO realUser) {
		log.info("bpId:{}", bpId);
		int cnt = service.removePrais(bpId);
		if(cnt>0) {
			model.addAttribute("msg", "ok");
			message.boardDel(realUser, bpId);
		}else {
			model.addAttribute("msg", "fail");
		}
		return "jsonView";
	}
	
	
	/**
	 * 칭찬게시판 등록
	 * @param fileVO
	 * @param vo
	 * @param model
	 * @return
	 */
	@GetMapping("/add")
	public String praisRegisterPage(
				@ModelAttribute("fileVO") BoardPostFileVO fileVO
			,@ModelAttribute("prais") BoardPostVO vo, Model model) {
		return "board/prais_register";
	}
	
	/**
	 * 칭찬게시판 등로데이터 전송
	 * @param vo
	 * @param errors
	 * @param model
	 * @param realUser
	 * @param files
	 * @return
	 * @throws IOException
	 */
	@PostMapping("/add")
	public String praisAddController(
			@Validated(InsertGroup.class) @ModelAttribute("prais") BoardPostVO vo, Errors errors, Model model, @RealUser EmpVO realUser
			,@RequestPart(value="files", required = false) MultipartFile[] files
			) throws IOException {
		log.info("prais: {}", vo);
		log.info("files: {}", files);
		log.info("realUser:{}", realUser);
		
		if(!errors.hasErrors()) {
			vo.setEmpId(realUser.getEmpId());
			
			int cnt = service.createPrais(vo);
			if(cnt>0) {
				message.boardReg(realUser, vo.getBpId(),"A00009");
				return "redirect:/board/prais";
			}else {
				return "board/prais_register";
			}
		}else {
			return "board/prais_register";
		}
	}
	
	/**
	 * 파일 삭제
	 * @param bpFileId
	 * @return
	 * @throws IOException
	 */
	@PostMapping("file/del/{bpFileId}")
	@ResponseBody
	public Map<String, String> boardPostFileDelController(@PathVariable String bpFileId) throws IOException {
		int cnt = service.removeBoardPostFile(bpFileId);
		Map<String, String> msg = new HashedMap();
		if(cnt>0) {
			msg.put("msg", "ok");
		}else {
			msg.put("msg", "fail");
		}
		return msg;
	}
}