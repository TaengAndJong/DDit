package kr.or.navi.admin.emp.service;

import java.util.List;


import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.EmpVO;

public interface AdminEmpService {
	public List<EmpVO> retrieveEmpList(PaginationInfo paging);
	public int modifyEmpRole(String empId,String roleId);
	public int inviteCheckedEmp(List<EmpVO> emp);
	public int empCheckDelete(List<EmpVO> emp);
	public int empCheckRestore(List<EmpVO> emp);
	public int retriveEmpTotalCnt();
	public int retrivePmsTotalCnt();
	public int retrivePlTotalCnt();
	public int retriveBlockTotalCnt();
}
