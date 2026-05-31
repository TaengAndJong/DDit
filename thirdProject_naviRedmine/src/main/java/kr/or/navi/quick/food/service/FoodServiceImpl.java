package kr.or.navi.quick.food.service;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.quick.food.dao.FoodDAO;
import kr.or.navi.quick.food.vo.FoodVO;
import kr.or.navi.quick.news.service.NewsServiceImpl;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.TaskVO;
import kr.or.navi.vo.WeatherVO;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service
public class FoodServiceImpl implements FoodService {

	@Inject
	private FoodDAO dao;
	
	@Override
	public List<FoodVO> selectFoodsList() {// 음식점 전체 조회
		log.info("dao.selectfoodList():{}" ,dao.selectFoodList());
		return dao.selectFoodList();
	}

	@Override
	public FoodVO selectOne(String foodId) {
		log.info("dao.selectOne(foodId):{}" ,dao.selectOne(foodId));
		return dao.selectOne(foodId);
	}

	@Override
	public int insertFoodViews(String empId, String foodId, String weatherId) {
		log.info("dao.insertFoodViews(empId, foodId, weatherId):{}" ,dao.insertFoodViews(empId, foodId, weatherId));
		return dao.insertFoodViews(empId, foodId, weatherId);
		
	}

	@Override
	public List<FoodVO> recomFoodList(EmpVO vo, String weathertype) {
		Integer empAge = vo.getEmpAge();
		String empGen = vo.getEmpGen();
		String wd = weathertype;
		HashMap<String, String> map = trasEmpData(empAge, empGen, wd);
		log.info("map:{}",map);
		return dao.selectRecomFoodList(map);
	}

	
	private HashMap<String, String> trasEmpData(Integer empAge,String empGen,String weatherType){
		HashMap<String, String> map = new HashMap<String, String>();
		if(empAge>=20) {
			map.put("age", "0");
		}else if(empAge>=30) {
			map.put("age", "1");
		}else if(empAge>=40) {
			map.put("age", "2");
		}else if(empAge>=50) {
			map.put("age", "3");
		}else {
			map.put("age", "4");
		}
		
		
		if(empGen.equals("F")) {
			map.put("gen", "0");
		}else {
			map.put("gen", "1");
		}
		

		if(weatherType.contains("맑음")) {
			map.put("weatherId","0");
		}else if(weatherType.contains("흐림")) {
			map.put("weatherId","1");
		}else if(weatherType.contains("구름많음")) {
			map.put("weatherId","2");
		}else if(weatherType.contains("비")) {
			map.put("weatherId","3");
		}else if(weatherType.contains("눈")){
			map.put("weatherId","4");
		}else {
			map.put("weatherId","5");
		}
		
		return map;
	}

	@Override
	public List<FoodVO> selectVoiceFoodsList(PaginationInfo paging, String searchWord) {
		int totalRecord = dao.selectFoodListTotalRecord(paging, searchWord);
		paging.setTotalRecord(totalRecord); // 컨트롤러로부터 받아오는 정보를 셋팅해서, paginationInfo 에게 넘겨주기
		return dao.selectVoiceFoodList(paging,searchWord);
	}

	

}
