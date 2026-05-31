package kr.or.navi.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.TeamVO;
@Mapper
public interface TeamDAO {
	public List<TeamVO> selectTeam(@Param("proId")String proId);
	public TeamVO selectTeamList(@Param("proId") String proId,@Param("empId") String empId);
	public List<TeamVO> selectTeams(@Param("paging")PaginationInfo paging, @Param("proId")String proId);
	public int selectTotalRecord(@Param("paging")PaginationInfo paging,@Param("proId")String proId);
	public int updateTeamYN(@Param("proId") String proId,@Param("empId") String empId,@Param("yn")String yn);
	public String selectTeamYN(@Param("proId")String proId,@Param("empId") String empId);
	public String selectPlId(String proId);
	public List<TeamVO> selectTeamAll(String proId);
}
