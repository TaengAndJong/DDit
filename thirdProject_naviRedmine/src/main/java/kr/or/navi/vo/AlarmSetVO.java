package kr.or.navi.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of= {"altypeId","empId"})
public class AlarmSetVO implements Serializable{
	private String empId;
	private String altypeId;
}
