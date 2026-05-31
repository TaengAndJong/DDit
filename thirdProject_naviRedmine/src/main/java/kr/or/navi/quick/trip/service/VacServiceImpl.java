package kr.or.navi.quick.trip.service;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.navi.common.exception.PKNotFoundException;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.quick.trip.dao.VacDAO;
import kr.or.navi.quick.trip.vo.VacVO;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class VacServiceImpl implements VacService {
	@Inject
	private VacDAO dao;
	
	@Override
	public List<VacVO> selectVacList(PaginationInfo paging){
		int totalRecord = dao.selectTotalRecord();
		paging.setTotalRecord(totalRecord);
		return dao.selectVacList(paging);
	}
	@Override
	public List<VacVO> recomVacList(EmpVO vo){
		Integer empAge = vo.getEmpAge(); //int 나이
		String fmPer = vo.getEmpFmId(); //String 가족Label
		String deptName = vo.getDeptName(); //String 부서이름
		HashMap<String, String> map = trasEmpData(empAge, fmPer, deptName);
		map.put("per", fmPer);
		log.info("map:{}",map);
		return dao.selectRecomVacList(map);
		
	}
	
	private HashMap<String, String> trasEmpData(Integer empAge, String fmPer, String deptName) {
		HashMap<String, String> map = new HashMap<String, String>();
		if(empAge>=20) {
			map.put("age", "0");
		}else if(empAge>=30) {
			map.put("age", "1");
		}else if(empAge>=40) {
			map.put("age", "2");
		}else if(empAge>=50) {
			map.put("age", "3");
		}else {
			map.put("age", "4");
		}
		
			
		if(deptName.contains("개발")) {
			map.put("dept","0");
		}else if(deptName.contains("디자인")) {
			map.put("dept","1");
		}else if(deptName.contains("마케팅")) {
			map.put("dept","2");
		}else if(deptName.contains("기획")) {
			map.put("dept","3");
		}else {
			map.put("dept","4");
		}
		return map;
	}
	@Override
	public int insertVacView(String empId, String vacId) {
		return dao.insertVacView(empId, vacId);
	}
	@Override
	public int viewCnt(String vacId) {
		return dao.updateView(vacId);
	}
	
//	@Override
//	public VacVO selectVacOne(String vacId) {
//		VacVO vacOne = dao.selectVacOne(vacId);
//		if(vacOne==null) {
//			throw new PKNotFoundException(String.format("여행지 없음", vacId));
//		}
//		return vacOne;
//	}
}
