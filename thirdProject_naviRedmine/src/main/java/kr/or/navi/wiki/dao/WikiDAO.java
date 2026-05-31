package kr.or.navi.wiki.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.BoardPostVO;
import kr.or.navi.vo.WikiFileVO;
import kr.or.navi.vo.WikiVO;

@Mapper
public interface WikiDAO {
	
	public List<WikiVO> selectWikiList(PaginationInfo paging);
	public int totalRecord(PaginationInfo paging);
	public WikiVO selectWiki(@Param("wikiId") String wikiId);
	public WikiVO selectProWiki(@Param("proId") String proId);
	public int updateWiki(@Param("vo") WikiVO vo);
	public int insertWiki(WikiVO vo);
//	public int deleteWiki(@Param("bpId") String bpId);
//	public int insertWiki(BoardPostVO vo);
	public int insertFile(WikiFileVO bpfVO);
	public List<WikiFileVO> selectWikiFileList(String wikiId);
	public WikiFileVO selectWikiFile(String wfId);
	public int deleteWikiFile(String wfId);
}
