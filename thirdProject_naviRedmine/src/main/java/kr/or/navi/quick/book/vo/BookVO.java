package kr.or.navi.quick.book.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of= {"bkListId"})
public class BookVO implements Serializable{
	private String bkListId;
	private String bkNm;
	private String bkUrl;
	private String bkTtl;
	private String bkAthr;
	private String bkCn;
}
