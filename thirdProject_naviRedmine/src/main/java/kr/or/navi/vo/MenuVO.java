package kr.or.navi.vo;

import lombok.Data;

@Data
public class MenuVO {
	private String rescMenu;
	private String rescUrl;
	private String rescIdx;
	
	public String getManageStatus(){
		if(Integer.parseInt(rescIdx)>=6) {
			return "1";
		}else {
			return null;
		}
	}
}
