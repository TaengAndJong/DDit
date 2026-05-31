package kr.or.navi.board.photo.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.util.List;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.StreamUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

import kr.or.navi.board.photo.dao.PhotoDAO;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.BoardCommentVO;
import kr.or.navi.vo.BoardPostFileVO;
import kr.or.navi.vo.BoardPostVO;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class PhotoServiceImpl implements PhotoService {

	@Inject
	private PhotoDAO dao;
	
	@PostConstruct
	public void init() {
		log.info("saveFolder:{}",saveFolder);
	}

	@Override
	public List<BoardPostVO> retrieveAnoListBoard() {
		return dao.selectAnoListBoard();
	}
	
	@Override
	public List<BoardPostVO> retrievePhotoList(PaginationInfo paging) throws IOException {
		int totalRecord = dao.totalRecord(paging);
		paging.setTotalRecord(totalRecord);
		List<BoardPostVO> photoList = dao.selectPhotoList(paging);
		for(BoardPostVO vo : photoList) {
			log.info("bpvo : {}",vo);
			String bpUuidName = vo.getImgUuid();
			if(StringUtils.isNotBlank(bpUuidName)) {
				Resource imgFile = saveFolder.createRelative(bpUuidName);
				 try (InputStream inputStream = imgFile.getInputStream()) {
				 byte[] bytes = StreamUtils.copyToByteArray(inputStream);
				 vo.setImgData(bytes);
				 }
			}
		}
 		return photoList;
	}
//	public BoardPostFileVO retrieveImg(String bpId) {
//		return dao.selectImg(bpId);
//	}

	@Override
	public BoardPostVO retrievePhoto(String bpId) {
		return dao.selectPhoto(bpId);
	}

	@Override
	public int modifyPhoto(BoardPostVO vo) throws IOException {
		List<BoardPostFileVO> bpFileVoList = vo.getBpFileVoList();
		int cnt=0;
		for(BoardPostFileVO bpfVO : bpFileVoList) {
			MultipartFile bpAttchFile = bpfVO.getBpAttchFile();
			String uuid = saveToResource(bpAttchFile, saveFolder);
			bpfVO.setBpUuidName(uuid); 
			cnt+=dao.insertFile(bpfVO);
		}
		cnt+=dao.updatePhoto(vo);
		return cnt;
	}

	@Override
	public int removePhoto(String bpId) {
		return dao.deletePhoto(bpId);
	}
	
	@Override
	public int createPhoto(BoardPostVO vo) throws IOException {
		log.info("==>>saveFolder:{}",saveFolder);
		int cnt = dao.insertPhoto(vo);
		List<BoardPostFileVO> bpFileVoList = vo.getBpFileVoList();
		for(BoardPostFileVO bpfVO : bpFileVoList) {
			MultipartFile bpAttchFile = bpfVO.getBpAttchFile();
			String uuid = saveToResource(bpAttchFile, saveFolder);
			bpfVO.setBpUuidName(uuid); 
			bpfVO.setBpMainImgYn("N");
			cnt+= dao.insertFile(bpfVO);
		}
		if(vo.getBpImgVo().getBpAttchFile()!=null) {
			BoardPostFileVO bpfVO = vo.getBpImgVo();
			MultipartFile bpAttchFile = bpfVO.getBpAttchFile();
			String uuid = saveToResource(bpAttchFile, saveFolder);
			bpfVO.setBpUuidName(uuid); 
			bpfVO.setBpMainImgYn("Y");
			cnt+= dao.insertFile(bpfVO);
		}
		
		return cnt;
	}
	
	@Override
	public List<BoardPostFileVO> retrievePhotoFile(String bpId) {
		return dao.selectFile(bpId);
	}

	@Override
	public int viewCnt(String bpId) {
		return dao.updateCnt(bpId);
	}
	
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
		
		@Override
		public List<BoardCommentVO> retrieveBoardCommentList(String bpId) {
			return dao.selectBoardCommentList(bpId);
		}

		@Override
		public int removeBoardComment(String bcId) {
			return dao.deleteBoardComment(bcId);
		}

		@Override
		public int createBoardComment(BoardCommentVO boardComment) {
			return dao.insertBoardComment(boardComment);
		}
		
}

