package kr.or.navi.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="deptId")
public class DeptVO implements Serializable{
	private String deptId;
	private String deptName;
	private String deptYn;
}
