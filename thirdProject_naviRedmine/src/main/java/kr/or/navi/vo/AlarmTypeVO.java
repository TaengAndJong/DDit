package kr.or.navi.vo;

import java.io.Serializable;
import java.time.LocalDateTime;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="altypeId")
public class AlarmTypeVO implements Serializable{
	private String altypeId;
	private String altypeName;
	private String altypeCn;
}
