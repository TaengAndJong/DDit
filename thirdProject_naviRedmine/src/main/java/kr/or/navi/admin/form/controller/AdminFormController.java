package kr.or.navi.admin.form.controller;

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

import kr.or.navi.board.form.service.FormService;
import kr.or.navi.common.paging.BootstrapFormBasePaginationRenderer;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.common.paging.PaginationRenderer;
import kr.or.navi.common.paging.SearchCondition;
import kr.or.navi.security.RealUser;
import kr.or.navi.validate.FormInsertGroup;
import kr.or.navi.vo.BoardPostFileVO;
import kr.or.navi.vo.BoardPostVO;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminFormController {
	
	@Inject
	private FormService service;

	@GetMapping("form")
	public String formPage(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			Model model, @ModelAttribute("simpleCondition") SearchCondition simpleCondition) {
		log.info("simpleCondition : {}", simpleCondition);
		PaginationInfo paging = new PaginationInfo(5, 5);
		paging.setCurrentPage(currentPage);
		paging.setSimpleCondition(simpleCondition);
		List<BoardPostVO> formList = service.retrieveFormList(paging);
		model.addAttribute("formList", formList);
		newCheck(formList);
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML", pagingHTML);
		model.addAttribute("paging", paging);
		return "admin/formboard/adminFormList";
	}
	
	private void newCheck(List<BoardPostVO> formList) {
		LocalDateTime now = LocalDateTime.now();
		for(BoardPostVO vo : formList) {
			LocalDateTime bpRegDt = vo.getBpRegDt();
	        Duration duration = Duration.between(bpRegDt, now);
	        long days = duration.toDays();
	        if (days >= 1) {
	        	vo.setNowCheck("1");
	        }
		}
	}

	@GetMapping("form/{bpId}")
	public String formDitailPage(@PathVariable String bpId, Model model) {
		BoardPostVO vo = service.retrieveForm(bpId);
		model.addAttribute("bf", vo);
		log.info("bf : {}", vo);
		List<BoardPostFileVO> bpfv = service.retrieveFormFile(bpId);
		log.info("bpfv:{}",bpfv);
		model.addAttribute("bpfv", bpfv);
		
		service.viewCnt(bpId);
		
		return "admin/formboard/adminFormDetail";
	}
	
	
	
	@GetMapping("form/download/{bpFileId}")
	public ResponseEntity<Resource> downloadFile(@PathVariable String bpFileId) throws IOException{
		return service.downloadFile(bpFileId);
	}
	
	

	@DeleteMapping("form/del/{bpId}")
	public String formDelController(@PathVariable String bpId, Model model) {
		log.info("bpId:{}", bpId);
		int cnt = service.removeForm(bpId);
		if (cnt > 0) {
			model.addAttribute("msg", "ok");
		} else {
			model.addAttribute("msg", "fail");
		}
		return "jsonView";
	}

	@GetMapping("/form/mod/{bpId}")
	public String formModPage(@PathVariable("bpId") String bpId, Model model) {
		BoardPostVO updateForm = service.retrieveForm(bpId);
		model.addAttribute("bf", updateForm);
		log.info("bf:{}",updateForm);
		List<BoardPostFileVO> bpfv = service.retrieveFormFile(bpId);
		log.info("bpfv:{}",bpfv);
		model.addAttribute("bpfv", bpfv);
		
		return "admin/formboard/adminFormMod";
	}

	@PostMapping("form/mod/{bpId}")
	@ResponseBody
	public Map<String, String> formModController(
			@ModelAttribute("form")
			BoardPostVO updateBp,
			@PathVariable String bpId, Model model, @RealUser EmpVO realUser) throws IOException {
		log.info("updateBp : {}", updateBp);
		Map<String, String> msg = new HashMap<String, String>();
		if (StringUtils.isNotBlank(updateBp.getBpCn()) && StringUtils.isNotBlank(updateBp.getBpTitle())) {
			updateBp.setBpId(bpId);
			updateBp.setEmpId(realUser.getEmpId());
			
			int cnt = service.modifyForm(updateBp);
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


	@GetMapping("form/add")
	public String formAddPage(
			@ModelAttribute("fileVO") BoardPostFileVO fileVO,
			@ModelAttribute("bf") BoardPostVO insertForm, Model model) {
		return "admin/formboard/adminFormAdd";
	}

	@PostMapping("form/add")
	public String formAddController(
			@Validated(FormInsertGroup.class) @ModelAttribute("bf") BoardPostVO vo,	Errors errors, Model model, @RealUser EmpVO realUser
			,@RequestPart(value="files", required = false) MultipartFile[] files
			) throws IOException {
		log.info("vo : {}", vo);
		
		if (!errors.hasErrors()) {
			vo.setEmpId(realUser.getEmpId());

			int cnt = service.createForm(vo);
			if (cnt > 0) {
				// 성공했을 경우
				return "redirect:/admin/form";
			} else {
				return "admin/formboard/adminFormAdd";
			}
		} else {
			return "admin/formboard/adminFormAdd";
		}

	}
	@PostMapping("form/file/del/{bpFileId}")
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
