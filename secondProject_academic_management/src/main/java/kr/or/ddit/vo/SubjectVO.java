package kr.or.ddit.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="subCd")
public class SubjectVO implements Serializable{
	private String subCd;
	private String subGubun;
	private String subName;
	private String subCredit;
}
