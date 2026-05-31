package kr.or.navi.task.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import javax.inject.Inject;

import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.TaskVO;
import kr.or.navi.vo.TeamVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
class TaskDAOTest extends AbstractRootContextTest{
	@Inject
	private TaskDAO dao;
	@Test
	void test() {
		List<TaskVO> selectList = dao.selectProjectList(new PaginationInfo(),"P00001");
		log.info("selectList : {}",selectList.get(0).getTaskProcessStatus());
	}
	@Test
	void test1() {
		TaskVO vo = dao.select("T00001");
		log.info("REGvo : {}",vo.getRegEmp());
		log.info("MANvo : {}",vo.getTaskManEmp());
	}
	@Test
	void test2() {
		 List<TeamVO> list = dao.selectTeamList("P00001");
		log.info("list : {}",list);
	}
	@Test
	void test3() {
		List<TaskVO>  list = dao.selectChildTaskList("T00009");
		log.info("list : {}",list);
	}
}
