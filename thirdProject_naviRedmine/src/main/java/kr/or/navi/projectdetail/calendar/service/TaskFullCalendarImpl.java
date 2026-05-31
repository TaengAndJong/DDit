package kr.or.navi.projectdetail.calendar.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import kr.or.navi.projectdetail.calendar.dao.TaskFulDAO;
import kr.or.navi.projectdetail.calendar.vo.TaskFulAdapterVO;
import kr.or.navi.vo.TaskVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class TaskFullCalendarImpl implements TaskFullCalendarService {
	@Inject
	private TaskFulDAO dao;
	@Override
	public List<TaskVO> retrieveTaskList(String proId,String solaDate) {
		return dao.selectTaskList(proId,solaDate);
	}
	@Override
	public List<TaskFulAdapterVO> retrieveTaskAdapterList(String proId) {
		List<TaskFulAdapterVO> list = dao.selectTaskFulAdapterVOList();
		List<TaskFulAdapterVO> returnList = new ArrayList<>();
		for(TaskFulAdapterVO vo : list) {
			String solaDate = vo.getSolasrDate();
			List<TaskVO> tasklist = retrieveTaskList(proId,solaDate);
			if(tasklist.size()==0) {
			}else {
				vo.setTaskList(tasklist);
				returnList.add(vo);
			}
		}
		log.info("returnList.size() : {}",returnList.size());
		return returnList;
	}

}
