package kr.or.navi.vo;

import java.io.Serializable;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="wfId")
public class WikiFileVO implements Serializable{
	private String wfId;
	private String wikiId;
	private String wkFileGbId;
	private String wfAttchFile;
	private String wfOrgNm;
	private MultipartFile bpAttchFile; 
	private String wikiFileSize;
	private String wikiUuidName;
	public String getWfOrgNm() {
		if (bpAttchFile != null) {
			return bpAttchFile.getOriginalFilename();
		}
		return wfOrgNm;
	}

	public String getWkFileGbId() {
		if (StringUtils.isNotBlank(getWfOrgNm())) {
			String[] split = getWfOrgNm().split("\\.");
			int last = split.length - 1;
			if (last >= 0) {
				return split[last];
			}
		}
		if (StringUtils.isNotBlank(wkFileGbId)) {
			return wkFileGbId.trim();
		}
		return wkFileGbId;
	}
}
