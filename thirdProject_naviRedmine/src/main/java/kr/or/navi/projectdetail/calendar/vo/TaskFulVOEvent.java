package kr.or.navi.projectdetail.calendar.vo;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import kr.or.navi.vo.TaskStatusVO;
import kr.or.navi.vo.TaskVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
public class TaskFulVOEvent extends AbstractEvent<TaskFulAdapterVO>{
	
	public TaskFulVOEvent(TaskFulAdapterVO extendedProps) {
		super(extendedProps);
	}
	@Override
	public String getUrl() {
		return super.getUrl();
	}

	@Override
	public String getId() {
		return getExtendedProps().getSolasrDate();
	}

	@Override
	public String getGroupId() {
		return null;
	}

	@Override
	public boolean isAllDay() {
		return false;
	}

	/**
	 * 시작일
	 */
	@Override
	public LocalDateTime getStart() {
		return getExtendedProps().getSolaDateReal();
	}

	/**
	 * 종료일
	 */
	@Override
	public LocalDateTime getEnd() {
		return getExtendedProps().getSolaDateReal();
	}

	/**
	 * 문자열로 조회하기 위한 포메팅
	 */
	@Override
	public String getStartStr() {
		LocalDate date = getExtendedProps().getSolaDateReal().toLocalDate();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		return date.format(formatter);
	}
	/**
	 * 문자열로 조회하기 위한 포메팅
	 */
	@Override
	public String getEndStr() {
		LocalDate date = getExtendedProps().getSolaDateReal().toLocalDate();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		return date.format(formatter);
	}

	/**
	 * 일감 상태에 따라 동적으로 커스텀된 라벨을 만들기 위한 getter
	 * 
	 */
	@Override
	public String getTitle() {
		//일검 전체 조회
		List<TaskVO> taskList = getExtendedProps().getTaskList();
		log.info("taskList : {}",taskList);
		if(taskList.isEmpty()) {
			return null;
		}
		//긴급 단계 카운트를 위한 지역 변수
		int danger=0;
		//일반 단계를 파악하기 위한 지역 변수
		int gener=0;
		for(TaskVO vo : taskList) {
			String tsId = vo.getTsId();
			if("T00003".equals(tsId)) {
				danger+=1;
			}else {
				gener+=1;
			}
		}
		return "<div class=\"cal-today_box\">"
				+ "<div class=\"cal-today_title\">"
				+ "	<span class=\"category new \">일감</span>"
				+ "	<span class=\"totalNum fw-bold\">"+taskList.size()+"</span><span>건</span>"
				+ "	</div>"
				+ "<ul class=\"cal-today_list\">"
				+ "	<li class=\"my-2\">"
				+ "<span class=\"category emergency \">긴급</span>\r\n"
				+ "<span class=\"num text-danger fw-bold\">"+danger+"</span>\r\n"
				+ "<span>건</span>"
				+ "</li>"
				+ "<li>"
				+ "<span class=\"category ordinary\">일반</span>\r\n"
				+ "<span class=\"num fw-bold\">"+gener+"</span>\r\n"
				+ "<span>건</span>"
				+ "</li>"
				+ "</ul>"
				+ "<button type=\"button\" class=\"btn btn-primary mt-2 w-100\" data-bs-toggle=\"modal\" data-bs-target=\"#exampleModal\">더보기</button>\r\n"
				+ "</div>";
	}
	
}
