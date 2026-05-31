package kr.or.navi.vo;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.validation.constraints.NotBlank;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(of = "fsnId")
public class FileSaveNoticeVO implements Serializable {
	private int rnum;
	private String fsnId;
	private String fsId;
	private String proId;
	private String fsnRegId;
	@NotBlank
	private String fsnTitle;
	@ToString.Exclude
	@NotBlank
	private String fsnCn;
	private LocalDateTime fsnRegDt;
	private LocalDateTime fsnModDt;
	private LocalDateTime fsnDelDt;
	private String deptName;
	private String empName;
	private String psName;
	private MultipartFile[] bpAttchFile;
	private List<FileSaveFileVO> fileSaveFileList;

	public List<FileSaveFileVO> getFileSaveFileList() {
		fileSaveFileList = new ArrayList<FileSaveFileVO>();
		if (bpAttchFile != null) {
			for (MultipartFile file : bpAttchFile) {
				long size = file.getSize();
				if (size > 0) {
					FileSaveFileVO ifVO = new FileSaveFileVO();
					ifVO.setBpAttchFile(file);
					ifVO.setFsnId(fsnId);

					long fileSize = file.getSize();
					ifVO.setFsFileSize(convertFileSize(fileSize));
					fileSaveFileList.add(ifVO);
				}
			}
		}
		return fileSaveFileList;
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

	public Object getFsnRegDtStr() {
		if (fsnRegDt != null)
			return fsnRegDt.format(DateTimeFormatter.ISO_DATE);
		return fsnRegDt;
	}

	public Object getFsnModDtStr() {
		if (fsnModDt != null)
			return fsnModDt.format(DateTimeFormatter.ISO_DATE);
		return fsnModDt;
	}
}
