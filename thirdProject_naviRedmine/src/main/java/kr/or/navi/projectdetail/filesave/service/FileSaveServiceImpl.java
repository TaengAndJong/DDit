package kr.or.navi.projectdetail.filesave.service;

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
import kr.or.navi.projectdetail.filesave.dao.FileSaveNoriceDAO;
import kr.or.navi.vo.FileSaveFileVO;
import kr.or.navi.vo.FileSaveNoticeVO;
import kr.or.navi.vo.FileSaveVO;
import kr.or.navi.vo.IssueFileVO;
@Service
public class FileSaveServiceImpl implements FileSaveService {
	@Inject
	private FileSaveNoriceDAO dao;
	@Override
	public List<FileSaveNoticeVO> retrieveFileSaveNotice(PaginationInfo paging, String proId) {
		int totalRecord = dao.selectTotalRecord(paging, proId);
		paging.setTotalRecord(totalRecord);
		return dao.selectFileSaveNoiceList(paging,proId);
	}
	@Override
	public FileSaveNoticeVO retrieveFileSaveVO(String fsnId) {
		return dao.selectFileSaveNoriceOne(fsnId);
	}
	@Override
	public int removeFileSave(String fsnId) {
		return dao.deleteFileSaveNotice(fsnId);
	}
	@Value("file:D:/saveFiles/")
	private Resource saveFolder;
	@Override
	public int modifyFileSave(FileSaveNoticeVO updateFs) throws IOException {
		List<FileSaveFileVO> fileSaveFileList = updateFs.getFileSaveFileList();
		int cnt=0;
		for(FileSaveFileVO bpfVO : fileSaveFileList) {
			MultipartFile bpAttchFile = bpfVO.getBpAttchFile();
			String uuid = saveToResource(bpAttchFile, saveFolder);
			bpfVO.setFsUuidName(uuid); 
			bpfVO.setFsnId(updateFs.getFsnId());
			bpfVO.setProId(updateFs.getProId());
			cnt+=dao.insertFile(bpfVO);
		}
		cnt+=dao.updateFileSaveNotice(updateFs);
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
	public int createFileSave(FileSaveNoticeVO insertFs) throws IOException {
		FileSaveVO fsv = dao.selectFileSave(insertFs.getProId());
		insertFs.setFsId(fsv.getFsId());
		int cnt = dao.insertFileSaveNotice(insertFs);
		List<FileSaveFileVO> fileSaveFileList = insertFs.getFileSaveFileList();
		for(FileSaveFileVO bpfVO : fileSaveFileList) {
			MultipartFile bpAttchFile = bpfVO.getBpAttchFile();
			String uuid = saveToResource(bpAttchFile, saveFolder);
			bpfVO.setFsUuidName(uuid); 
			bpfVO.setFsnId(insertFs.getFsnId());
			bpfVO.setProId(insertFs.getProId());
			cnt+=dao.insertFile(bpfVO);
		}
		return cnt;
	}
	@Override
	public List<FileSaveFileVO> retriveFileSaveFileList(String fsnId) {
		return dao.selectFileSaveFileList(fsnId);
	}
	@Override
	public ResponseEntity<Resource> downloadFile(String fsnId) throws IOException {
		FileSaveFileVO attach = dao.selectFileSaveFile(fsnId);
		String bpUuidName = attach.getFsUuidName();
		String bpOrgNm = attach.getFsfOrgNm();
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
	public int removeFileSaveFile(String fsnId) throws IOException {
		FileSaveFileVO attach = dao.selectFileSaveFile(fsnId);
		String bpOrgNm = attach.getFsfOrgNm();
		String bpUuidName = attach.getFsUuidName();
		Resource imageFile = saveFolder.createRelative(bpUuidName);
		File file = imageFile.getFile();
		int cnt=0;
		if(file.delete()) {
			 cnt+= dao.deleteFileSaveFile(fsnId);
		}else {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND,String.format("%s 파일을 찾을 수 없음",bpOrgNm));
		}
		return cnt;
	}

}
