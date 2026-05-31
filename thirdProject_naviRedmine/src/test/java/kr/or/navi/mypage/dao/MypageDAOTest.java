package kr.or.navi.mypage.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import javax.inject.Inject;

import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import kr.or.navi.vo.BookmarkBoardVO;
import kr.or.navi.vo.BookmarkIssueVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
class MypageDAOTest extends AbstractRootContextTest{
	@Inject
	MypageDAO dao;
	@Test
	void test() {
		BookmarkIssueVO testVO = new BookmarkIssueVO();
		testVO.setEmpId("E00001");
		testVO.setIssueId("I00001");
		testVO.setBiId("123123");
		BookmarkIssueVO authVO = dao.selectBookMarkIssueVO("I00001", "E00001");
		boolean equals = authVO.equals(testVO);
//		log.info("equals : {}",equals);
	}
	@Test
	void test1() {
		List<BookmarkIssueVO> myList = dao.selectMyBookMarkIssueList("E00001", "P00001");
//		log.info("myList : {}",myList);
	}
	@Test
	void test3() {
		BookmarkBoardVO testVO = new BookmarkBoardVO();
		testVO.setEmpId("E00001");
		testVO.setBpId("B00001");
		testVO.setBbId("123123");
		BookmarkBoardVO authVO = dao.selectBookMarkBoardVO("B00001", "E00001");
		boolean equals = authVO.equals(testVO);
//		log.info("equals : {}",equals);
	}
	@Test
	void test4() {
		List<BookmarkBoardVO> myList = dao.selectMyBookMarkBoardList("E00001");
//		log.info("myList : {}",myList);
	}
}
