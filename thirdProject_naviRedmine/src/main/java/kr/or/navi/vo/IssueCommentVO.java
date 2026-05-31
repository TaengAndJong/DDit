package kr.or.navi.vo;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="icId")
public class IssueCommentVO implements Serializable{
	private String icId;
	private String icTopId;
	private String proId;
	private String icRegId;
	private String issueId;
	private LocalDateTime icRegDt;
	private LocalDateTime icModDt;
	private String icCn;
	private String icDelYn;
	private String empName;
	private String psName;
	private String deptName;
	private int level;
	
	private EmpVO emp;
	
	public Object getIcRegDtStr() {
		if(icRegDt!=null)
			return icRegDt.format(DateTimeFormatter.ISO_DATE);
		return icRegDt;
	}
	public Object getIcModDtStr() {
		if(icModDt!=null)
			return icModDt.format(DateTimeFormatter.ISO_DATE);
		return icModDt;
	}
}
