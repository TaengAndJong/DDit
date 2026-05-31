package kr.or.navi.vo;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "bmId")
public class BookmarkVO implements Serializable {
	private String bmId;
	private String ctgryId;
	private String ctgryNm;
	private String ctgryUrl;
	private String titleId;
	private String title;
	private String regId;
	private String regNm;
	private LocalDateTime regDt;
	private LocalDateTime delDt;

	public String getRegDtStr() {
		if (regDt != null)
			return regDt.format(DateTimeFormatter.ISO_DATE);
		return null;
	}
	
	public String getDelDtStr() {
		if (delDt != null)
			return delDt.format(DateTimeFormatter.ISO_DATE);
		return null;
	}
}
