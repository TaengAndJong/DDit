package kr.or.navi.quick.news.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.navi.quick.news.service.NewsService;
import kr.or.navi.quick.news.vo.NewsVO;
import kr.or.navi.security.RealUser;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/quick/news")
@Slf4j
public class NewsRecomController {
	@Inject
	private NewsService service;
	
	@GetMapping
	public String newsPage(@RealUser EmpVO vo ,Model model) {
		List<NewsVO> newsList = service.selectNewsList();
		List<NewsVO> recomList = service.recomNewsList(vo);
		model.addAttribute("newsList",newsList);
		model.addAttribute("recomList",recomList);
		return "quick/newsList";
	}
	
	@PostMapping
	@ResponseBody
	public String clickCnt(@RealUser EmpVO vo ,@RequestParam("newsId")String newsId) {
		int cnt = service.insertNewsView(vo.getEmpId(), newsId);
		if(cnt>0) {
			return "ok";
		}
		return "no";
	}
	
	
}
