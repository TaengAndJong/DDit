package kr.or.navi.vo;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.apache.commons.lang3.StringUtils;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="alarmId")
public class AlarmVO implements Serializable{
	private String alarmId;
	private String altypeId;
	private String alRcvrId;
	private String alSndrId;
	private String alRdYn;
	private LocalDateTime alRegDt;
	private String alMoveUrl;
	private String alCn;
	private String alDelYn;
	private String empName;
	private String altypeName;
	private String altypeCn;
	
	public String getAlRdYn() {
		if(StringUtils.isNotBlank(alRdYn)) {
			return "읽음";
		}else {
			return "읽지않음";
		}
	}
	public Object getAlRegDtStr() {
		if(alRegDt!=null)
		return alRegDt.format(DateTimeFormatter.ISO_DATE);
		return alRegDt;
	}
}
