package kr.or.navi.mypage.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.navi.vo.DeptVO;

@Mapper
public interface DeptDAO {
	public List<DeptVO> selectDeptList();
}
