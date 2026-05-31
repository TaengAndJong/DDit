package kr.or.navi.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="cmId")
public class CommonVO implements Serializable{
	private String cmId;
	private String cmName;
	private String cmAtt1;
	private String cmAtt2;
	private String cmAtt3;
	private String cmAtt4;
	private String cmDesc;
}
