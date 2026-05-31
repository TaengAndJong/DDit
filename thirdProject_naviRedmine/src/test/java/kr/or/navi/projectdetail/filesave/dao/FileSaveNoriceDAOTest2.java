package kr.or.navi.projectdetail.filesave.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import javax.inject.Inject;

import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.FileSaveNoticeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
class FileSaveNoriceDAOTest2 extends AbstractRootContextTest{
	@Inject
	FileSaveNoriceDAO dao;
	@Test
	void test() {
		List<FileSaveNoticeVO> list = dao.selectFileSaveNoiceList(new PaginationInfo(),"P00001");
		log.info("list : {}",list);
	}
	@Test
	void test2() {
		FileSaveNoticeVO vo = dao.selectFileSaveNoriceOne("F00001");
		log.info("vo : {}",vo);
	}

}
