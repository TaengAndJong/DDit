package kr.or.navi.projectdetail.calendar.vo;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;

import kr.or.navi.vo.TaskVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
@Data
@EqualsAndHashCode(of="solasrDate")
public class TaskFulAdapterVO {
	private String solasrDate;
	private int rnum;
	private List<TaskVO> taskList;
	
	/**
	 * 문자열로 되어 있는 데이터를 LocalDateTime으로 설정하기 위한 getter 설정
	 * @return
	 */
	public LocalDateTime getSolaDateReal() {
		
		try {
			taskList.get(rnum).getTaskRegDt();
	        // 한국의 달력 기준으로 LocalDateTime 객체로 파싱
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
	        LocalDate parsedDate = LocalDate.parse(solasrDate, formatter);
	        return parsedDate.atStartOfDay();
	    } catch (DateTimeParseException e) {
	        e.printStackTrace();
	        return null;
	    }
	}
	
	public TaskFulAdapterVO() {
	}
}
