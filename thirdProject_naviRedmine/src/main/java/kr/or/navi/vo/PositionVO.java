package kr.or.navi.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "psId")
public class PositionVO implements Serializable{
	private String psId;
	private String psName;
	private String psYn;
}
