package kr.or.navi.board.form.dao;

import static org.junit.jupiter.api.Assertions.*;

import javax.inject.Inject;

import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import kr.or.navi.vo.BoardPostVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
class FormDAOTest extends AbstractRootContextTest{

	@Inject
	FormDAO dao;
	@Test
	void test() {
		BoardPostVO vo = new BoardPostVO();
		vo.setBpCn("1111");
		vo.setBpTitle("1111");
		vo.setEmpId("E00001");
		vo.setBrdId("BN0002");
		int insert = dao.insertForm(vo);
		log.info("insert : {}",insert);
	}

}
