package kr.or.navi.vo;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of={"tlIdx","tlRegDt"})
public class TodayListVO {
	
	private Integer tlIdx; // 일정순번
	private String taskId;//일감 아이디
	private String empId;//일감을 추가한 사원번호 -> Realuser에서 가져오기?
	
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	private LocalDateTime tlRegDt; // 일정등록 날자
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	private LocalDateTime taskCompDt; //일감처리완료일 -> 작업상태 완료시 업데이팅
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	private LocalDateTime taskRqDt; //소요시간
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	private LocalDateTime taskEstDt; //예상시간
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	private LocalDateTime taskRegDt; //등록시간
	
	private EmpVO emp; // 담당자 구분 필요
	private ProjectVO project;//일감 목록전체
	private TaskVO task;//일감 목록전체
	private TaskStatusVO taskStatus; //일감상태
	private TaskProcessStatusVO taskProcessStatus;//일감진행상태
	
	
	//일감등록일
	public String getTaskRegDtStr() {
		if(taskRegDt==null) {
			return null;
		}
		return taskRegDt.format(DateTimeFormatter.ISO_DATE); // 문자열로 날짜까지만 나옴
	}
	
	
	//일정 등록 날자
	public String getTodaylstDtStr() {
		if(tlRegDt==null) {
			return null;
		}
		return tlRegDt.format(DateTimeFormatter.ISO_DATE); // 문자열로 날짜까지만 나옴
	}
	
	//일감처리완료일
	public String getTaskCompDtStr() {
		if(taskCompDt==null) {
			return null;
		}
		return taskCompDt.format(DateTimeFormatter.ISO_DATE); // 문자열로 날짜까지만 나옴
	}
	//소요시간
	public String getTaskRqDtStr() {
		if(taskRqDt==null) {
			return null;
		}
		return taskRqDt.format(DateTimeFormatter.ISO_DATE); // 문자열로 날짜까지만 나옴
	}
	//예상시간
	public String getTaskEstDtStr() {
		if(taskEstDt==null) {
			return null;
		}
		return taskEstDt.format(DateTimeFormatter.ISO_DATE);
	}
	
	
}
