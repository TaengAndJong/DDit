package kr.or.navi.index.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.ProjectVO;


@Mapper
public interface IndexDAO {
	
	//프로젝트 전체목록조회
	public List<ProjectVO> selectList();
	public List<EmpVO> selectTopPerformer();
}
