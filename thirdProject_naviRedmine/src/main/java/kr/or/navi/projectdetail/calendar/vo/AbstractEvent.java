package kr.or.navi.projectdetail.calendar.vo;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

import lombok.Getter;

/**
 * https://fullcalendar.io/docs/event-object 참고
 *
 * @param <T> : FullCalendar 로 출력하고 싶은 데이터 타입
 */

@Getter
@JsonInclude(value = Include.NON_EMPTY)
public abstract class AbstractEvent<T> {
	private final T extendedProps;

	protected AbstractEvent(T extendedProps) {
		this.extendedProps = extendedProps;
	}
	
	public abstract String getId();
	public abstract String getGroupId();
	public abstract boolean isAllDay();
	public abstract LocalDateTime getStart();
	public abstract LocalDateTime getEnd();
	public abstract String getStartStr();
	public abstract String getEndStr();
	public abstract String getTitle();
	
	public String getUrl() {
		return null;
	}
	public  String[] getClassNames() {
		return null;
	}

	public boolean isEditable(){
		return false;
	}
	public String getTextColor() {
		return null;
	}
	public String getBackgroundColor() {
		return null;
	}
}
