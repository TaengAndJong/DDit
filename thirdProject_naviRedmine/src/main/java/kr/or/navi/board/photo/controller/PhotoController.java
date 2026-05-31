package kr.or.navi.board.photo.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.lang3.StringUtils;
import org.springframework.core.io.Resource;
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

import kr.or.navi.common.paging.SearchCondition;
import kr.or.navi.mypage.service.MypageService;
import kr.or.navi.security.RealUser;
import kr.or.navi.validate.InsertGroup;
import kr.or.navi.validate.PhotoInsertGroup;
import kr.or.navi.common.paging.BootstrapFormBasePaginationRenderer;
import kr.or.navi.common.paging.PaginationRenderer;
import kr.or.navi.alarm.service.SseEmitters;
import kr.or.navi.board.photo.service.PhotoService;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.BoardCommentVO;
import kr.or.navi.vo.BoardPostFileVO;
import kr.or.navi.vo.BoardPostVO;
import kr.or.navi.vo.BookmarkBoardVO;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board/photo")
@Slf4j
public class PhotoController {

	@Inject
	private PhotoService service;
	
	@Inject
	private MypageService mservice;
	
	@Inject
	private SseEmitters message;
	
	/**
	 * 포토목록 조회
	 * @param realUser
	 * @param currentPage
	 * @param model
	 * @param simpleCondition
	 * @return
	 * @throws IOException
	 */
	@GetMapping
	public String photoList(			
			@RealUser EmpVO realUser
			,@RequestParam(name="page", required = false, defaultValue = "1") int currentPage
			, Model model
			, @ModelAttribute("simpleCondition") SearchCondition simpleCondition
			) throws IOException {
		String empId = realUser.getEmpId();
		List<BookmarkBoardVO> bkList = mservice.retriveBookMarkBoardList(empId);
		model.addAttribute("bkList", bkList);
		List<BoardPostVO> anoList = service.retrieveAnoListBoard();
		model.addAttribute("anoList",anoList);
		log.info("simpleConditon:{}",simpleCondition);
		PaginationInfo paging = new PaginationInfo(8,8);
		paging.setCurrentPage(currentPage);
		paging.setSimpleCondition(simpleCondition);
		List<BoardPostVO> photoList = service.retrievePhotoList(paging);
		log.info("PhotoList : {}", photoList);
		model.addAttribute("photoList",photoList);
//		BoardPostFileVO selectImg = service.retrieveImg(empId);
//		model.addAttribute("selectImg", selectImg);
//		log.info("selectImg : {}", selectImg);
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML", pagingHTML);
		model.addAttribute("paging", paging);
		return "board/photo";
		
	}
	/**
	 * 포토 게시글 단건 조회
	 * @param bpId
	 * @param model
	 * @return
	 */
	@GetMapping("{bpId}")
	public String photoDetailPage(@PathVariable String bpId, Model model) {
		BoardPostVO photo = service.retrievePhoto(bpId);
		List<BoardCommentVO> commentList = service.retrieveBoardCommentList(bpId);
		log.info("commentList :{}",commentList);
		model.addAttribute("photo", photo);
		model.addAttribute("commentList", commentList);
		List<BoardPostFileVO> bpfv = service.retrievePhotoFile(bpId);
		log.info("bpfv:{}",bpfv);
		model.addAttribute("bpfv", bpfv);
		service.viewCnt(bpId);
		return "board/photo_detail";
	}
	
	/**
	 * 댓글 등록 컨트롤러
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
	 * 댓글 삭제 컨트롤러
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
	 * 포토게시판 수정
	 * @param bpId
	 * @param model
	 * @return
	 */
	@GetMapping("/mod/{bpId}")
	public String photoModPage(@PathVariable("bpId") String bpId, Model model) {
		BoardPostVO updatePhoto = service.retrievePhoto(bpId);
		model.addAttribute("photo", updatePhoto);
		List<BoardPostFileVO> bpfv = service.retrievePhotoFile(bpId);
		log.info("bpfv:{}",bpfv);
		model.addAttribute("bpfv", bpfv);
		
		return "board/photo_mod";

	}
	/**
	 * 포토게시판 수정 데이터 전송
	 * @param updatePhoto
	 * @param bpId
	 * @param model
	 * @param realUser
	 * @return
	 * @throws IOException
	 */
	@PostMapping("mod/{bpId}")
	@ResponseBody
	public Map<String, String> photoPutController(
			@ModelAttribute("photo")
			BoardPostVO updatePhoto, 
			@PathVariable String bpId, Model model, @RealUser EmpVO realUser ) throws IOException {
		Map<String, String> msg = new HashMap<String, String>();
		if(StringUtils.isNotBlank(updatePhoto.getBpCn()) && StringUtils.isNotBlank(updatePhoto.getBpTitle())) {
			updatePhoto.setBpId(bpId);
			updatePhoto.setEmpId(realUser.getEmpId());
			
			int cnt = service.modifyPhoto(updatePhoto);
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
	 * 포토게시판 삭제
	 * @param bpId
	 * @param model
	 * @param realUser
	 * @return
	 */
	@DeleteMapping("del/{bpId}")
	public String shraeDelController(@PathVariable String bpId, Model model,@RealUser EmpVO realUser) {
		log.info("bpId:{}",bpId);
		int cnt = service.removePhoto(bpId);
		if(cnt>0) {
			model.addAttribute("msg", "ok");
			message.boardDel(realUser, bpId);
		}else {
			model.addAttribute("msg", "fail");
		}
		return "jsonView";
	}
	
	/**
	 * 포토게시판 등록
	 * @param fileVO
	 * @param vo
	 * @param model
	 * @return
	 */
	@GetMapping("/add")
	public String photoRegisterPage(
					@ModelAttribute("fileVO") BoardPostFileVO fileVO
					,@ModelAttribute("photo") BoardPostVO vo, Model model) {
		return "board/photo_register";
	}
	
	/**
	 * 포토게시판 등록 데이터 전송
	 * @param vo
	 * @param errors
	 * @param model
	 * @param realUser
	 * @param files
	 * @param img
	 * @return
	 * @throws IOException
	 */
	@PostMapping("/add")
	public String photoAddController(
			@Validated(PhotoInsertGroup.class) @ModelAttribute("photo") BoardPostVO vo, Errors errors, Model model, @RealUser EmpVO realUser
			,@RequestPart(value="files", required = false) MultipartFile[] files
			,@RequestPart(value="img", required = false) MultipartFile img
		) throws IOException {
		log.info("photo : {}",vo);
		log.info("img : {}", img);
		log.info("files: {}", files);
		log.info("realUser:{}", realUser);
		log.info("errors:{}",errors);
		
		if(!errors.hasErrors()) {
			vo.setEmpId(realUser.getEmpId());
			
			int cnt = service.createPhoto(vo);
			if(cnt>0) {
				message.boardReg(realUser, vo.getBpId(),"A00009");
				return "redirect:/board/photo";
			}else {
				return  "board/photo_register";
			}
		}else {
			return "board/photo_register";
		}
	}
	/**
	 * 포토게시판 파일 삭제 컨트롤러
	 * @param bpFileId
	 * @return
	 * @throws IOException
	 * 파일 삭제
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
