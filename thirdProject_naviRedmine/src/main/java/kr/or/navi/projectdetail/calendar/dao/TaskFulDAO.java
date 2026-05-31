package kr.or.navi.projectdetail.calendar.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.navi.projectdetail.calendar.vo.TaskFulAdapterVO;
import kr.or.navi.vo.TaskVO;

@Mapper
public interface TaskFulDAO {
	public List<TaskVO> selectTaskList(@Param("proId") String proId,@Param("solaDate") String solaDate);
	public List<TaskFulAdapterVO> selectTaskFulAdapterVOList();
}
