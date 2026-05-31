package kr.or.navi.projectdetail.gantt.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import javax.inject.Inject;

import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import kr.or.navi.vo.IssueVO;
import kr.or.navi.vo.TaskVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
class TaskGanttDAOTest extends AbstractRootContextTest{
	@Inject
	TaskGanttDAO dao;
	@Test
	void test() {
//		List<TaskVO> list = dao.selectTaskList();
//		log.info("list : {]",list);
	}

}
