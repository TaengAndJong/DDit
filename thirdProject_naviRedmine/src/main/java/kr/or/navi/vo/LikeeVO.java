package kr.or.navi.vo;

import java.io.Serializable;
import java.time.LocalDateTime;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="empId")
public class LikeeVO implements Serializable{
	private String empId;
	private String bpId;
	private LocalDateTime likeRegDt;
	private String likeYn;
}
