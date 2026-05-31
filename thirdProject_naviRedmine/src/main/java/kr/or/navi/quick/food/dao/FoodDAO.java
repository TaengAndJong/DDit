package kr.or.navi.quick.food.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.quick.food.vo.FoodVO;

@Mapper
public interface FoodDAO {
	
	//음식점 전체조회
	public List<FoodVO> selectFoodList();
	public List<FoodVO> selectVoiceFoodList(@Param("paging") PaginationInfo paging,@Param("searchWord") String searchWord);
	public int selectFoodListTotalRecord(@Param("paging") PaginationInfo paging,@Param("searchWord") String searchWord);
	public FoodVO selectOne(String foodId);
	//추천 결과테이블을 map으로 형성
	public List<FoodVO> selectRecomFoodList(@Param("map") HashMap<String, String> map);
	//한사람의 유저를 기준으로 한 음식좀 조회리스트를 추천에 넣어줌
	public int insertFoodViews(@Param("empId") String empId, @Param("foodId") String foodId, @Param("weatherId") String weatherId);

}
