package kr.or.navi.project.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import javax.inject.Inject;

import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.TeamVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
class TeamDAOTest extends AbstractRootContextTest{
	@Inject
	TeamDAO dao;
	@Test
	void test() {
	 List<TeamVO> selectTeams = dao.selectTeams(new PaginationInfo(),"P00001");
		log.info("team:{}",selectTeams.size());
	}

}
