package kr.or.navi.admin.emp.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.navi.admin.emp.dao.AdminEmpDAO;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.EmpVO;

@Service
public class AdminEmpServiceImpl implements AdminEmpService {

	@Inject
	private AdminEmpDAO dao;

	@Override
	public List<EmpVO> retrieveEmpList(PaginationInfo paging) {
		int totalRecord = dao.selectTotalRecord(paging);
		paging.setTotalRecord(totalRecord);
		return dao.selectEmpAllList(paging);
	}

	// ROLE_PRO_CREATE 가 PROJECT를 가지고 있으면 실패처리
	// roleId가 ROLE_PRO_CREATE -> ROLE_EMP
	// roleId가 ROLE_EMP -> ROLE_PRO_CREATE
	@Override
	public int modifyEmpRole(String empId, String roleId) {
		if (roleId.contains("ROLE_PRO_CREATE")) {
			// 프로젝트 생성자 - 일반 PMS사원으로 변경
			int projectCnt = dao.selectTeamCount(empId);
			if (projectCnt > 0) {
				// 프로젝트가 있다
				return 0;
			} else {
				// 프로젝트가 없다
				int cnt = dao.updateRoleId(empId, "ROLE_EMP");
				if (cnt > 0) {
					return cnt;
				} else {
					return 0;
				}
			}
		} else if (roleId.contains("ROLE_EMP")) {
			// PMS 사원 - 프로젝트 생성자 권한 획득
			int cnt = dao.updateRoleId(empId, "ROLE_PRO_CREATE");
			if (cnt > 0) {
				return cnt;
			} else {
				return 0;
			}

		} else {
			// 일반사원 , 어드민
			return 0;
		}
	}

	@Override
	public int inviteCheckedEmp(List<EmpVO> emp) {
		return dao.inviteCheckedEmp(emp);
	}

	/**
	 * 선택된 프로젝트를 삭제
	 * 
	 * @param List<EmpVO> emp (체크박스에 체크된 항목)
	 */
	@Override
	public int empCheckDelete(List<EmpVO> emp) {
		return dao.deleteCheckedEMP(emp);
	}

	/**
	 * 선택된 프로젝트를 삭제
	 * 
	 * @param List<EmpVO> emp (체크박스에 체크된 항목)
	 */
	@Override
	public int empCheckRestore(List<EmpVO> emp) {
		return dao.restoreCheckedEMP(emp);
	}

	@Override
	public int retriveEmpTotalCnt() {
		return dao.selectEmpTotalRecord();
	}

	@Override
	public int retrivePmsTotalCnt() {
		return dao.selectPmsTotalRecord();
	}

	@Override
	public int retrivePlTotalCnt() {
		return dao.selectPlTotalRecord();
	}

	@Override
	public int retriveBlockTotalCnt() {
		return dao.selectBlockTotalRecord();
	}

}
