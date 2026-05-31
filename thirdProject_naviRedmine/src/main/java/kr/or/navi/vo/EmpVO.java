package kr.or.navi.vo;

import java.io.IOException;
import java.io.Serializable;
import java.io.UncheckedIOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Base64;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(of="empId")
public class EmpVO implements Serializable{
	private String empId;
	private String deptId;
	private String deptName;
	private String psId;
	private String psName;
	private String roleId;
	private String cnId;
	private String empName;
	private Integer empAge;
	private String empGen;
	private String empPass;
	private String empRrno;
	private String empPhone;
	@ToString.Exclude
	private String empTel;
	@ToString.Exclude
	private String empZip;
	@ToString.Exclude
	private String empAddr;
	@ToString.Exclude
	private String empAddr2;
	@ToString.Exclude
	private String empMail;
	private LocalDateTime empCmpYmd;
	private Integer empCareer;
	private LocalDateTime empQuitDt;
	private String empLimitYn;
	private String empBkId;
	private String empFmId;
	private Integer empCertCg;
	private String roomId;
	private String lastChat;
	private LocalDateTime lastChatSendDt;
	private List<String> empRoles; // Team 테이블의 Role ID 리스트
	private List<ProjectVO> projectList;
	private String empImg;
	/**
	 * 사용자로부터 받은 이미지 데이터를 Commend Object객체로 바이너리 데이터를 받기 위한 필드 변수 이자
	 * 데이터베이스로 부터 조회한 이미지 데이터를 담기위한 Model의 필드변수
	 */
	private byte[] empImage;
	/**
	 * 실제적으로 multipart/form-data로 image(프로필) 사진을 받기 위한 객체
	 */
	private MultipartFile bpAttchFile;
	
	/**
	 * 클라이언트로 부터 MultipartFile 객체를 받아 empImage에 바이너리 데이터로 저장하기 위한 Setter
	 * @param bpAttchFile 이미지 파일
	 */
	public void setBpAttchFile(MultipartFile bpAttchFile) {
		if(bpAttchFile==null || bpAttchFile.isEmpty()) return;
		this.bpAttchFile = bpAttchFile;
		try {
			this.empImage = bpAttchFile.getBytes();
		} catch (IOException e) {
			throw new UncheckedIOException(e);
		}
	}
	/**
	 * 데이터베이스로 부터 받은 바이너리 데이터를 base64로 인코딩하여 실제 데이터(프로필)를 보여주기 위한 Getter
	 * @return
	 */
	public String getBase64Img() {
		if(empImage==null) return null;
		else 
			return Base64.getEncoder().encodeToString(empImage);
	}
	/**
	 * 
	 * @return
	 */
	public String getEmpGenStr() {
		if (("F").equals(empGen)) {
	        return "여자";
	    } else if (("M").equals(empGen)) {
	        return "남자";
	    } else {
	        return "알 수 없음"; // 예외 처리: F나 M이 아닌 다른 값일 경우
	    }
	}
	public String getRoleId() {
		if(StringUtils.isNotBlank(roleId))
		return roleId.trim();
		
		return null;
	}
	public String getEmpCmpYmdStr() {
		if(empCmpYmd!=null)
			return empCmpYmd.format(DateTimeFormatter.ISO_DATE);
		return null;
	}
	
	/**
	 * 해당 EMP 사원이 ADMIN 권한을 가지고 있는지 확인하기 위한 메서드
	 * @return
	 */
	public boolean isAdmin() {
		return "ROLE_ADMIN".equals(roleId);
	}

	public String getlastChatSendDtStr() {
		if(lastChatSendDt!=null)
			return lastChatSendDt.format(DateTimeFormatter.ISO_DATE);
		return null;
	}
	
}
