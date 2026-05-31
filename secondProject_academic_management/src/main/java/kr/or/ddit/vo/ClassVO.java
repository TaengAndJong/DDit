package kr.or.ddit.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;


@Data
@EqualsAndHashCode(of={"stdNo","subCd"})
public class ClassVO implements Serializable{
	String stdNo;
	String subCd;
	int clsScore;
}
