package kr.or.navi.mypagedetail.alarm.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.mypagedetail.alarm.dao.AlramDAO;
import kr.or.navi.vo.AlarmVO;
@Service
public class AlramServiceImpl implements AlramService {
	
	@Inject
	private AlramDAO dao;
	@Override
	public List<AlarmVO> retriveAlarmList(String empId,PaginationInfo paging) {
		int totalRecord = dao.selectTotalRecord(empId, paging);
		paging.setTotalRecord(totalRecord);
		return dao.selectAlramList(empId, paging);
	}
	@Override
	public int modifyReadAll(String empId) {
		return dao.updateReadAlramAll(empId);
	}
	

}
