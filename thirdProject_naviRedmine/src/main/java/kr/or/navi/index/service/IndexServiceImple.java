package kr.or.navi.index.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.navi.index.dao.IndexDAO;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.ProjectVO;

@Service
public class IndexServiceImple implements IndexService {
	
	@Inject
	IndexDAO indexDao;
	
	@Override
	public List<ProjectVO> selectList() {
		
		return indexDao.selectList();
	}

	@Override
	public List<EmpVO> retriveTopPerformer() {
		return indexDao.selectTopPerformer();
	}

	
	
}
