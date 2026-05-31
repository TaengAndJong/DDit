package kr.or.navi.login.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.navi.vo.EmpVO;

@Mapper
public interface LoginDAO {
	public EmpVO selectEmpRrno(@Param("empName")String empName,@Param("empRrno")String empRrno);
	public EmpVO selectEmpPs(@Param("empName")String empName,@Param("empRrno")String empRrno,@Param("empId")String empId);
}
