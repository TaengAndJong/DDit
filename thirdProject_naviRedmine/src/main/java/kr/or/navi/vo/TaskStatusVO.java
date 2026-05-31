package kr.or.navi.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="tsId")
public class TaskStatusVO {
	private String tsId; // 일감상태ID (T00001, 2,3)
	private String tsName;//일감상태명(신규,일반,긴급)
	private int tsTime;
}
