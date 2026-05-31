package kr.or.navi.mypagedetail.alarm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.AlarmVO;

@Mapper
public interface AlramDAO {
	public List<AlarmVO> selectAlramList(@Param("empId") String empId,@Param("paging")PaginationInfo paging);
	public int selectTotalRecord(@Param("empId")String empId,@Param("paging")PaginationInfo paging);
	public List<AlarmVO> selectDisplayAlramList(String empId);
	public int insertAlram(AlarmVO regVO);
	public int updateReadAlram(String alram);
	public int updateReadAlramAll(String alram);
}
