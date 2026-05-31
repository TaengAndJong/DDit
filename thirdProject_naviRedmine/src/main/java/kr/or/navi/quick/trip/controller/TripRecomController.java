package kr.or.navi.quick.trip.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.navi.common.paging.BootstrapFormBasePaginationRenderer;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.common.paging.PaginationRenderer;
import kr.or.navi.quick.trip.service.VacService;
import kr.or.navi.quick.trip.vo.VacVO;
import kr.or.navi.security.RealUser;
import kr.or.navi.util.HttpUtil;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/quick/vac")
@Slf4j
public class TripRecomController {

	@Inject
	private VacService service;

	@GetMapping
	public String vacPage(@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
							@RealUser EmpVO vo, Model model) {
		PaginationInfo paging = new PaginationInfo(52, 3);
		paging.setCurrentPage(currentPage);
		
		List<VacVO> vacList = service.selectVacList(paging);
//		vacList.set("viewCnt", viewCnt)
		List<VacVO> recomList = service.recomVacList(vo);
		model.addAttribute("vacList", vacList);
		model.addAttribute("recomList",recomList);
		log.info("vacList : {}",vacList);
		
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML", pagingHTML);
		model.addAttribute("paging", paging);
		
		return "quick/vacList";
	}

	@PostMapping
	@ResponseBody
	public String clickCnt(@RealUser EmpVO vo, @RequestParam("vacId") String vacId) {
		int cnt = service.insertVacView(vo.getEmpId(), vacId);
		
		int viewCnt = service.viewCnt(vacId);
		log.info("viewCnt:{}",viewCnt);
		
		if(cnt>0) {
			log.info("cnt:{}",cnt);
			return "ok";
		}
		return "no";
	}
	
	/*
	 * @GetMapping() public String vacOne(@RequestParam("vacId") String vacId, Model
	 * model) { VacVO vacOne = service.selectVacOne(vacId);
	 * model.addAttribute("vacOne",vacOne);
	 * 
	 * return "quick/vacOne"; }
	 */
}

//fetch("/navi/quick/trip?age=3&per=4&ssn=1",{
//    method:"get",
//    header:{
//        accept:'application/json;charset=utf-8'
//    }
//}).then(resp=>{
//    return resp.json()
//}).then(jsonObj=>{
//    console.log(jsonObj)
//})
