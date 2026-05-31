package kr.or.navi.weather.service;

import java.util.List;

import kr.or.navi.vo.WeatherVO;

public interface WeatherService {
	
	public List<WeatherVO> selectWeatherList();
	public WeatherVO selectCurWeather();
}
