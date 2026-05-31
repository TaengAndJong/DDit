package kr.or.navi.vo;

import java.io.Serializable;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="issffId")
public class IssueFileVO implements Serializable {
	private String issffId;
	private String issueId;
	private String proId;
	private String issfRegId;
	private String issfGbId;
	private String issfAttchFile;
	private String issfOrgNm;
	private MultipartFile bpAttchFile; 
	private String issfFileSize;
	private String issueUuidName;
	public String getIssfOrgNm() {
		if (bpAttchFile != null) {
			return bpAttchFile.getOriginalFilename();
		}
		return issfOrgNm;
	}

	public String getIssfGbId() {
		if (StringUtils.isNotBlank(getIssfOrgNm())) {
			String[] split = getIssfOrgNm().split("\\.");
			int last = split.length - 1;
			if (last >= 0) {
				return split[last];
			}
		}
		if (StringUtils.isNotBlank(issfGbId)) {
			return issfGbId.trim();
		}
		return issfGbId;
	}
}
