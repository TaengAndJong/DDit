package kr.or.navi.test;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import javax.inject.Inject;

import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import kr.or.navi.mapper.dao.EmpDAO;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
class EmpDAOTest extends AbstractRootContextTest{
	@Inject
	EmpDAO dao;

	@Test
	void test() {
		EmpVO emp = dao.selectOne("E00003");
		log.info("vo : {}",emp);
		log.info("list : {}",emp.getEmpRoles());
	}

}
