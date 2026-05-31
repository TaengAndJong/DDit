package kr.or.navi.quick.certificate.dao;


import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import kr.or.navi.quick.certificate.vo.CertVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
class CertDAOTest extends AbstractRootContextTest {

	@Inject
	CertDAO dao;

	@Test
	void test() {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("age", "0");
		map.put("career", "0");
		map.put("category", "1");

		List<CertVO> selectRecomCertList = dao.selectRecomCertList(map);
		log.info("selectRecomCertList:{}", selectRecomCertList);
	}

}
