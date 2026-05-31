package kr.or.navi.projectdetail.calendar.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.navi.projectdetail.calendar.vo.TaskFulAdapterVO;
import kr.or.navi.vo.TaskVO;

public interface TaskFullCalendarService {
	public List<TaskVO>retrieveTaskList(String proId,String solaDate);
	public List<TaskFulAdapterVO>retrieveTaskAdapterList(String proId);
}
