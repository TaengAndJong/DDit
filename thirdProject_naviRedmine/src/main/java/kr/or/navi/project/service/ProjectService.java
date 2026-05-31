package kr.or.navi.project.service;

import java.util.List;
import java.util.Map;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.IssueVO;
import kr.or.navi.vo.ProjectVO;
import kr.or.navi.vo.TeamVO;

public interface ProjectService {
	public ProjectVO projectOne(String proId);
	public List<ProjectVO> projectList(PaginationInfo paging);
	public List<IssueVO> issueList(String proId,PaginationInfo paging);
	public boolean authPL(EmpVO vo,ProjectVO project);
	public int modifyProject(ProjectVO project);
	public int projectDelete(ProjectVO project);
	public int createProject(ProjectVO project,String empIds,String roleIds,EmpVO realUser);
	public List<EmpVO> selectPlList();
	public List<EmpVO> selectEmpList();
	public List<TeamVO> retrieveTeamList(PaginationInfo paging, String proId);
	public int modifyTeamYN(String proId,String empId);
	public List<EmpVO> selectOutEmpList(String proId,PaginationInfo paging);
	public int createTeam(EmpVO emp,String proId);
	public int endProject(String proId);
	public Map<String, Object> projectAllIng();

}
