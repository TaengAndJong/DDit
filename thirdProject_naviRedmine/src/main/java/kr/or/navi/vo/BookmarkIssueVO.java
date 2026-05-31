package kr.or.navi.vo;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = {"issueId","empId"})
public class BookmarkIssueVO {
	private String biId;
	private String issueId;
	private String empId;
	private String proId;
	private LocalDateTime biRegDt;
	private LocalDateTime biDelDt;

	public String getBiRegDtStr() {
		if (biRegDt != null)
			return biRegDt.format(DateTimeFormatter.ISO_DATE);
		return null;
	}
	
	public String getBiDelDtStr() {
		if (biDelDt != null)
			return biDelDt.format(DateTimeFormatter.ISO_DATE);
		return null;
	}
}