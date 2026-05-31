package kr.or.navi.board.form.controller;

import java.io.IOException;
import java.time.Duration;
import java.time.LocalDateTime;
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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.navi.board.form.service.FormService;
import kr.or.navi.common.paging.BootstrapFormBasePaginationRenderer;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.common.paging.PaginationRenderer;
import kr.or.navi.common.paging.SearchCondition;
import kr.or.navi.vo.BoardPostFileVO;
import kr.or.navi.vo.BoardPostVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board/form")
public class FormController {
	
	@Inject
	private FormService service;

	@GetMapping
	public String formList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage
			, Model model
			, @ModelAttribute("simpleCondition") SearchCondition simpleCondition
	) {
		log.info("simpleCondition : {}",simpleCondition);
		PaginationInfo paging = new PaginationInfo(10,10);
		paging.setCurrentPage(currentPage);
//		paging.setDetailCondition(detailCondition);
		paging.setSimpleCondition(simpleCondition);
		List<BoardPostVO> formList = service.retrieveFormList(paging);
		model.addAttribute("formList", formList);
		newCheck(formList);
		List<BoardPostVO> anoList = service.retrieveAnoListBoard();
		model.addAttribute("anoList",anoList);
		newCheck(anoList);
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML",pagingHTML);
		model.addAttribute("paging",paging);
		return "form/form";
	}
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
	@GetMapping("{bpId}")
	public String formDetail(Model model, @PathVariable String bpId) {
		BoardPostVO vo = service.retrieveForm(bpId);
		model.addAttribute("bf", vo);
		log.info("bf : {}", vo);
		
		List<BoardPostFileVO> bpfv = service.retrieveFormFile(bpId);
		log.info("bpfv:{}",bpfv);
		model.addAttribute("bpfv", bpfv);
		
		service.viewCnt(bpId);
		
		return "form/form_detail";
	}
	
	@GetMapping("/download/{bpFileId}")
	public ResponseEntity<Resource> downloadFile(@PathVariable String bpFileId) throws IOException{
		return service.downloadFile(bpFileId);
	}
	
	
}
