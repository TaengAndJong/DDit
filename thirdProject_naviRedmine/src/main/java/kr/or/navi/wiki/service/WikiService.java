package kr.or.navi.wiki.service;

import java.io.IOException;
import java.util.List;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.BoardPostVO;
import kr.or.navi.vo.WikiFileVO;
import kr.or.navi.vo.WikiVO;

public interface WikiService {
	
	public List<WikiVO> retrieveWikiList(PaginationInfo paging);
	public WikiVO retrieveWiki(String wikiId);
	public int modifyWiki(WikiVO vo) throws IOException;
	public WikiVO retriveProWiki(String proId);
//	public int removeWiki(String bpId);
	public int createWiki(WikiVO vo) throws IOException;
	public List<WikiFileVO> retriveFileList(String wikiId);
	public ResponseEntity<Resource> downloadFile(String wfId) throws IOException;
	public int removeWikiFile(String wfId) throws IOException;
}
