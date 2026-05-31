package kr.or.navi.quick.book.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of= {"bkId"})
public class BookNameVO {
	private String bkId;
	private String bkNm;
}
