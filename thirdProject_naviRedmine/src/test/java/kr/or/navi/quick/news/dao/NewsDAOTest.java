package kr.or.navi.quick.news.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import kr.or.navi.quick.news.vo.NewsVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
class NewsDAOTest extends AbstractRootContextTest{
	@Inject
	NewsDAO dao;
	@Test
	void test() {
		List<NewsVO> list = dao.selectNewsList();
		log.info("list : {} ",list);
	}
	@Test
	void test1() {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("age", "0");
		map.put("dept", "0");
		map.put("gen", "0");
		List<NewsVO> list = dao.selectRecomNewsList(map);
		log.info("list : {} ",list);
	}

}
