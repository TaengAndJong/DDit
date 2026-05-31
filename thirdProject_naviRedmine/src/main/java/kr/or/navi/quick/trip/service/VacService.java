package kr.or.navi.quick.trip.service;

import java.util.List;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.quick.trip.vo.VacVO;
import kr.or.navi.vo.EmpVO;

public interface VacService {
	public List<VacVO> selectVacList(PaginationInfo paging);
	public List<VacVO> recomVacList(EmpVO vo);
	public int insertVacView(String empId,String vacId);
	public int viewCnt(String vacId);
}
