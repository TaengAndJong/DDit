package kr.or.navi.vo;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="proId")
public class  ProjectVO implements Serializable{
	private int rnum;
	private String proId;
	@NotBlank
	private String proStId;
	@NotBlank
	private String proName;
	private String proDesc;
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
	private LocalDateTime proRegDt;
	@NotNull
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	private LocalDateTime proDdlineEx;
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
	private LocalDateTime proDdlineDt;
	private String proDdlineYn;
	private String empId;
	private String empName;
	private String cmId;
	private String cmName;
	private List<TeamVO> teamList;
	private String wikiId;
	private String myProject;
	public boolean isPLMember(EmpVO emp) {
		return emp.getEmpId().equals(this.empId);
	}
	public void setMyProject(String msg) {
		myProject=msg;
	}
	/**
	 * 해당 프로젝트의 시작일과 마감일을 계산하여 현재 시간을 기준으로 얼만큼 진행되었는지 조회하는 Getter
	 * @return 계싼을 통한 백분율을 정수형으로 반환
	 */
	@JsonIgnore
	public int getProIng() {
	    // 현재 날짜와 시간 구하기
        LocalDateTime currentDate = LocalDateTime.now();

        // 시작일로부터 현재까지의 기간과 전체 기간을 계산
        long totalDuration = ChronoUnit.SECONDS.between(proRegDt, proDdlineEx);
        long passedDuration = ChronoUnit.SECONDS.between(proRegDt, currentDate);

        // 진행률 계산
        int progressPercentage = (int) (passedDuration * 100 / totalDuration);
        return progressPercentage;
	}
	
	/**
	 * 시작일을 yyyy-mm-dd 형태로 문자열로 포멧팅하는 Getter
	 * @return
	 */
	public Object getProRegDtStr() {
		if(proRegDt!=null)
		return proRegDt.format(DateTimeFormatter.ISO_DATE);
		return proRegDt;
	}
	/**
	 * 마감일을 yyyy-mm-dd 형태로 문자열로 포멧팅하는 Getter
	 * @return
	 */
	public Object getProDdlineExStr() {
		if(proDdlineEx!=null)
		return proDdlineEx.format(DateTimeFormatter.ISO_DATE);
		return proDdlineEx;
	}
	/**
	 * 시작일을 yyyy-mm-ddThh:mm:ss 형태로 문자열로 포멧팅하는 Getter
	 * @return
	 */
	public Object getRealProRegDtStr() {
		if(proRegDt!=null)
		return proRegDt.format(DateTimeFormatter.ISO_DATE_TIME);
		return proRegDt;
	}
	/**
	 * 마감일을 yyyy-mm-ddThh:mm:ss 형태로 문자열로 포멧팅하는 Getter
	 * @return
	 */
	public Object getRealProDdlineExStr() {
		if(proDdlineEx!=null)
		return proDdlineEx.format(DateTimeFormatter.ISO_DATE_TIME);
		return proDdlineEx;
	}
	
	/**
	 * 시작일로부터 마감일까지 총 몇일인지 계산하는 Getter
	 * @return
	 */
	public Object getIngProjectDT() {
		if(proRegDt!=null && proDdlineEx!=null)
		return ChronoUnit.DAYS.between(proRegDt, proDdlineEx)+"일";
		return null;
	}
}
