package kr.or.navi.admin.project.service;

import java.util.List;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.ProjectVO;

public interface AdminProjectService {
	
	public List<ProjectVO> projectRestoreList(PaginationInfo paging);
	public boolean authPL(EmpVO vo,ProjectVO project);
	public int projectCheckedDelete(List<ProjectVO> project);
	public int projectCheckedRestore(List<ProjectVO> project);
	
	public int retriveNewTotalCnt();
	public int retriveQuickTotalCnt();
	public int retriveSafeTotalCnt();
	public int retriveDelTotalCnt();
	
	
}
