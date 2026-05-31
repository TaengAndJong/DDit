package kr.or.navi.quick.news.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="newsCgID")
public class NewsVO implements Serializable{
	private String newsCgId;
	private String newsCgName;
	private String newsUrl;
	private String newsRegDt;
	private String newsRepot;
	private String newsImgUrl;
}
