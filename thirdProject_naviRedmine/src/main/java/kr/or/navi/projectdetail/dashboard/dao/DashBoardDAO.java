package kr.or.navi.projectdetail.dashboard.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.navi.vo.TaskVO;
import kr.or.navi.vo.TeamVO;

@Mapper
public interface DashBoardDAO {
	public List<TaskVO> selectTaskList(String proId);
	public List<TeamVO> selectTeamList(String proId);
}
