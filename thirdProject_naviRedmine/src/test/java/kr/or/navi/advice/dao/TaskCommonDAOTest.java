package kr.or.navi.advice.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import javax.inject.Inject;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import kr.or.navi.vo.TaskProcessStatusVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
class TaskCommonDAOTest extends AbstractRootContextTest{
	@Inject
	private TaskCommonDAO dao;
	@Test
	void test() {
		List<TaskProcessStatusVO> selectTaskProcessStatusList = dao.selectTaskProcessStatusList();
		log.info("selectTaskProcessStatusList : {}",selectTaskProcessStatusList);
	}

}
