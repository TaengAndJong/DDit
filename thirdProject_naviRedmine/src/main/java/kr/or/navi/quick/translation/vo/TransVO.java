package kr.or.navi.quick.translation.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

/*한국어(ko), 일본어(ja), 중국어 간체(zh-CN), 중국어 번체(zh-TW), 힌디어(hi), 영어(en)
스페인어(es), 프랑스어(fr), 독일어(de), 포르투갈어(pt),베트남어(vi),인도네시아어(id),
페르시아어(fa),아랍어(ar),미얀마어(mm),태국어(th),러시아어(ru),이탈리아어(it)*/
@Data
@EqualsAndHashCode(of="language")
public class TransVO {
	private String language;
	private String name;
}
