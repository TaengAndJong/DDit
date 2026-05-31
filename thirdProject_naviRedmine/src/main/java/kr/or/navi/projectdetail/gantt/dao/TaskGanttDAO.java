package kr.or.navi.projectdetail.gantt.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.IssueVO;
import kr.or.navi.vo.TaskVO;

@Mapper
public interface TaskGanttDAO {
	public int updateDate(TaskVO updateTask);
	public List<TaskVO> selectTaskList(@Param("paging") PaginationInfo paging,@Param("proId") String proId);
}
