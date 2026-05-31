package kr.or.navi.todaylist.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.task.dao.TaskDAO;
import kr.or.navi.todaylist.dao.TodayListDAO;
import kr.or.navi.vo.TaskVO;
import kr.or.navi.vo.TodayListVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class TodayListServiceImple implements TodayListService{
	
	@Inject
	TodayListDAO tdDao;
	
	@Inject
	TaskDAO tsDao;

	@Override
	public List<TodayListVO> selectTaskList(PaginationInfo paging, String taskManId) {
		return tdDao.selectTaskList(paging, taskManId);
	}
	
	
	
	
	@Override
	public List<TodayListVO> selectTodayList(String empId,String taskId) {
	    return tdDao.selectTodayList(empId,taskId);
	}

	@Override
	public int insertTdList(TodayListVO vo) {
		return tdDao.insertTdList(vo);
	}

	@Override
	public int deleteTdList(String taskId,String empId) {
		return tdDao.deleteTdList(taskId,empId);
	}




	@Override
	public List<TodayListVO> selectTaskAllList(String taskManId) {
		return tdDao.selectTaskAllList(taskManId);
	}




	@Override
	public List<TodayListVO> selectTodayListAll(String taskManId) {
		return tdDao.selectTodayListAll(taskManId);
	}




	@Override
	public int modifyTodayList(List<TaskVO> updateTaskList) {
		int cnt=0;
		if(updateTaskList.size()>0) {
			for(TaskVO updateTask:updateTaskList) {
				cnt+=tdDao.updateTaskList(updateTask);
			}
		}
		return cnt;
	}

	

	

	







	

}
