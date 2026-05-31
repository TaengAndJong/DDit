package kr.or.navi.advice.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.navi.vo.RoleVO;

@Mapper
public interface RoleDAO {
	public List<RoleVO> selectRoleList();
}
