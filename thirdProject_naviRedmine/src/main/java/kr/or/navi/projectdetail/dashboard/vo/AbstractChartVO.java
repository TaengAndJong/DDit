package kr.or.navi.projectdetail.dashboard.vo;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

import lombok.Getter;

@Getter
@JsonInclude(value = Include.NON_EMPTY)
public abstract class AbstractChartVO<T> {
	private final T extendedProps;
	public AbstractChartVO(T extendedProps) {
		this.extendedProps=extendedProps;
	}
	public abstract String getData();
	public abstract String getLabels();
}
