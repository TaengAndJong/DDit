package kr.or.navi.mapper.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.navi.vo.EmpVO;

@Mapper
public interface EmpDAO {
	public List<EmpVO> selectList();
	public EmpVO selectOne(String empId);
}
