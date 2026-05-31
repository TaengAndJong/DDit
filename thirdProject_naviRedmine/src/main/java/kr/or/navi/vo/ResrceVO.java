package kr.or.navi.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="rescId")
public class ResrceVO implements Serializable{
	private String rescId;
	private String rescName;
	private String rescUrl;
	private String rescDesc;
	private String rescYn;
	private String rescMenu;
	private String rescLevel;
	private String rescIdx;
}
