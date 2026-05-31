package kr.or.navi.index.service;

import java.util.List;

import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.ProjectVO;

public interface IndexService {
	
	public List<ProjectVO> selectList();
	public List<EmpVO> retriveTopPerformer();

}
