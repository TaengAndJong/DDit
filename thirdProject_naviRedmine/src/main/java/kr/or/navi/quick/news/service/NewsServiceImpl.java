package kr.or.navi.quick.news.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.navi.quick.news.dao.NewsDAO;
import kr.or.navi.quick.news.vo.NewsVO;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
public class NewsServiceImpl implements NewsService {
	@Inject
	private NewsDAO dao;
	
	@Override
	public List<NewsVO> selectNewsList() {
		return dao.selectNewsList();
	}

	@Override
	public List<NewsVO> recomNewsList(EmpVO vo) {
		Integer empAge = vo.getEmpAge();
		String deptName = vo.getDeptName();
		String empGen = vo.getEmpGen();
		HashMap<String, String> map = trasEmpData(empAge, deptName, empGen);
		log.info("map:{}",map);
		return dao.selectRecomNewsList(map);
	}

	private HashMap<String, String> trasEmpData(Integer empAge,String deptName,String empGen){
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
		
		if(empGen.equals("F")) {
			map.put("gen", "0");
		}else {
			map.put("gen", "1");
		}
		return map;
	}

	@Override
	public int insertNewsView(String empId, String newsId) {
		return dao.insertNewsView(empId, newsId);
	}
}
