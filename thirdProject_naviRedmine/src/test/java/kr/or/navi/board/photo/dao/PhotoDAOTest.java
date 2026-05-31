package kr.or.navi.board.photo.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import javax.inject.Inject;

import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.BoardPostVO;
import kr.or.navi.vo.IssueVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
class PhotoDAOTest extends AbstractRootContextTest{

	@Inject
	PhotoDAO dao;
	

	@Test
	void testSelectTotalRecord() {
		List<BoardPostVO> list = dao.selectPhotoList(new PaginationInfo());
		log.info("list : {}",list);
	}

	@Test
	void testSelectPhotoList() {
		PaginationInfo paging = new PaginationInfo();
		paging.setTotalRecord(8);
		paging.setCurrentPage(1);
		log.info("{}", dao);
		List<BoardPostVO> list = dao.selectPhotoList(paging);
		assertNotNull(list);
//		dao.selectPhotoList(paging);
//		log.info("{}", dao.selectPhotoList(paging));
//		log.info("list:{}",list);
	}

	@Test
	void testSelect() {
		PaginationInfo paging = new PaginationInfo();
		paging.setCurrentPage(1);
		paging.setTotalRecord(dao.totalRecord(paging));
		dao.selectPhotoList(paging).forEach(p->{
			log.info("{}", p);
		});
		
	}
	
	@Test
	void test2() {
		log.info("{}",dao.selectFile("B00037"));
	}
}
