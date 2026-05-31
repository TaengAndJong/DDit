package kr.or.navi.projectdetail.dashboard.vo;

import java.util.List;

import kr.or.navi.vo.TaskVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class TaskIngChartVO extends AbstractChartVO<List<TaskVO>> {
	
	public TaskIngChartVO(List<TaskVO> extendedProps) {
		super(extendedProps);
	}

	@Override
	public String getData() {
		int stan=0;
		int ing=0;
		int compled=0;
		int comple=0;
		for(TaskVO vo : getExtendedProps()) {
			String tsId = vo.getTpsId();
			if("T00001".equals(tsId)) {
				stan+=1;
			}else if("T00006".equals(tsId)) {
				compled+=1;
			}else if("T00007".equals(tsId)) {
				comple+=1;
			}else {
				ing+=1;
			}
		}
		log.info("stan :{} ",stan);
		log.info("ing :{} ",ing);
		log.info("compled :{} ",compled);
		log.info("comple :{} ",comple);
		return "["+stan+","+ing+","+compled+","+comple+"]";
	}

	@Override
	public String getLabels() {
		return "['대기','진행중','처리완료','최종완료']";
	}

}
