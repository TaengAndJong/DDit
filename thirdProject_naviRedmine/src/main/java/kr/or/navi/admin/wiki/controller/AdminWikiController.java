package kr.or.navi.admin.wiki.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.navi.common.paging.BootstrapFormBasePaginationRenderer;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.common.paging.PaginationRenderer;
import kr.or.navi.common.paging.SearchCondition;
import kr.or.navi.vo.WikiVO;
import kr.or.navi.wiki.service.WikiService;

@Controller
@RequestMapping("/admin")
public class AdminWikiController {
	@Inject
	private WikiService service;

	@GetMapping("wiki")
	public String projectPage(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			Model model, @ModelAttribute("simpleCondition") SearchCondition simpleCondition) {
		PaginationInfo paging = new PaginationInfo(6, 5);
		paging.setSimpleCondition(simpleCondition);
		paging.setCurrentPage(currentPage);
		List<WikiVO> wikiList = service.retrieveWikiList(paging);
		model.addAttribute("wikiList", wikiList);
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML", pagingHTML);
		model.addAttribute("paging", paging);
		return "admin/wiki/adminWikiList";
	}

}
