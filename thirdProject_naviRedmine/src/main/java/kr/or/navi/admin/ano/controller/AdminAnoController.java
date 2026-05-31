package kr.or.navi.admin.ano.controller;

import java.io.IOException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.validation.groups.Default;

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

import kr.or.navi.board.ano.controller.AnoController;
import kr.or.navi.board.ano.service.AnoService;
import kr.or.navi.common.paging.BootstrapFormBasePaginationRenderer;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.common.paging.PaginationRenderer;
import kr.or.navi.security.RealUser;
import kr.or.navi.validate.AnoInsertGroup;
import kr.or.navi.validate.InsertGroup;
import kr.or.navi.vo.BoardPostFileVO;
import kr.or.navi.vo.BoardPostVO;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminAnoController {
	
	@Inject
	private AnoService service;
	
	@GetMapping("ano")
	public String anoPage(@RequestParam Map<String, Object> detailCondition
			, @RequestParam(name="page", required = false, defaultValue = "1") int currentPage
			,Model model) {
		log.info("detailCondition : {}",detailCondition);
		String boardType = (String)detailCondition.get("baordType");
		if(StringUtils.isNotBlank(boardType)) {
			boardType.trim();
		}
		detailCondition.put("boardType", boardType);
		PaginationInfo paging = new PaginationInfo(5,5);
		paging.setCurrentPage(currentPage);
		paging.setDetailCondition(detailCondition);
		List<BoardPostVO> anoList = service.retrieveAnoList(paging);
		model.addAttribute("anoList",anoList);
		newCheck(anoList);
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML",pagingHTML);
		model.addAttribute("paging",paging);
		return "admin/anoboard/adminAnoList";
	}
	
	private void newCheck(List<BoardPostVO> anoList) {
		LocalDateTime now = LocalDateTime.now();
		for(BoardPostVO vo : anoList) {
			LocalDateTime bpRegDt = vo.getBpRegDt();
	        Duration duration = Duration.between(bpRegDt, now);
	        long days = duration.toDays();
	        if (days >= 1) {
	        	vo.setNowCheck("1");
	        }
		}
	}
	
	@GetMapping("ano/download/{bpFileId}")
	public ResponseEntity<Resource> downloadFile(@PathVariable String bpFileId) throws IOException{
		return service.downloadFile(bpFileId);
	}
	
	
	@GetMapping("/ano/mod/{bpId}")
	public String anoModPage(@PathVariable("bpId") String bpId, Model model) {
		BoardPostVO ano = service.retrieveAno(bpId);
		model.addAttribute("ano", ano);
		List<BoardPostFileVO> bpfv = service.retrieveAnoFile(bpId);
		log.info("bpfv:{}",bpfv);
		model.addAttribute("bpfv", bpfv);
		
		return "admin/anoboard/adminAnoMod";
	}
	
//	,consumes = "multipart/form-data"
	@PostMapping("ano/mod/{bpId}")
	@ResponseBody
	public Map<String, String> anoPutController(
			@ModelAttribute("ano")
			BoardPostVO updateAno,
			@PathVariable String bpId, Model model, @RealUser EmpVO realUser) throws IOException {
		log.info("updateAno : {}",updateAno);
		Map<String, String> msg = new HashMap<String, String>();
		if(StringUtils.isNotBlank(updateAno.getBpCn()) && StringUtils.isNotBlank(updateAno.getBpTitle())) {
			updateAno.setBpId(bpId);
			updateAno.setEmpId(realUser.getEmpId());
			
			int cnt = service.modifyAno(updateAno);
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
	
	@DeleteMapping("ano/del/{bpId}")
	public String anoDelController(@PathVariable("bpId") String bpId,Model model) {
		log.info("bpId : {}",bpId);
		int cnt = service.removeAno(bpId);
		if(cnt>0) {
			model.addAttribute("msg", "ok");
		}else {
			model.addAttribute("msg", "fail");
		}
		return "jsonView";
	}
	
	@GetMapping("ano/add")
	public String anoAddPage(
			@ModelAttribute("fileVO") BoardPostFileVO fileVO
			,@ModelAttribute("addAno") BoardPostVO addAno, Model model) {
		return "admin/anoboard/adminAnoAdd";
	}
	
	@PostMapping("ano/add")
	public String anoAddController(
			@Validated(AnoInsertGroup.class) @ModelAttribute("addAno")  BoardPostVO addAno,Errors errors,Model model,@RealUser EmpVO emp
			,@RequestPart(value="files", required = false) MultipartFile[] files
			) throws IOException {
		log.info("files: {}", files);
		log.info("realUser:{}", emp);
		log.info("addAno : {}",addAno);
		
		if(!errors.hasErrors()) {
			addAno.setEmpId(emp.getEmpId());//에러가 없으니까 실제 등록 처리
			
			int cnt = service.createAno(addAno);
			if(cnt>0) {
				//성공시
				return "redirect:/admin/ano";
			}else {
				//실패시
				return "admin/anoboard/adminAnoAdd";
			}
		}else {
			//에러가 있으니까 다시 입력처리
			return "admin/anoboard/adminAnoAdd";
		}
		
	}

	@PostMapping("ano/file/del/{bpFileId}")
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
