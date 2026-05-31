package kr.or.navi.admin.board.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import javax.inject.Inject;

import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import kr.or.navi.board.share.dao.ShareDAO;
import kr.or.navi.vo.BoardPostVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
class AdminBoardDAOTest extends AbstractRootContextTest {
	
	@Inject
	AdminBoardDAO dao;
	
	@Inject
	ShareDAO shareDao;
	
	
	@Test
	void test() {
		BoardPostVO one = new BoardPostVO();
		one.setBpId("B00019");
		List<BoardPostVO> one2 = null ;
		one2.add(one);
		
		int share = dao.deleteCheckedProject(one2);
		
		log.info("SHARE {}",share);
		
	}

}
