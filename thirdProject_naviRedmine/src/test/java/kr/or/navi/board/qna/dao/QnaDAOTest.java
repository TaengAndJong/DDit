package kr.or.navi.board.qna.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.util.Map;

import javax.inject.Inject;

import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import lombok.extern.slf4j.Slf4j;
@Slf4j
class QnaDAOTest  extends AbstractRootContextTest{

	@Inject
	private QnaDAO dao;
	
	@Test
	void test() {
		Map<String, Integer> qnaCntTotal = dao.qnaCntTotal();
		log.info("qnaCntTotal :{}",qnaCntTotal);
	}

}
