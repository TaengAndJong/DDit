package kr.or.navi.alarm.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.or.navi.vo.AlarmTypeVO;

@Mapper
public interface AlramTypeDAO {
	public AlarmTypeVO selectAlramType(String altypeId);
}
