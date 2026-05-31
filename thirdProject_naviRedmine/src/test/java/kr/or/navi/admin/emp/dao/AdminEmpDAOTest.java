package kr.or.navi.admin.emp.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import javax.inject.Inject;

import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
class AdminEmpDAOTest extends AbstractRootContextTest {
	
	@Inject
	AdminEmpDAO dao;
	@Test
	void test() {
		List<EmpVO> list = dao.selectEmpAllList(new PaginationInfo());
		log.info("list : {}",list);
	}
	
	@Test
	void test1() {
		int cnt= dao.selectTeamCount("E00001");
		log.info("cnt : {}",cnt);
	}

	@Test
	void test2() {
		int cnt = dao.updateRoleId("E00016", "ROLE_EMP");
		log.info("cnt : {}",cnt);
	}
}
