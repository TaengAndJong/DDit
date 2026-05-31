package kr.or.navi.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="bpShrYn")
public class ShareStatVO implements Serializable{
	private String bpShrYn;
	private String shrName;
}
