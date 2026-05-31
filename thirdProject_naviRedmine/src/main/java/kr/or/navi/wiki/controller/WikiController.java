package kr.or.navi.wiki.controller;

import java.io.IOException;
import java.time.Duration;
import java.time.LocalDateTime;
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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.navi.common.paging.BootstrapFormBasePaginationRenderer;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.common.paging.PaginationRenderer;
import kr.or.navi.common.paging.SearchCondition;
import kr.or.navi.project.service.ProjectService;
import kr.or.navi.security.RealUser;
import kr.or.navi.validate.InsertGroup;
import kr.or.navi.vo.BoardPostVO;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.IssueFileVO;
import kr.or.navi.vo.ProjectVO;
import kr.or.navi.vo.WikiFileVO;
import kr.or.navi.vo.WikiVO;
import kr.or.navi.wiki.service.WikiService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/wiki")
public class WikiController {
	@Inject
	private ProjectService proService;

	@Inject
	private WikiService service;
	
	@GetMapping
	public String wikiPage(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage
			, String wikiId
			, Model model
			, @ModelAttribute("simpleCondition") SearchCondition simpleCondition
			) {
		PaginationInfo paging = new PaginationInfo(10,10);
		paging.setSimpleCondition(simpleCondition);
		paging.setCurrentPage(currentPage);
		List<WikiVO> wikiList = service.retrieveWikiList(paging);
		model.addAttribute("wikiList", wikiList);
		List<WikiFileVO> fileList = service.retriveFileList(wikiId);
		model.addAttribute("fileList", fileList);
		log.info("fileList : {}", fileList);
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML", pagingHTML);
		model.addAttribute("paging", paging);
		return "wiki/wiki";
	}
	
	@GetMapping("{wikiId}")
	public String wikiDetailPage(@PathVariable String wikiId, Model model) {
		WikiVO wiki = service.retrieveWiki(wikiId);
		model.addAttribute("wiki", wiki);
		List<WikiFileVO> fileList = service.retriveFileList(wikiId);
		model.addAttribute("fileList", fileList);
		return "wiki/wiki_detail";
	}

	@GetMapping("/mod/{wikiId}")
	public String wikiModifyPage(@PathVariable("wikiId") String wikiId, Model model) {
		WikiVO wikiForm = service.retrieveWiki(wikiId);
		model.addAttribute("wiki", wikiForm);
		List<WikiFileVO> fileList = service.retriveFileList(wikiId);
		model.addAttribute("fileList", fileList);
		return "wiki/wiki_mod";
	}

	@PostMapping("mod/{wikiId}")
	@ResponseBody
	public Map<String, String>  wikiPutController(@ModelAttribute("wiki") WikiVO updateWiki, @PathVariable String wikiId, Model model, @RealUser EmpVO realUser) throws IOException {
		log.info("updateWiki:{}", updateWiki);
		Map<String, String> map = new HashedMap();
		if(StringUtils.isNotBlank(updateWiki.getWikiCn()) && StringUtils.isNotBlank(updateWiki.getWikiTitle())) {
			updateWiki.setWikiId(wikiId);
			updateWiki.setEmpId(realUser.getEmpId());
			int cnt = service.modifyWiki(updateWiki);
			if(cnt>0) {
				map.put("msg", "ok");
			}else {
				map.put("msg", "fail");
			}
		}else {
			map.put("msg", "empty");
		}
		return map;
	}
//	
//	@DeleteMapping("del/{bpId}")
//	public String wikiDelController(@PathVariable String bpId, Model model) {
//		log.info("bpId:{}",bpId);
//		int cnt = service.removeWiki(bpId);
//		if(cnt>0) {
//			model.addAttribute("msg", "ok");
//		}else {
//			model.addAttribute("msg", "fail");
//		}
//		return "jsonView";
//	}
//	
	@GetMapping("/add/{proId}")
	public String wikiRegisterPage(@ModelAttribute("wiki") WikiVO vo, Model model,@PathVariable String proId) {
		ProjectVO projectOne = proService.projectOne(proId);
		log.info("wiki : {}",projectOne);
		model.addAttribute("pro", projectOne);
		return "wiki/wiki_register";
	}
	@PostMapping("/add/{proId}")
	public String wikiAddController(@Validated(Default.class) @ModelAttribute("wiki") WikiVO vo, Errors errors, Model model, @RealUser EmpVO realUser,@PathVariable String proId) throws IOException {
		log.info("wiki:{}", vo);
		log.info("errors :{}", errors);
		vo.setProId(proId);
		ProjectVO projectOne = proService.projectOne(proId);
		log.info("projectOne : {}",projectOne);
		model.addAttribute("pro", projectOne);
		if(!errors.hasErrors()) {
			vo.setEmpId(realUser.getEmpId());				
			int cnt = service.createWiki(vo);
			if(cnt>0) {
				return "redirect:/wiki";
			}else {
				return "wiki/wiki_register";
			}
		}else {
			return "wiki/wiki_register";
		}
	}
	@GetMapping("download/{wfId}")
	public ResponseEntity<Resource> downloadFile(@PathVariable String wfId) throws IOException{
		return service.downloadFile(wfId);
	}
	@PostMapping("file/del/{wfId}")
	@ResponseBody
	public Map<String, String> isssueFileDelController(@PathVariable String wfId) throws IOException {
		int cnt = service.removeWikiFile(wfId);
		Map<String, String> msg = new HashedMap();
		if(cnt>0) {
			msg.put("msg", "ok");
		}else {
			msg.put("msg", "fail");
		}
		return msg;
	}
}

