package kr.or.ddit.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(of="proNo")
public class ProfessorVO implements Serializable{
	private String proNo;
	private String proName;
	private String proMajor;
	private String proTelno;
}
