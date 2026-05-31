package kr.or.navi.projectdetail.dashboard.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.navi.projectdetail.dashboard.dao.DashBoardDAO;
import kr.or.navi.vo.TaskVO;
import kr.or.navi.vo.TeamVO;
@Service
public class DashBoardServiceImpl implements DashBoardService {
	@Inject
	private DashBoardDAO dao;
	@Override
	public List<TaskVO> retriveTaskList(String proId) {
		return dao.selectTaskList(proId);
	}
	@Override
	public List<TeamVO> retriveTeamList(String proId) {
		return dao.selectTeamList(proId);
	}

}
