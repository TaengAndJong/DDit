package kr.or.navi.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="tpsId")
public class TaskProcessStatusVO {
	
	private String tpsId; // 일감처리ID ( T00001, T00002,...T00007)
	private String tpsName;//일감처리명 (대기,진행중, 처리완료, 최종완료
	private String tpsIng;//일감처리 진행률 ( 10%, 30%, 50%, 70%,90%,99%, 100%)
	private String tpsDesc;//일감처리 설명 ( 대기, 진행중, 처리완료, 최종완료) 
}

