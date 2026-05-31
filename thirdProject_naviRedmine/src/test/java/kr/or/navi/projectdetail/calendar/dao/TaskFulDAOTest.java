package kr.or.navi.projectdetail.calendar.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import javax.inject.Inject;

import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import kr.or.navi.projectdetail.calendar.vo.TaskFulAdapterVO;
import kr.or.navi.vo.TaskProcessStatusVO;
import kr.or.navi.vo.TaskStatusVO;
import kr.or.navi.vo.TaskVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
class TaskFulDAOTest extends AbstractRootContextTest{
	@Inject
	TaskFulDAO dao;
	@Test
	void test() {
		List<TaskFulAdapterVO> list = dao.selectTaskFulAdapterVOList();
		for(TaskFulAdapterVO vo :list) {
			String solaDate = vo.getSolasrDate();
			break;
		}
	}
	@Test
	void tesk2() {
		List<TaskVO> list = dao.selectTaskList("P00001", "20240215");
		for(TaskVO vo : list) {
			String tsId = vo.getTsId();
			log.info("taskStatus : {}" ,tsId);
		}
	}

}
