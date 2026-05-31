package kr.or.ddit.vo;

import lombok.Data;

@Data
public class EnrolmentVO {
	
	private int rnum; //번호
	private String subCd; //과목코드
	private String subName; // 과목명
	private String proMajor; // 학부
	private String proName; // 교수명
	private String subGubun; // 과목 이수종류
	private String subCreit; // 과목이수학점
	private String proNo; // 교수번호
	private String lectureDay;
	private String lectureTime;
	private String lectureRoom;
	
}
