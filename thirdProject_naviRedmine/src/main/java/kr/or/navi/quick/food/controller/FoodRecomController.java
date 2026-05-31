package kr.or.navi.quick.food.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.navi.common.paging.BootstrapFormBasePaginationRenderer;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.common.paging.PaginationRenderer;
import kr.or.navi.common.paging.SearchCondition;
import kr.or.navi.quick.food.service.FoodService;
import kr.or.navi.quick.food.vo.FoodVO;
import kr.or.navi.security.RealUser;
import kr.or.navi.vo.BoardPostVO;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.WeatherVO;
import kr.or.navi.weather.service.WeatherService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/quick/food")
@Controller
public class FoodRecomController {
	
	@Inject
	FoodService service;

	@Inject
	WeatherService weather;
	
	@GetMapping()
	public String foodPage(@RealUser EmpVO vo
			,@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage
			,@ModelAttribute("simpleCondition") SearchCondition simpleCondition
			,Model model) {
				//기본 viewCnt 0, 상세조회후에 +1씩 증가 (재반영필요)
				log.info("simpleCondition : {}",simpleCondition);
				PaginationInfo paging =  new PaginationInfo(8,4); // 기본 셋팅해주기
				log.info("paging : {}",paging);
				paging.setCurrentPage(currentPage);  // 현재페이지 초기값 설정
				paging.setSimpleCondition(simpleCondition); // 받아온 검색어로 셋팅
				
				// 음성검색 통한 조회
			    String searchWord = (String) simpleCondition.getSearchWord();
			   
			    List<FoodVO> foodList = service.selectVoiceFoodsList(paging, searchWord);
			    if (searchWord != null && searchWord.startsWith(",")) {
			        searchWord = searchWord.substring(1).trim();
			    }
			 
			    log.info("searchWord : {}", searchWord);
				
				//음식점 조회 , 페이지와 파라미터로 넘어온 검색어 설정
				String weatherType = weather.selectCurWeather().getWeatherType();
				List<FoodVO> recomList = service.recomFoodList(vo, weatherType);
				
				model.addAttribute("recomList",recomList);
				
				log.info("foodList : {}", foodList);
				
				if (foodList != null) {
					model.addAttribute("foodList",foodList);
				} else {
				    log.info("foodList null:{}","foodList null");
				}
				
				//4.페이지네이션 그려주기
				PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
				//5.페이지네이션 html String값으로 넘겨주기
				String pagingHTML = renderer.renderPagination(paging);
				//6.모델에 담아서 뷰로 보내기
				model.addAttribute("pagingHTML",pagingHTML);
				model.addAttribute("paging",paging);
				log.info("pagingHTML: {} ",pagingHTML);
				log.info("paging: {} ",paging);
		
				
				return "quick/foodList";
	}
	
	
	//food 상세조회
	@GetMapping("{foodId}")
	public String foodDatail(@RealUser EmpVO vo,@PathVariable String foodId,Model model) {
		// 상세 겟요청을 받으면 기본 viewCnt 조회 수가 1씩 증가, -> 해당 아이디의 viewCnt 값 수정하여 업데이트 해줌
		//어떤식으로 업데이트 할것인가..!
		
		log.info("weather.selectWeatherList():{}",weather.selectWeatherList());
		
		String empId = vo.getEmpId();
		String weatherId = weather.selectCurWeather().getWeatherId();
		FoodVO foodInfo = service.selectOne(foodId);
		log.info("empId",empId);
		log.info("weatherId",weatherId);
		log.info("foodInfo",foodInfo);
		log.info("service.insertFoodViews(empId, foodId, weatherId) :{}",service.insertFoodViews(empId, foodId, weatherId));
		
		model.addAttribute("foodId",foodId);
		model.addAttribute("foodInfo",foodInfo);
		
		return "quick/foodDetail";//뷰 jsp로 반환
	}
	
	
	
	

	
}
