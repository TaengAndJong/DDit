package kr.or.navi.common.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import javax.inject.Inject;

import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import kr.or.navi.vo.CommonVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
class CommonDAOTest extends AbstractRootContextTest{
	@Inject
	CommonDAO dao;
	@Test
	void test() {
		List<CommonVO> list = dao.selectProjectStateList();
		log.info("list : {}",list);
	}

}
