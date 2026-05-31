package kr.or.navi.vo;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.validation.constraints.NotBlank;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="wikiId")
public class WikiVO implements Serializable{
	private int rnum;
	private String wikiId;
	private String proId;
	private String proName;
	@NotBlank
	private String wikiTitle;
	@NotBlank
	private String wikiCn;
	private LocalDateTime wikiRegDt;
	private LocalDateTime wikiModDt;
	private LocalDateTime wikiDelDt;
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
	private LocalDateTime proRegDt;
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	private LocalDateTime proDdlineEx;
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
	private LocalDateTime proDdlineDt;
	private String proDdlineYn;
	private String cmId;
	private String cmName;
	private String empId;
	private String empName;
	private MultipartFile[] bpAttchFile;
	private List<WikiFileVO> wikiFileList;
	public List<WikiFileVO> getWikiFileList(){
		wikiFileList = new ArrayList<WikiFileVO>();
		if(bpAttchFile != null) {
			for (MultipartFile file : bpAttchFile) {
				long size = file.getSize();
				if(size>0) {
					WikiFileVO ifVO = new WikiFileVO();
					ifVO.setBpAttchFile(file);
					ifVO.setWikiId(wikiId);
					
					long fileSize = file.getSize();
					ifVO.setWikiFileSize(convertFileSize(fileSize));
					
					wikiFileList.add(ifVO);
				}
			}
		}
		return wikiFileList;
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
	public boolean isPLMember(EmpVO emp) {
		return emp.getEmpId().equals(this.empId);
	}
	private List<TeamVO> teamList;
	
	public String getProRegDtStr() {
		if(proRegDt!=null)
		return proRegDt.format(DateTimeFormatter.ISO_DATE);
		return null;
	}
	public String getRealProRegDtStr() {
		if(proRegDt!=null)
		return proRegDt.format(DateTimeFormatter.ISO_DATE_TIME);
		return null;
	}
	public String getProDdlineExStr() {
		if(proDdlineEx!=null)
		return proDdlineEx.format(DateTimeFormatter.ISO_DATE);
		return null;
	}
	public String getWikiModDtStr() {
		if(wikiModDt!=null)
		return wikiModDt.format(DateTimeFormatter.ISO_DATE);
		return null;
	}
}
