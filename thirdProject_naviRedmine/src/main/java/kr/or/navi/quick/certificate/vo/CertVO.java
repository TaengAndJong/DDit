package kr.or.navi.quick.certificate.vo;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringExclude;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "certId")
public class CertVO implements Serializable {
	private String certId;
	private String certImgUrl;
	private String certUrl;
	private String certRange;
	private String certName;
	@ToStringExclude // 문자가 너무길다면 해야하는 처리 log 발생시
	private String certInfo;
}
