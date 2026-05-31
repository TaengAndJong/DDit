package kr.or.navi.todaylist.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.annotations.Param;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.task.dao.TaskDAO;
import kr.or.navi.todaylist.dao.TodayListDAO;
import kr.or.navi.vo.TaskVO;
import kr.or.navi.vo.TodayListVO;

public interface TodayListService {
	
	public List<TodayListVO> selectTaskAllList(String taskManId);
	public List<TodayListVO> selectTaskList(PaginationInfo paging,String taskManId);
	public List<TodayListVO> selectTodayList(String empId,String taskId);
	public	int insertTdList(TodayListVO vo);
	public  int deleteTdList(String taskId,String empId);
	public List<TodayListVO> selectTodayListAll(String taskManId);
	public int modifyTodayList(List<TaskVO> updateTaskList);

}
