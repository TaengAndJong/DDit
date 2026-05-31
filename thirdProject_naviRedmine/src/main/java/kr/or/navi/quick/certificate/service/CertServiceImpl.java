package kr.or.navi.quick.certificate.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.navi.quick.certificate.dao.CertDAO;
import kr.or.navi.quick.certificate.vo.CertVO;
import kr.or.navi.quick.news.dao.NewsDAO;
import kr.or.navi.quick.news.vo.NewsVO;
import kr.or.navi.vo.EmpVO;

@Service
public class CertServiceImpl implements CertService {
	@Inject
	private CertDAO dao;

	@Override
	public List<CertVO> selectCertList() {
		return dao.selectCertList();
	}

	@Override
	public List<CertVO> recomCertList(EmpVO vo) {
		Integer empAge = vo.getEmpAge();
		Integer empCareer = vo.getEmpCareer();
		Integer empCertCg = vo.getEmpCertCg();
		HashMap<String, String> map = trasEmpData(empAge, empCareer, empCertCg);
		return dao.selectRecomCertList(map);
	}

	private HashMap<String, String> trasEmpData(Integer empAge, Integer empCareer, Integer empCertCg) {
		HashMap<String, String> map = new HashMap<String, String>();
		if (empAge >= 20) {
			map.put("age", "0");
		} else if (empAge >= 30) {
			map.put("age", "1");
		} else if (empAge >= 40) {
			map.put("age", "2");
		} else if (empAge >= 50) {
			map.put("age", "3");
		} else {
			map.put("age", "4");
		}

		if (empCareer < 6) {
			map.put("career", "0");
		} else if (empCareer < 11) {
			map.put("career", "1");
		} else if (empCareer < 16) {
			map.put("career", "2");
		} else if (empCareer < 21) {
			map.put("career", "3");
		} else {
			map.put("career", "4");
		}

		if (empCertCg == 0) {
			map.put("category", "0");
		} else if (empCertCg == 1) {
			map.put("category", "1");
		} else if (empCertCg == 2) {
			map.put("category", "2");
		} else if (empCertCg == 3) {
			map.put("category", "3");
		} else if (empCertCg == 4) {
			map.put("category", "4");
		} else {
			map.put("category", "5");
		}
		return map;
	}
}
