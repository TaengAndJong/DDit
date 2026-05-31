package kr.or.navi.projectdetail.gantt.vo;

import java.io.Serializable;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;

import kr.or.navi.vo.TaskVO;
import lombok.Data;

public class GanttEventVO implements Serializable{
	
	private transient TaskVO task;
	private String idx;
	private String nm;
	private String tite;
	private String con;
	private List<HashMap<String, Object>> values=new LinkedList<HashMap<String,Object>>();
	public void setIdx(int idx) {
		this.idx=""+idx;
	}
	public GanttEventVO(TaskVO task) {
		this.task=task;
	}
	public String getNm() {
		return task.getTaskManName();
	}
	public String getTite() {
		return task.getTaskTitle();
	}
	public String getCon() {
		return task.getTaskCn();
	}
	public String getIdx() {
		return idx;
	}
	public List<HashMap<String, Object>> getValues() {
		LocalDateTime rd = task.getTaskRegDt();
		Instant it = rd.toInstant(ZoneOffset.UTC);
		Long regEpochMilli = it.toEpochMilli();
		String tsId = task.getTsId();
		int endDays=0;
		if("T00003".equals(tsId)) {
			endDays=3;
		}else {
			endDays=7;
		}
		LocalDateTime rd1 = rd.plusDays(endDays);
		Instant it1 = rd1.toInstant(ZoneOffset.UTC);
		Long endEpochMilli = it1.toEpochMilli();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("from",regEpochMilli);
		map.put("to",endEpochMilli);
		map.put("label", task.getTaskTitle());
		map.put("customClass", "ganttRed");
		values.add(map);
		HashMap<String, Object> map1 = new HashMap<String, Object>();
		map1.put("from",regEpochMilli+100000);
		map1.put("to",endEpochMilli+100000);
		map1.put("label", task.getTaskTitle()+"22222");
		map1.put("customClass", "ganttRed");
		values.add(map1);
		return values;
	}
	@Override
	public String toString() {
		return task.toString();
	}
}
