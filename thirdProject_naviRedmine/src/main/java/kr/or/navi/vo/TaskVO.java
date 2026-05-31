package kr.or.navi.vo;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.groups.Default;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import kr.or.navi.validate.InsertGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="taskId")
public class TaskVO {
	
	private int rnum;
	
	private String taskId;//일감ID
	@NotBlank
	private String tsId;//일감상태ID
	
	private String proId;//프로젝트ID
//	@NotBlank
	private String prodName;
	@NotBlank
	private String taskManId;//담당자
	private String taskManName;
	private EmpVO taskManEmp;
	private String taskTopId;//상위일감
	private String tpsId;//일감처리ID
	private String taskRegId;//일감등록일
	private EmpVO regEmp;
	@NotBlank
	private String taskTitle;//일감제목
//	@NotNull
	private LocalDateTime taskRegDt;//일감등록일
	private LocalDateTime taskDdlineDt;//일감마감일
	private LocalDateTime taskModDt;//일감수정일
	@NotBlank
	private String taskCn;//일감내용
//	@NotNull
	private int taskRqrd;//일감소요시간
	@NotNull
	private Integer taskEstTime; // 일감예상시간
	
	private String empName;
	@NotNull
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	private LocalDateTime taskCompDt; //일감처리완료일
	private LocalDateTime taskDelDt;//일감삭제일
	private TaskStatusVO taskStatus;
	private TaskProcessStatusVO taskProcessStatus;
	private Map<String, Object> projectMap; // 1대 1의 관계 -> mybatis.mapping.xml에서 association의 property명
	//private Map<String, Object> statusMap; // 1대 1의 관계 -> mybatis.mapping.xml에서 association의 property명
	//private List<TeamVO> teamList;
	
	private EmpVO empVO; // 담당자 구분 필요
	private TaskStatusVO tsVO; // 일감의 모든데이트 필요
	private ProjectVO projectVO; //프로젝트의 아이디 필요
	
	
	
	/**
	 * 첨부된 파일들을 담기 위한 CommendObject MultipartFIle 배열
	 */
	private MultipartFile[] bpAttchFile;
	/**
	 * 첨부된 파일들을 하나의 파일 VO로 변환하여 담는 List
	 */
	private List<TaskFileVO> taskFileList;
	
	/**
	 * MultipartFile 배열을 이용하여 파일 vo를 생성하여 list에 담는 getter
	 * @return
	 */
	public List<TaskFileVO> getTaskFileList(){
		taskFileList = new ArrayList<TaskFileVO>();
		if(bpAttchFile != null) {
			for (MultipartFile file : bpAttchFile) {
				long size = file.getSize();
				if(size>0) {
					TaskFileVO ifVO = new TaskFileVO();
					ifVO.setBpAttchFile(file);
					ifVO.setTaskId(taskId);
					
					long fileSize = file.getSize();
					ifVO.setTaskFileSize(convertFileSize(fileSize));
					
					taskFileList.add(ifVO);
				}
			}
		}
		return taskFileList;
	}
	/**
	 * 파일의 크기를 파악하여 포멧팅 작업을 걸쳐 파일 vo 안에 저장하는 메서드
	 * @param size
	 * @return
	 */
	public String convertFileSize(long size) {
	    // KB 단위로 변환
	    double kbSize = (double) size / 1024;
	    if (kbSize < 1024) {
	        return String.format("%.2f KB", kbSize);
	    }

	    // MB 단위로 변환
	    double mbSize = kbSize / 1024;
	    return String.format("%.2f MB", mbSize);
	}
	
	/**
	 * 간트차트를 통해 데이터를 수정하였을 시 작은 ms단위까지 변경되어
	 * @DateTimeFormat 어너테이션으로 포메팅 시 다른 곳에서 수정했을 경우 문제가 발생하는것을 발견하여
	 * 분단위 까지만 수정이 되도록 변경하는 메서드 
	 * @return
	 */
	public LocalDateTime refairTaskCompDt() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
		String format = taskCompDt.format(formatter);
		return LocalDateTime.parse(format);
	}
	
	
	
	
	
	
	
	
	//소문자로 get빼고 taskRegDt로 기입해야 함
	public String getTaskRegDtStr() {
		if(taskRegDt==null) {
			return null;
		}
		return taskRegDt.format(DateTimeFormatter.ISO_DATE); // 문자열로 날짜까지만 나옴
	}
	
	public String getTaskDdlineDtStr() {
		if(taskDdlineDt==null) {
			return null;
		}
		return taskDdlineDt.format(DateTimeFormatter.ISO_DATE);
	}
	
	public String getTaskModDtStr() {
		if(taskModDt==null) {
			return null;		}
		return taskModDt.format(DateTimeFormatter.ISO_DATE);
	}
	
	public String getTaskCompDtStr() {
		if(taskCompDt==null) {
			return null;
		}
		return taskCompDt.format(DateTimeFormatter.ISO_DATE);
	}
	
	public String getTaskDelDtStr() {
		if(taskDelDt==null) {
			return null;
		}
		return taskDelDt.format(DateTimeFormatter.ISO_DATE);
	}
	
	/**
	 * 처리 완료 예정일을 계산하기 위한 Getter
	 * @return
	 */
	public LocalDateTime getTaskExCompDt() {
		if(taskCompDt==null) {
			return null;
		}
		int endDays=0;
		if("T00003".equals(tsId)) {
			endDays=3;
		}else {
			endDays=7;
		}
		return taskRegDt.plusDays(endDays);
	}
	
	//처리 완료 예정일 문자열
	public String getTaskExCompDtStr() {
		if(taskCompDt==null) {
			return null;
		}
		LocalDateTime taskExCompDt = getTaskExCompDt();
		return taskExCompDt.format(DateTimeFormatter.ISO_DATE);
	}
	
	
	
}
