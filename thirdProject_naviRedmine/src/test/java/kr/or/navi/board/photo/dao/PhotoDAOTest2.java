package kr.or.navi.board.photo.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import javax.inject.Inject;

import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.BoardPostVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
class PhotoDAOTest2 extends AbstractRootContextTest {
	@Inject
	PhotoDAO dao;
	@Test
	void test() {
		PaginationInfo paging = new PaginationInfo();
		paging.setTotalRecord(8);
		paging.setCurrentPage(1);
		log.info("{}", dao);
		List<BoardPostVO> list = dao.selectPhotoList(paging);
		assertNotNull(list);
		log.info("list: {}", list);
	}
	@Test
	void test1() {
		BoardPostVO detail = dao.selectPhoto("B00004");
		assertNotNull(detail);
	}

}
