package kr.or.navi.index.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import javax.inject.Inject;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
class IndexDAOTest extends AbstractRootContextTest{
	@Inject
	private IndexDAO dao;
	@Test
	void test() {
		List<EmpVO> list = dao.selectTopPerformer();
		log.info("list : {}",list);
	}

}
