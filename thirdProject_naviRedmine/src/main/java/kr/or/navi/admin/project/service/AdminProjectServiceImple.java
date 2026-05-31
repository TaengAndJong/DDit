package kr.or.navi.admin.project.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.navi.admin.project.dao.AdminProjectDAO;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.project.dao.IssueDAO;
import kr.or.navi.project.dao.ProjectDAO;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.IssueVO;
import kr.or.navi.vo.ProjectVO;
import kr.or.navi.vo.TeamVO;

@Service
public class AdminProjectServiceImple implements AdminProjectService {
	@Inject
	private AdminProjectDAO adminProjectDao;

	@Override
	public List<ProjectVO> projectRestoreList(PaginationInfo paging) {
		int totalRecord = adminProjectDao.selectTotalRecord(paging);
		paging.setTotalRecord(totalRecord);
		return adminProjectDao.selectList(paging);
	
	}
	@Override
	public boolean authPL(EmpVO vo, ProjectVO project) {
		return project.isPLMember(vo);
	}

	/**
	 *선택된 프로젝트를 삭제
	 *@param List<ProjectVO> project (체크박스에 체크된 항목)
	 */
	@Override
	public int projectCheckedDelete(List<ProjectVO> project) {
		return adminProjectDao.deleteCheckedProject(project);
	}

	/**
	 *선택된 프로젝트를 복구하는 기능
	 *@param List<ProjectVO> project (체크박스에 체크된 항목)
	 */
	@Override
	public int projectCheckedRestore(List<ProjectVO> project) {
		return adminProjectDao.restoreCheckedProject(project);
	}
	@Override
	public int retriveNewTotalCnt() {
		return adminProjectDao.selectNewTotalRecord();
	}
	@Override
	public int retriveQuickTotalCnt() {
		return adminProjectDao.selectQuickTotalRecord();
	}
	@Override
	public int retriveSafeTotalCnt() {
		return adminProjectDao.selectSafeTotalRecord();
	}
	@Override
	public int retriveDelTotalCnt() {
		return adminProjectDao.selectDelTotalRecord();
	}

}
