package kr.or.navi.vo;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = {"bpId","empId"})
public class BookmarkBoardVO {
	private String bbId;
	private String bpId;
	private String empId;
	private LocalDateTime bbRegDt;
	private LocalDateTime bbDelDt;

	public String getBbRegDtStr() {
		if (bbRegDt != null)
			return bbRegDt.format(DateTimeFormatter.ISO_DATE);
		return null;
	}
	
	public String getBbDelDtStr() {
		if (bbDelDt != null)
			return bbDelDt.format(DateTimeFormatter.ISO_DATE);
		return null;
	}
}
