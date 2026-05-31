package kr.or.navi.projectdetail.dashboard.vo;

import java.util.List;

import kr.or.navi.vo.IssueVO;

public class IssueChartVO extends AbstractChartVO<List<IssueVO>> {

	public IssueChartVO(List<IssueVO> extendedProps) {
		super(extendedProps);
	}

	@Override
	public String getData() {
		int ref=0;
		int sol=0;
		int ing=0;
		for(IssueVO is :getExtendedProps()) {
			if("IG0003".equals(is.getClsfcId())) {
				sol+=1;
			}else if("IG0005".equals(is.getClsfcId())) {
				ref+=1;
			}else {
				ing+=1;
			}
		}
		return "["+ref+","+ing+","+sol+"]";
	}

	@Override
	public String getLabels() {
		return  "['거절','진행','해결']";
	}

}
