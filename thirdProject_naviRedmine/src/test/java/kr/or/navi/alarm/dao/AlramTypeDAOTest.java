package kr.or.navi.alarm.dao;

import static org.junit.jupiter.api.Assertions.*;

import javax.inject.Inject;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import kr.or.navi.vo.AlarmTypeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
class AlramTypeDAOTest extends AbstractRootContextTest{

	@Inject
	AlramTypeDAO dao;

	@Test
	void test() {
		AlarmTypeVO selectAlramType = dao.selectAlramType("A00001");
		log.info("selectAlramType : {}",selectAlramType);
	}

}
