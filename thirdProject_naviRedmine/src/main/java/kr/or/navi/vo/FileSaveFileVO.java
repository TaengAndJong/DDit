package kr.or.navi.vo;

import java.io.Serializable;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "fsfId")
public class FileSaveFileVO implements Serializable {
	private String fsfId;
	private String fsnId;
	private String proId;
	private String fsfRegId;
	private String fsfGbId;
	private String fsfAttchFile;
	private String fsfOrgNm;
	private MultipartFile bpAttchFile;
	private String fsUuidName;
	private String fsFileSize;

	public String getFsfOrgNm() {
		if (bpAttchFile != null) {
			return bpAttchFile.getOriginalFilename();
		}
		return fsfOrgNm;
	}

	public String getFsfGbId() {
		if (StringUtils.isNotBlank(getFsfOrgNm())) {
			String[] split = getFsfOrgNm().split("\\.");
			int last = split.length - 1;
			if (last >= 0) {
				return split[last];
			}
		}
		if (StringUtils.isNotBlank(fsfGbId)) {
			return fsfGbId.trim();
		}
		return fsfGbId;
	}
}
