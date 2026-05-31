package kr.or.navi.common.preparer.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.navi.vo.MenuVO;


@Mapper
public interface ResourceDAO {
	public List<MenuVO> selectProjectList(String idx);
	public List<MenuVO> selectMyPageList(String idx);
	public List<MenuVO> selectBaordList();
	public List<MenuVO> selectMainList();
	public List<MenuVO> selectQuickList();
 }
