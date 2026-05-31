package kr.or.navi.quick.news.service;

import java.util.List;

import kr.or.navi.quick.news.vo.NewsVO;
import kr.or.navi.vo.EmpVO;

public interface NewsService {
	public List<NewsVO> selectNewsList();
	public List<NewsVO> recomNewsList(EmpVO vo);
	public int insertNewsView(String empId,String newsId);
}
