package kr.or.navi.admin.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.ProjectVO;

@Mapper
public interface AdminProjectDAO {
	public List<ProjectVO> selectList(PaginationInfo paging);

	public int selectTotalRecord(PaginationInfo paging);

	public int selectNewTotalRecord();
	public int selectQuickTotalRecord();
	public int selectSafeTotalRecord();
	public int selectDelTotalRecord();

	public int deleteCheckedProject(@Param("projects") List<ProjectVO> project);

	public int restoreCheckedProject(@Param("projects") List<ProjectVO> project);

	public List<EmpVO> selectPlList();
}
