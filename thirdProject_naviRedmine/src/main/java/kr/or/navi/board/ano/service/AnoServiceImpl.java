package kr.or.navi.board.ano.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.util.List;
import java.util.UUID;

import javax.annotation.PostConstruct;
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

import kr.or.navi.board.ano.dao.AnoDAO;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.BoardPostFileVO;
import kr.or.navi.vo.BoardPostVO;
import lombok.extern.slf4j.Slf4j;
@Service
@Slf4j
public class AnoServiceImpl implements AnoService {
	
	@Inject
	private AnoDAO dao;
	
	@PostConstruct
	public void init() {
		log.info("saveFolder:{}",saveFolder);
	}
	//메인데이터
	@Override
	public List<BoardPostVO> retrieveAnoMainList() {
		return dao.selectAnoMainList();
	}
	
	@Override
	public List<BoardPostVO> retrieveAnoList(PaginationInfo paging) {
		int totalRecord = dao.totalRecord(paging);
		paging.setTotalRecord(totalRecord);
		return dao.selectAnoList(paging);
	}
	@Override
	public BoardPostVO retrieveAno(String bpId) {
		return dao.selectAno(bpId);
	}
	
	@Override //,String empId
	public int modifyAno(BoardPostVO vo) throws IOException {
		List<BoardPostFileVO> bpFileVoList = vo.getBpFileVoList();
		int cnt=0;
		log.info("bpFileVoList :{}",bpFileVoList.size());
		for(BoardPostFileVO bpfVO : bpFileVoList) {
			MultipartFile bpAttchFile = bpfVO.getBpAttchFile();
			String uuid = saveToResource(bpAttchFile, saveFolder);
			bpfVO.setBpUuidName(uuid); 
			cnt+=dao.insertFile(bpfVO);
		}
		cnt+=dao.updateAno(vo);
		return cnt;
	}
	
	@Override
	public int removeAno(String bpId) {
		return dao.deleteAno(bpId);
	}
	
	@Override
	public int createAno(BoardPostVO vo) throws IOException {
		log.info("==>>saveFolder:{}",saveFolder);
		int cnt = dao.insertAno(vo);
		List<BoardPostFileVO> bpFileVoList = vo.getBpFileVoList();
		for(BoardPostFileVO bpfVO : bpFileVoList) {
			MultipartFile bpAttchFile = bpfVO.getBpAttchFile();
			String uuid = saveToResource(bpAttchFile, saveFolder);
			bpfVO.setBpUuidName(uuid); 
			cnt+= dao.insertFile(bpfVO);
		}
		return cnt;
	}
	
	@Override
	public List<BoardPostFileVO> retrieveAnoFile(String bpId) {
		return dao.selectFile(bpId);
	}
	

	@Override
	public int viewCnt(String bpId) {
		return dao.updateCnt(bpId);
	}
	
//	@Override
//	public int createAno(BoardPostVO vo) {
//		return dao.insertAno(vo);
//	}
	
	@Value("file:D:/saveFiles/")
	private Resource saveFolder;
	
	//파일 다운로드
		@Override
		public ResponseEntity<Resource> downloadFile(String bpFileId) throws IOException {
			BoardPostFileVO attach = dao.getAttach(bpFileId);
			String bpUuidName = attach.getBpUuidName();
			String bpOrgNm = attach.getBpOrgNm();
			Resource imageFile = saveFolder.createRelative(bpUuidName);
//			Content-Disposition: attachment; filename="filename.jpg"
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
	public int removeBoardPostFile(String bpFileId) throws IOException {
		BoardPostFileVO attach = dao.getAttach(bpFileId);
		String bpOrgNm = attach.getBpOrgNm();
		String bpUuidName = attach.getBpUuidName();
		Resource imageFile = saveFolder.createRelative(bpUuidName);
		File file = imageFile.getFile();
		int cnt=0;
		if(file.delete()) {
			 cnt+= dao.deleteFileSaveFile(bpFileId);
		}else {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND,String.format("%s 파일을 찾을 수 없음",bpOrgNm));
		}
		return cnt;
	}
}	
	
	
	
