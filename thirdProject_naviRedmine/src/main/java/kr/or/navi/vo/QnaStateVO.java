package kr.or.navi.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="bpQnaYn")
public class QnaStateVO implements Serializable{
	private String bpQnaYn;
	private String qnaName;
}
