package kr.or.navi.admin.emp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.TeamVO;

@Mapper
public interface AdminEmpDAO {
	public List<EmpVO> selectEmpAllList(PaginationInfo paging);

	public int selectTotalRecord(PaginationInfo paging);

//	상단 요약 contents_의 숫자요소
	public int selectEmpTotalRecord();
	public int selectPmsTotalRecord();
	public int selectPlTotalRecord();
	public int selectBlockTotalRecord();

	public int selectTeamCount(String empId);

	public int updateRoleId(@Param("empId") String empId, @Param("roleId") String roleId);

	public int inviteCheckedEmp(@Param("emps") List<EmpVO> emp);

	public int deleteCheckedEMP(@Param("emps") List<EmpVO> emp);

	public int restoreCheckedEMP(@Param("emps") List<EmpVO> emp);

}
