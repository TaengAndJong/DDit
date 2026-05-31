package kr.or.navi.todaylist.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.ProjectVO;
import kr.or.navi.vo.TaskVO;
import kr.or.navi.vo.TodayListVO;

@Mapper
public interface TodayListDAO {
	public List<TodayListVO> selectTaskAllList(@Param("taskManId") String taskManId);
	//담당자가 본인인 일감 전체조회
	public List<TodayListVO> selectTaskList(
			@Param("paging") PaginationInfo paging,
			@Param("taskManId") String taskManId);
	public int selectTaskListTotalRecord(@Param("paging") PaginationInfo paging,@Param("taskManId") String taskManId);
	public int deleteTodayListOne(TodayListVO vo);
	//오늘의일감 추가 목록 조회
	public  List<TodayListVO> selectTodayList(@Param("empId") String empId,@Param("taskId") String taskId);
	//오늘의일정 모달 선택 추가시 테이블에 i
	public  int insertTdList(TodayListVO vo);
	public  int deleteTdList(@Param("taskId") String taskId,@Param("empId")String empId);
	public List<TodayListVO> selectTodayListAll(String taskManId);
	public int updateTaskList(TaskVO updateTaks);
}
