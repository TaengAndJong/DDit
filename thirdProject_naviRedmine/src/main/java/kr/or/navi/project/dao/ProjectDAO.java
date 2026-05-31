package kr.or.navi.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.FileSaveVO;
import kr.or.navi.vo.ProjectVO;

@Mapper
public interface ProjectDAO {
	public List<ProjectVO> selectList(PaginationInfo paging);
	public ProjectVO selectProject(String proId);
	public int selectTotalRecord(PaginationInfo paging);
	public int updateProject(@Param("project")ProjectVO  project);
	public int deleteProject(@Param("project")ProjectVO  project);
	public int insertProject(@Param("project")ProjectVO  project);
	public int insertFileSave(@Param("vo") FileSaveVO vo);
	public int insertTeam(@Param("empId") String empId,@Param("roleId") String roleId);
	public int insertUpTeam(@Param("emp")EmpVO emp,@Param("proId")String proId);
	public String selectMaxProjectId();
	public String selectMaxFileSaveId();
	public List<EmpVO> selectPlList();
	public List<EmpVO> selectEmpList();
	public List<EmpVO> selectOutEmpList(@Param("proId")String proId,@Param("paging")PaginationInfo paging);
	public int selectOutEmpTotalRecord(@Param("proId")String proId,@Param("paging")PaginationInfo paging);
	public int endProject(String proId);
	public List<ProjectVO> selectProjectAll();
	
	
}
