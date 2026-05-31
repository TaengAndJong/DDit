package kr.or.navi.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

import lombok.Data;
import lombok.EqualsAndHashCode;


@Data
public class WeatherVO  implements Serializable {
	
	@NotBlank
	private String weatherId;//날씨조회
	@NotBlank
	private String weatherType;//날씨종류
	@NotBlank
	private String dust;//미세먼지
	@NotBlank
	private String uv;//자외선	
	@NotBlank
	private String temp;//온도


}
