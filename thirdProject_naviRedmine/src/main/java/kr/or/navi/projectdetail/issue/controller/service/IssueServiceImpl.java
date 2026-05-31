package kr.or.navi.projectdetail.issue.controller.service;

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

import kr.or.navi.project.dao.IssueDAO;
import kr.or.navi.vo.BoardPostFileVO;
import kr.or.navi.vo.IssueCommentVO;
import kr.or.navi.vo.IssueFileVO;
import kr.or.navi.vo.IssueVO;

@Service
public class IssueServiceImpl implements IssueService{

	@Inject
	private IssueDAO dao;
	@Override
	public IssueVO selectIssueOne(String issueId) {
		return dao.selectIssue(issueId);
	}
	@Override
	public int removeIssue(String issueId) {
		return dao.deleteIssue(issueId);
	}
	@Value("file:D:/saveFiles/")
	private Resource saveFolder;
	@Override
	public int modifyIssue(IssueVO issue) throws IOException {
		List<IssueFileVO> issueFileList = issue.getIssueFileList();
		int cnt=0;
		for(IssueFileVO bpfVO : issueFileList) {
			MultipartFile bpAttchFile = bpfVO.getBpAttchFile();
			String uuid = saveToResource(bpAttchFile, saveFolder);
			bpfVO.setIssueUuidName(uuid); 
			bpfVO.setIssueId(issue.getIssueId());
			bpfVO.setProId(issue.getProId());
			cnt+=dao.insertFile(bpfVO);
		}
		cnt+=dao.updateIssue(issue);
		return cnt;
	}
	@Override
	public int createIssue(IssueVO issue) throws IOException {
		int cnt = dao.insertIssue(issue);
		List<IssueFileVO> issueFileList = issue.getIssueFileList();
		for(IssueFileVO bpfVO : issueFileList) {
			MultipartFile bpAttchFile = bpfVO.getBpAttchFile();
			String uuid = saveToResource(bpAttchFile, saveFolder);
			bpfVO.setIssueUuidName(uuid); 
			bpfVO.setIssueId(issue.getIssueId());
			bpfVO.setProId(issue.getProId());
			cnt+=dao.insertFile(bpfVO);
		}
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
	
	@Override
	public List<IssueCommentVO> retrieveIssueCommentList(String issueId) {
		return dao.selectIssueCommentList(issueId);
	}
	
	@Override
	public int removeIssueComment(String icId) {
		return dao.deleteIssueComment(icId);
	}
	
	@Override
	public int createIssueComment(IssueCommentVO issueComment){
		int cnt = dao. insertIssueComment(issueComment);
		return cnt;
	}
	
	@Override
	public List<IssueFileVO> retriveFileList(String issueId) {
		return dao.selectIssueFileList(issueId);
	}
	@Override
	public ResponseEntity<Resource> downloadFile(String issfId) throws IOException {
		IssueFileVO attach = dao.selectIssueFile(issfId);
		String bpUuidName = attach.getIssueUuidName();
		String bpOrgNm = attach.getIssfOrgNm();
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
	public int removeIssueFile(String issfId) throws IOException {
		IssueFileVO attach = dao.selectIssueFile(issfId);
		String bpOrgNm = attach.getIssfOrgNm();
		String bpUuidName = attach.getIssueUuidName();
		Resource imageFile = saveFolder.createRelative(bpUuidName);
		File file = imageFile.getFile();
		int cnt=0;
		if(file.delete()) {
			 cnt+= dao.deleteIssueFile(issfId);
		}else {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND,String.format("%s 파일을 찾을 수 없음",bpOrgNm));
		}
		return cnt;
	}


}
