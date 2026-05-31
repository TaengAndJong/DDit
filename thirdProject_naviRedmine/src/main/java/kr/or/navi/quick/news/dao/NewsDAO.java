package kr.or.navi.quick.news.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.navi.quick.news.vo.NewsVO;

@Mapper
public interface NewsDAO {
	public List<NewsVO> selectNewsList();
	public List<NewsVO> selectRecomNewsList(@Param("map") HashMap<String, String> map);
	public int insertNewsView(@Param("empId") String empId,@Param("newsId") String newsId);
}
