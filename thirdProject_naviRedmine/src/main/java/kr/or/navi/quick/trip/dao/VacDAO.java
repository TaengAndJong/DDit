package kr.or.navi.quick.trip.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.quick.news.vo.NewsVO;
import kr.or.navi.quick.trip.vo.VacVO;
import kr.or.navi.vo.ProjectVO;

@Mapper
public interface VacDAO {
	public int selectTotalRecord();
	public List<VacVO> selectVacList(PaginationInfo paging);
	public List<VacVO> selectRecomVacList(@Param("map") HashMap<String, String> map);
	public int insertVacView(@Param("empId") String empId, @Param("vacId") String vacId);
	public int updateView(@Param("vacId") String vacId);
}
