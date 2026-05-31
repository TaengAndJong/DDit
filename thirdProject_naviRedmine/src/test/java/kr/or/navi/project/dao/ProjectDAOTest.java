package kr.or.navi.project.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import javax.inject.Inject;

import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.ProjectVO;
import kr.or.navi.vo.TeamVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
class ProjectDAOTest extends AbstractRootContextTest{
	@Inject
	ProjectDAO dao;
	@Test
	void test() {
		ProjectVO pro = dao.selectProject("P00001");
		List<EmpVO> selectOutEmpList = dao.selectOutEmpList("P00001",new PaginationInfo());
		log.info("selectOutEmpList : {}",selectOutEmpList);
	}
	@Test
	void test1() {
		int endProject = dao.endProject("P00003");
		log.info("endProject : {}",endProject);
	}
}
