package kr.or.navi.vo;

import java.io.Serializable;
import java.util.Arrays;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 파일 정보 VO
 *
 */
@Data
@EqualsAndHashCode(of = "bpFileId")
public class BoardPostFileVO implements Serializable {
	private String bpFileId; // 커뮤니티 파일ID
	private String bpId; // 커뮤니티 게시글ID
	private String bpFileGbId; // 커뮤니티 게시글 파일구분ID
	private MultipartFile bpAttchFile; // 커뮤니티 게시글 첨부파일
	private String bpOrgNm; // 커뮤니티 게시글 원본파일명
	private String bpMainImgYn; // 커뮤니티 프로필 여부
	private String bpUuidName; //파일업로드 uuid
	private String bpFileSize; //파일 size
	
	/**
	 * 파일의 실제이름을 DB에 저장
	 * @return bpOrgNm
	 */
	public String getBpOrgNm() {
		if (bpAttchFile != null) {
			return bpAttchFile.getOriginalFilename();
		}
		return bpOrgNm;
	}

	/**
	 *  파일의 확장자를 추출
	 * @return bpFileGbId
	 */
	public String getBpFileGbId() {
		if (StringUtils.isNotBlank(getBpOrgNm())) {
			String[] split = getBpOrgNm().split("\\.");
			int last = split.length - 1;
			if (last >= 0) {
				return split[last];
			}
		}
		if (StringUtils.isNotBlank(bpFileGbId)) {
			return bpFileGbId.trim();
		}
		return bpFileGbId;
	}
	
}
