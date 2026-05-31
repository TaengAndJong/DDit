package kr.or.navi.wiki.dao;

import static org.junit.jupiter.api.Assertions.*;

import javax.inject.Inject;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import kr.or.navi.vo.WikiVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
class WikiDAOTest extends AbstractRootContextTest {

	@Inject
	private WikiDAO dao;
	@Test
	void test() {
		WikiVO wiki = dao.selectProWiki("P00001");
		log.info("wiki : {}",wiki);
	}
	@Test
	void test1() {
	}


}
