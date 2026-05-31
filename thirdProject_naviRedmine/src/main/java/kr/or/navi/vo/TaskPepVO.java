package kr.or.navi.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="tpId")
public class TaskPepVO {
	private String tpId;
	private String taskId;
	private String empId;
}
