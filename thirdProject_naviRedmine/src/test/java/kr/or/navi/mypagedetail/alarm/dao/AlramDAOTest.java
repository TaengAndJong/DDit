package kr.or.navi.mypagedetail.alarm.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import javax.inject.Inject;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import kr.or.navi.vo.AlarmVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
class AlramDAOTest extends AbstractRootContextTest{
	@Inject
	AlramDAO dao;
	@Test
	void test() {
		List<AlarmVO> list = dao.selectDisplayAlramList("E00001");
		log.info("list : {}",list);
	}

}
