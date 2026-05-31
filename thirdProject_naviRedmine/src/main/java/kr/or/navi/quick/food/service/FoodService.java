package kr.or.navi.quick.food.service;

import java.util.List;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.quick.food.vo.FoodVO;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.WeatherVO;

public interface FoodService {

	public List<FoodVO> selectFoodsList();
	public List<FoodVO> selectVoiceFoodsList(PaginationInfo paging, String searchWord);
	public FoodVO selectOne(String foodId); // 상세페이지로 이동하기위한 단일 조회
	public List<FoodVO> recomFoodList(EmpVO vo,String weatherType); // 한 사원에 대한 음식 추천 목록
	public int insertFoodViews(String empId,String foodId, String weatherId); //추천테이블이 넣어줄 데이터를 command Object를 통해 넣어줄  메소드
	
	
}
