package kr.or.navi.projectdetail.dashboard.vo;

import java.util.List;

import kr.or.navi.vo.TaskVO;

public class TaskChartVO extends AbstractChartVO<List<TaskVO>> {
	
	public TaskChartVO(List<TaskVO> extendedProps) {
		super(extendedProps);
	}

	@Override
	public String getData() {
		int danger=0;
		int ok=0;
		int newT=0;
		for(TaskVO vo : getExtendedProps()) {
			String tsId = vo.getTsId();
			if("T00001".equals(tsId)) {
				newT+=1;
			}else if("T00002".equals(tsId)) {
				ok+=1;
			}else {
				danger+=1;
			}
		}
		return "["+newT+","+ok+","+danger+"]";
	}

	@Override
	public String getLabels() {
		return "['신규','일반','긴급']";
	}

}
