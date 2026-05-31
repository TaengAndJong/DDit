package kr.or.navi.vo;

import java.io.Serializable;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="tfId")
public class TaskFileVO implements Serializable{
	private String tfOrgNm;
	private String tfGbId;
	private String tfId;
	private String taskId;
	private String empId;
	private String tfAttchFile;
	private String taskUuidName;
	private String taskFileSize;
	private MultipartFile bpAttchFile;
	public String getTfOrgNm() {
		if (bpAttchFile != null) {
			return bpAttchFile.getOriginalFilename();
		}
		return tfOrgNm;
	}
	public String getTfGbId() {
		if (StringUtils.isNotBlank(getTfOrgNm())) {
			String[] split = getTfOrgNm().split("\\.");
			int last = split.length - 1;
			if (last >= 0) {
				return split[last];
			}
		}
		if (StringUtils.isNotBlank(tfGbId)) {
			return tfGbId.trim();
		}
		return tfGbId;
	}
}
