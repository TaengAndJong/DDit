package kr.or.navi.projectdetail.gantt.service;

import java.util.List;

import kr.or.navi.projectdetail.gantt.vo.GanttVOEvent;
import kr.or.navi.vo.TaskVO;

public interface GanttService {
	public List<GanttVOEvent> getGanttEventList(String proId);
	public int modifyTask(TaskVO updateTask);
}
