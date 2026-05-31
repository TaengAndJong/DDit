package kr.or.navi.projectdetail.dashboard.service;

import java.util.List;

import kr.or.navi.vo.TaskVO;
import kr.or.navi.vo.TeamVO;

public interface DashBoardService {
	public List<TaskVO> retriveTaskList(String proId);
	public List<TeamVO> retriveTeamList(String proId);
}
