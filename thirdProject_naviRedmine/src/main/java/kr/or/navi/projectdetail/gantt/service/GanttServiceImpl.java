package kr.or.navi.projectdetail.gantt.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.projectdetail.gantt.dao.TaskGanttDAO;
import kr.or.navi.projectdetail.gantt.vo.GanttEventVO;
import kr.or.navi.projectdetail.gantt.vo.GanttVOEvent;
import kr.or.navi.task.dao.TaskDAO;
import kr.or.navi.vo.TaskVO;

@Service
public class GanttServiceImpl implements GanttService {
	@Inject
	public TaskDAO dao;
	
	@Inject
	private TaskGanttDAO ganttDao;
	@Override
	public List<GanttVOEvent> getGanttEventList(String proId) {
		List<GanttVOEvent> list = ganttDao.selectTaskList(new PaginationInfo(),proId)
				.stream().map(tv->new GanttVOEvent(tv)
		).collect(Collectors.toList());
		List<GanttVOEvent> sortList = new ArrayList<GanttVOEvent>();
		 for (GanttVOEvent event : list) {
	            if (event.getDependencies() == null || event.getDependencies().isEmpty()) {
	                processGanttVOEvent(event, sortList, list);
	            }
	        }
		return list;
	}
	@Override
	public int modifyTask(TaskVO updateTask) {
		updateTask.setTaskCompDt(updateTask.refairTaskCompDt());
		return ganttDao.updateDate(updateTask);
	}
	private void processGanttVOEvent(GanttVOEvent event, List<GanttVOEvent> sortedEvents, List<GanttVOEvent> ganttVOEvents) {
        // 현재 일감 추가
       
		sortedEvents.add(event);
        // 현재 일감의 하위 일감들 탐색
        for (GanttVOEvent childEvent : ganttVOEvents) {
            if (event.getId().equals(childEvent.getDependencies())) {
                processGanttVOEvent(childEvent, sortedEvents, ganttVOEvents);
            }
        }
        
        
    }
}
