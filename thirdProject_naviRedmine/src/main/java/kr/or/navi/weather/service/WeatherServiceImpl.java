package kr.or.navi.weather.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.navi.vo.WeatherVO;
import kr.or.navi.weather.dao.WeatehrDAO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class WeatherServiceImpl implements WeatherService{
	
	@Inject
	WeatehrDAO dao;
	
	@Override
	public List<WeatherVO> selectWeatherList() {
		
		return dao.selectWeatherList();
	}

	@Override
	public WeatherVO selectCurWeather() {
		
		return dao.selectCurWeather();
	}

	
	
}
