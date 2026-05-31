package kr.or.navi.quick.trip.vo;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringExclude;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="vacId")
public class VacVO implements Serializable {
	private String vacId;
	private String vacName;
	@ToStringExclude
	private String vacImg;
	@ToStringExclude
	private String vacEx;
	private String vacRank;
	private Integer viewCnt = 0;
	public int getViewCnt() {
		 return this.viewCnt;
	}
	
}
