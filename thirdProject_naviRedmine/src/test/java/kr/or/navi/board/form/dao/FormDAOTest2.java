package kr.or.navi.board.form.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import javax.inject.Inject;

import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.BoardPostVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
class FormDAOTest2 extends AbstractRootContextTest{

	@Inject
	FormDAO dao;
	
	@Test
	void test() {
	
		log.info("{}", dao);
		List<BoardPostVO> selectList = dao.selectFormList(new PaginationInfo());
		assertNotNull(selectList);
		log.info("selectList : {}",selectList);
	}
}
