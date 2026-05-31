package kr.or.navi.projectdetail.dashboard.vo;

import java.util.List;

import kr.or.navi.vo.TeamVO;

public class TeamChartVO extends AbstractChartVO<List<TeamVO>>{

	public TeamChartVO(List<TeamVO> extendedProps) {
		super(extendedProps);
	}
	
	@Override
	public String getData() {
		List<TeamVO> list = getExtendedProps();
		int aa=0;
		int ta=0;
		int ba=0;
		int da=0;
		int ua=0;
		for(TeamVO vo : list) {
			String roleId = vo.getRoleId();
			if("ROLE_AA".contains(roleId)) {
				aa+=1;
			}else if("ROLE_TA".contains(roleId)) {
				ta+=1;
			}else if("ROLE_BA".contains(roleId)) {
				ba+=1;
			}else if("ROLE_DA".contains(roleId)) {
				da+=1;
			}else {
				ua+=1;
			}
		}
		return "["+aa+","+ta+","+ba+","+da+","+ua+"]";
	}

	@Override
	public String getLabels() {
		return "['AA','TA','BA','DA','UA']";
	}
}
