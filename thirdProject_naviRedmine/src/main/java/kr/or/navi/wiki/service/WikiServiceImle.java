package kr.or.navi.wiki.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.BoardPostVO;
import kr.or.navi.vo.IssueFileVO;
import kr.or.navi.vo.WikiFileVO;
import kr.or.navi.vo.WikiVO;
import kr.or.navi.wiki.dao.WikiDAO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class WikiServiceImle implements WikiService{
	
	@Inject
	private WikiDAO dao;

	@Override
	public List<WikiVO> retrieveWikiList(PaginationInfo paging) {
		int totalRecord = dao.totalRecord(paging);
		paging.setTotalRecord(totalRecord);
		return dao.selectWikiList(paging);
	}

	@Override
	public WikiVO retrieveWiki(String wikiId) {
		return dao.selectWiki(wikiId);
	}
	@Value("file:D:/saveFiles/")
	private Resource saveFolder;
	@Override
	public int modifyWiki(WikiVO vo) throws IOException {
		List<WikiFileVO> wikiFileList = vo.getWikiFileList();
		int cnt=0;
		for(WikiFileVO bpfVO : wikiFileList) {
			MultipartFile bpAttchFile = bpfVO.getBpAttchFile();
			String uuid = saveToResource(bpAttchFile, saveFolder);
			bpfVO.setWikiUuidName(uuid); 
			bpfVO.setWikiId(vo.getWikiId());
			cnt+=dao.insertFile(bpfVO);
		}
		cnt+=dao.updateWiki(vo);
		return cnt;
	}
	private String saveToResource(MultipartFile single, Resource saveFolder) throws IOException {
		String saveName = UUID.randomUUID().toString(); //겹치지 않는 걸로 만들어주기 위해 random으로 생성
		Resource saveFileRes = saveFolder.createRelative(saveName);
		File saveFile = saveFileRes.getFile(); //저장을 하기 위해선 File로 변환
		try(
				InputStream is = single.getInputStream();
				){
			FileUtils.copyInputStreamToFile(is, saveFile); //저장
		}
		return saveName;
	}
//
//	@Override
//	public int removeWiki(String bpId) {
//		return dao.deleteWiki(bpId);
//	}
//
//	@Override
//	public int createWiki(WikiVO vo) {
//		return dao.insertWiki(vo);
//	}

	@Override
	public WikiVO retriveProWiki(String proId) {
		return dao.selectProWiki(proId);
	}

	@Override
	public int createWiki(WikiVO vo) throws IOException {
		 int cnt = dao.insertWiki(vo);
		 List<WikiFileVO> wikiFileList = vo.getWikiFileList();
		for(WikiFileVO bpfVO : wikiFileList) {
			MultipartFile bpAttchFile = bpfVO.getBpAttchFile();
			String uuid = saveToResource(bpAttchFile, saveFolder);
			bpfVO.setWikiUuidName(uuid); 
			bpfVO.setWikiId(vo.getWikiId());
			cnt+=dao.insertFile(bpfVO);
		}
		return cnt;
	}

	@Override
	public List<WikiFileVO> retriveFileList(String wikiId) {
		return dao.selectWikiFileList(wikiId);
	}

	@Override
	public ResponseEntity<Resource> downloadFile(String wfId) throws IOException {
		WikiFileVO attach = dao.selectWikiFile(wfId);
		String bpOrgNm = attach.getWfOrgNm();
		String bpUuidName = attach.getWikiUuidName();
		Resource imageFile = saveFolder.createRelative(bpUuidName);
//		Content-Disposition: attachment; filename="filename.jpg"
		if(!imageFile.exists()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND,String.format("%s 파일을 찾을 수 없음",bpOrgNm));
		}
		HttpHeaders headers = new HttpHeaders();
		headers.setContentLength(imageFile.contentLength());
		ContentDisposition disposition = ContentDisposition.attachment()
				.filename(bpOrgNm, Charset.forName("UTF-8"))
				.build();
		headers.setContentDisposition(disposition);
		return ResponseEntity.ok()
				.headers(headers)
				.body(imageFile);
	}

	@Override
	public int removeWikiFile(String wfId) throws IOException {
		WikiFileVO attach = dao.selectWikiFile(wfId);
		String bpOrgNm = attach.getWfOrgNm();
		String bpUuidName = attach.getWikiUuidName();
		Resource imageFile = saveFolder.createRelative(bpUuidName);
		File file = imageFile.getFile();
		int cnt=0;
		if(file.delete()) {
			 cnt+= dao.deleteWikiFile(wfId);
		}else {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND,String.format("%s 파일을 찾을 수 없음",bpOrgNm));
		}
		return cnt;
	}

}
