package kr.or.navi.todaylist.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import javax.inject.Inject;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import kr.or.navi.vo.TodayListVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
class TodayListDAOTest extends AbstractRootContextTest{
	@Inject
	TodayListDAO dao;

	@Test
	void test() {
		List<TodayListVO> todayList = dao.selectTodayListAll("E00001");
		log.info("todayList : {}",todayList);
	}

}
