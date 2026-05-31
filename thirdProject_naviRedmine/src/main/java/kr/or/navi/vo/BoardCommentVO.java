package kr.or.navi.vo;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="bcId")
public class BoardCommentVO implements Serializable{
	private String bcId;
	private String bcTopId;
	private String bpId;
	private String empId;
	private String empName;
	private String psName;
	private String deptName;
	private LocalDateTime bcRegDt;
	private LocalDateTime bcModDt;
	private String bcCn;
	private String bcDelYn;
	
	private EmpVO emp;
	
	public Object getBcRegDtStr() {
		if(bcRegDt!=null)
			return bcRegDt.format(DateTimeFormatter.ISO_DATE);
		return bcRegDt;
	}
	public Object getBcModDtStr() {
		if(bcModDt!=null)
			return bcModDt.format(DateTimeFormatter.ISO_DATE);
		return bcModDt;
	}
}
