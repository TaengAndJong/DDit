package kr.or.navi.board.share.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.util.Map;

import javax.inject.Inject;

import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import kr.or.navi.vo.BoardPostVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
class ShareDAOTest extends AbstractRootContextTest{

	@Inject
	private ShareDAO dao;
	
	@Test
	void test() {
		BoardPostVO vo = new BoardPostVO();
		vo.setBpId("B00018");
		vo.setBpTitle("dfsadfs");
		vo.setBpCn("dkjafkljfsdklad");
		vo.setEmpId("E00001");
		int updateShare = dao.updateShare(vo);
		log.info("updateShare:{}",updateShare);
	}
	@Test
	void test1() {
		Map<String, Integer> shareCntTotal = dao.shareCntTotal();
		log.info("shareCntTotal :{}",shareCntTotal.get("SCOUNT"));
		
	}
}
