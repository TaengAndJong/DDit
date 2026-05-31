package kr.or.navi.board.ano.controller;

import java.io.IOException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.navi.board.ano.service.AnoService;
import kr.or.navi.board.form.service.FormService;
import kr.or.navi.common.paging.BootstrapFormBasePaginationRenderer;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.common.paging.PaginationRenderer;
import kr.or.navi.vo.BoardPostFileVO;
import kr.or.navi.vo.BoardPostVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board/ano")
public class AnoController {
	
	@Inject
	private AnoService service;
	
	@GetMapping
	public String anoList(
			@RequestParam Map<String, Object> detailCondition
			, @RequestParam(name="page", required = false, defaultValue = "1") int currentPage
			,Model model) {
		log.info("detailCondition : {}",detailCondition);
		String boardType = (String)detailCondition.get("baordType");
		if(StringUtils.isNotBlank(boardType)) {
			boardType.trim();
		}
		detailCondition.put("boardType", boardType);
		PaginationInfo paging = new PaginationInfo(10,10);
		paging.setCurrentPage(currentPage);
		paging.setDetailCondition(detailCondition);
		List<BoardPostVO> anoList = service.retrieveAnoList(paging);
		model.addAttribute("anoList",anoList);
		newCheck(anoList);
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML",pagingHTML);
		model.addAttribute("paging",paging);
		return "ano/anoList";
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
	public String anoDetailPage(@PathVariable String bpId,Model model) {
		BoardPostVO ano = service.retrieveAno(bpId);
		model.addAttribute("ano", ano);
		
		List<BoardPostFileVO> bpfv = service.retrieveAnoFile(bpId);
		log.info("bpfv:{}",bpfv);
		model.addAttribute("bpfv", bpfv);
		
		service.viewCnt(bpId);
		
		return "ano/ano_detail";
	}
	
	@GetMapping("/download/{bpFileId}")
	public ResponseEntity<Resource> downloadFile(@PathVariable String bpFileId) throws IOException{
		return service.downloadFile(bpFileId);
	}
}
