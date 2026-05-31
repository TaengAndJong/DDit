package kr.or.navi.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.project.dao.IssueDAO;
import kr.or.navi.project.dao.ProjectDAO;
import kr.or.navi.project.dao.TeamDAO;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.FileSaveVO;
import kr.or.navi.vo.IssueVO;
import kr.or.navi.vo.ProjectVO;
import kr.or.navi.vo.TeamVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProjectServiceImple implements ProjectService {
	@Inject
	private ProjectDAO projectDao;
	@Inject
	private IssueDAO issueDao;
	@Inject
	private TeamDAO teamDao;
	@Override
	public List<ProjectVO> projectList(PaginationInfo paging) {
		int totalRecord = projectDao.selectTotalRecord(paging);
		paging.setTotalRecord(totalRecord);
		return projectDao.selectList(paging);
	}
	@Override
	public List<IssueVO> issueList(String proId,PaginationInfo paging) {
		int totalRecord = issueDao.selectTotalRecord(proId,paging);
		paging.setTotalRecord(totalRecord);
		return issueDao.selectIssueList(proId, paging);
	}
	@Override
	public ProjectVO projectOne(String proId) {
		ProjectVO projectVO = projectDao.selectProject(proId);
		//팀원들 조회를 여기서...할것.
		return projectVO;
	}
	@Override
	public boolean authPL(EmpVO vo,ProjectVO project) {
			//코딩 가이드 필요라인
			return project.isPLMember(vo);
	}
	@Override
	public int modifyProject(ProjectVO project) {
		return projectDao.updateProject(project);
	}
	@Override
	public int projectDelete(ProjectVO project) {
		return projectDao.deleteProject(project);
	}
	@Override
	public int createProject(ProjectVO project,String empIds,String roleIds, EmpVO realUser) {
		try {
			int cnt = projectDao.insertProject(project);
			String[] empArr = empIds.split(",");
			String[] roleArr = roleIds.split(",");
			if(cnt>0) {
				FileSaveVO vo = new FileSaveVO();
				vo.setProId(projectDao.selectMaxProjectId());
				vo.setFsId(projectDao.selectMaxFileSaveId());
				int fcnt = projectDao.insertFileSave(vo);
				String empId = realUser.getEmpId();
				projectDao.insertTeam(empId, "ROLE_PL");
				for(int i=0;i<empArr.length;i++) {
					projectDao.insertTeam(empArr[i].trim(), roleArr[i].trim());
				}
				cnt+=fcnt;
			}
			return cnt;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	@Override
	public List<EmpVO> selectPlList() {
		return projectDao.selectPlList();
	}
	@Override
	public List<EmpVO> selectEmpList() {
		return projectDao.selectEmpList();
	}
	@Override
	public List<TeamVO> retrieveTeamList(PaginationInfo paging,String proId) {
		int totalRecord = teamDao.selectTotalRecord(paging, proId);
		paging.setTotalRecord(totalRecord);
		return teamDao.selectTeams(paging,proId);
	}
	@Override
	public int modifyTeamYN(String proId, String empId) {
		String teamYN = teamDao.selectTeamYN(proId, empId);
		if("Y".equals(teamYN)) {
			return teamDao.updateTeamYN(proId, empId,"N");
		}else {
			return teamDao.updateTeamYN(proId, empId,"Y");
		}
	}
	@Override
	public List<EmpVO> selectOutEmpList(String proId,PaginationInfo paging) {
		int total = projectDao.selectOutEmpTotalRecord(proId,paging);
		paging.setTotalRecord(total);
		return projectDao.selectOutEmpList(proId,paging);
	}
	@Override
	public int createTeam(EmpVO emp,String proId) {
		return projectDao.insertUpTeam(emp,proId);
	}
	@Override
	public int endProject(String proId) {
		return projectDao.endProject(proId);
	}
	@Override
	public Map<String, Object> projectAllIng() {
		Map<String, Object> map = new HashMap<String, Object>();
		List<ProjectVO> selectProjectAll = projectDao.selectProjectAll();
		int total=0;
		int cnt=0;
		map.put("PS0001",0);
		map.put("PS0002",0);
		map.put("PS0003",0);
		for(ProjectVO project : selectProjectAll) {
			total+=project.getProIng();
			cnt++;
			if("PS0001".equals(project.getProStId())){
				map.put("PS0001", (Integer)(map.get("PS0001"))+1);
			}
			if("PS0002".equals(project.getProStId())){
				map.put("PS0002", (Integer)(map.get("PS0002"))+1);
			}
			if("PS0003".equals(project.getProStId())){
				map.put("PS0003", (Integer)(map.get("PS0003"))+1);
			}
		}
		map.put("projectTotalIng", total/cnt);
		
		return map;
	}
	

	
	
	
}
