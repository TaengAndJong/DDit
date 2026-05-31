package kr.or.navi.admin.task.service;

import java.util.List;

import kr.or.navi.vo.TaskVO;

public interface AdminTaskService {

	public int taskCheckedDelete(List<TaskVO> task);
}
