package kr.or.navi.weather.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.navi.vo.WeatherVO;

@Mapper
public interface WeatehrDAO {
	
	public List<WeatherVO> selectWeatherList();
	public WeatherVO selectCurWeather();
	
}
