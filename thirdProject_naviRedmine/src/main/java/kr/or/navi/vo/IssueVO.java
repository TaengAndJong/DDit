package kr.or.navi.vo;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.validation.constraints.NotBlank;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import kr.or.navi.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="issueId")
public class IssueVO implements Serializable{
	private int rnum;
	private String issueId;
	private String proId;
	private String empName;
	@NotBlank
	private String issueRegId;
	private String impName;
	private String stateName;
	@NotBlank
	private String imprtId;
	@NotBlank
	private String clsfcId;
	@NotBlank
	private String issueTitle;
	@NotBlank
	private String issueCn;
	private String deptName;
	private String psName;
	private LocalDateTime issueRegDt;
	private LocalDateTime issueModDt;
	private LocalDateTime issueDelDt;
	private MultipartFile[] bpAttchFile;
	private List<IssueFileVO> issueFileList;
	public List<IssueFileVO> getIssueFileList(){
		issueFileList = new ArrayList<IssueFileVO>();
		if(bpAttchFile != null) {
			for (MultipartFile file : bpAttchFile) {
				long size = file.getSize();
				if(size>0) {
					IssueFileVO ifVO = new IssueFileVO();
					ifVO.setBpAttchFile(file);
					ifVO.setIssueId(issueId);
					
					long fileSize = file.getSize();
					ifVO.setIssfFileSize(convertFileSize(fileSize));
					
					issueFileList.add(ifVO);
				}
			}
		}
		return issueFileList;
	}
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
	public String getIssueCn() {
		if(StringUtils.isBlank(issueCn))
			return issueCn;
		return issueCn.trim();
	}
	public String getIssueModDtStr() {
		if(issueModDt==null)
			return null;
		return issueModDt.format(DateTimeFormatter.ISO_DATE);
	}
	public String getIssueRegDtStr() {
		if(issueRegDt==null)
			return null;
		return issueRegDt.format(DateTimeFormatter.ISO_DATE);
	}
	public String getIssueDelDtStr() {
		if(issueDelDt==null)
			return null;
		return issueDelDt.format(DateTimeFormatter.ISO_DATE);
	}
}
