package kr.or.ddit.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "stdNo")//프라이머리키 & EQUALS
public class StudentVO implements Serializable{
	private String stdNo; // 학번 - 
	private String stdName; // 학생명
	private String stdId; // 주민번호
	private String stdTelno; // 전화번호
	private String stdAddress; // 주소
	private String proNo;//담임교수 번호
	private String proName;//담임교수
}
