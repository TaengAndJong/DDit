package kr.or.navi.common.preparer.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import javax.inject.Inject;

import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import kr.or.navi.vo.MenuVO;
import kr.or.navi.vo.ResrceVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
class ResourceDAOTest extends AbstractRootContextTest{
	@Inject
	ResourceDAO dao;
	@Test
	void test() {
		List<MenuVO> list = dao.selectProjectList("1");
		log.info("list : {}",list);
	}
	
	@Test
	void test2() {
		List<MenuVO> list = dao.selectMyPageList("1");
		log.info("list : {}",list);
	}
	
	@Test
	void test3() {
		List<MenuVO> list = dao.selectBaordList();
		log.info("list : {}",list);
	}
}
