package kr.or.navi.mypagedetail.alarm.service;

import java.util.List;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.AlarmVO;

public interface AlramService {
	public List<AlarmVO> retriveAlarmList(String empId,PaginationInfo paging);
	public int modifyReadAll(String empId);
}
