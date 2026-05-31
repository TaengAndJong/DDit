package kr.or.navi.projectdetail.gantt.service;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import javax.inject.Inject;

import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import kr.or.navi.projectdetail.gantt.vo.GanttEventVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
class GanttServiceImplTest extends AbstractRootContextTest{
	@Inject
	GanttServiceImpl service;
	@Test
	void test() {
//		List<GanttEventVO> list = service.getGanttEventList();
//		for(GanttEventVO vo : list) {
//			log.info("vo : {}",vo.toString());
//		}
//		log.info("size : {} ",list.size());
		
	}

}
