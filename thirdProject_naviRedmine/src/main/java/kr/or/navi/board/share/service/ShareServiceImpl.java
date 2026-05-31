package kr.or.navi.board.share.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.util.List;
import java.util.Map;
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

import kr.or.navi.board.share.dao.ShareDAO;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.BoardCommentVO;
import kr.or.navi.vo.BoardPostFileVO;
import kr.or.navi.vo.BoardPostVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ShareServiceImpl implements ShareService {

	@Inject
	private ShareDAO dao;

	@PostConstruct
	public void init() {
		log.info("saveFolder:{}", saveFolder);
	}

	/**
	 * 공지사항 나눔게시판에 띄우기
	 */
	@Override
	public List<BoardPostVO> retrieveAnoListBoard() {
		return dao.selectAnoListBoard();
	}

	/**
	 * 나눔게시판 목록조회
	 */
	@Override
	public List<BoardPostVO> retrieveShareList(PaginationInfo paging) {
		int totalRecord = dao.totalRecord(paging);
		paging.setTotalRecord(totalRecord);
		return dao.selectShareList(paging);
	}

	/**
	 * 나눔게시판 단건조회
	 */
	@Override
	public BoardPostVO retrieveShare(String bpId) {
		return dao.selectShare(bpId);
	}

	/**
	 * 나눔게시판 수정
	 */
	@Override
	public int modifyShare(BoardPostVO vo) throws IOException {
		List<BoardPostFileVO> bpFileVoList = vo.getBpFileVoList();
		int cnt = 0;
		for (BoardPostFileVO bpfVO : bpFileVoList) {
			MultipartFile bpAttchFile = bpfVO.getBpAttchFile();
			String uuid = saveToResource(bpAttchFile, saveFolder);
			bpfVO.setBpUuidName(uuid);
			cnt += dao.insertFile(bpfVO);
		}
		cnt += dao.updateShare(vo);
		return cnt;
	}

	/**
	 * 나눔게시판 삭제
	 */
	@Override
	public int removeShare(String bpId) {
		return dao.deleteShare(bpId);
	}

	/**
	 * 나눔게시판 등록
	 */
	@Override
	public int createShare(BoardPostVO vo) throws IOException {
		log.info("==>>saveFolder:{}", saveFolder);
		int cnt = dao.insertShare(vo);
		List<BoardPostFileVO> bpFileVoList = vo.getBpFileVoList();
		for (BoardPostFileVO bpfVO : bpFileVoList) {
			MultipartFile bpAttchFile = bpfVO.getBpAttchFile();
			String uuid = saveToResource(bpAttchFile, saveFolder);
			bpfVO.setBpUuidName(uuid);
			cnt += dao.insertFile(bpfVO);
		}
		return cnt;
	}

	/**
	 * 나눔게시판 파일 조회
	 */
	@Override
	public List<BoardPostFileVO> retrieveShareFile(String bpId) {
		return dao.selectFile(bpId);
	}

	/**
	 * 나눔게시판 조회수
	 */
	@Override
	public int viewCnt(String bpId) {
		return dao.updateCnt(bpId);
	}

	/**
	 * 파일 저장 경로
	 */
	@Value("file:D:/saveFiles/")
	private Resource saveFolder;

	
	/**
	 * 파일 다운로드
	 */
	@Override
	public ResponseEntity<Resource> downloadFile(String bpFileId) throws IOException {
		BoardPostFileVO attach = dao.getAttach(bpFileId);
		String bpUuidName = attach.getBpUuidName();
		String bpOrgNm = attach.getBpOrgNm();
		Resource imageFile = saveFolder.createRelative(bpUuidName);
//			Content-Disposition: attachment; filename="filename.jpg"
		if (!imageFile.exists()) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, String.format("%s 파일을 찾을 수 없음", bpOrgNm));
		}
		HttpHeaders headers = new HttpHeaders();
		headers.setContentLength(imageFile.contentLength());
		ContentDisposition disposition = ContentDisposition.attachment().filename(bpOrgNm, Charset.forName("UTF-8"))
				.build();
		headers.setContentDisposition(disposition);
		return ResponseEntity.ok().headers(headers).body(imageFile);
	}

	/**
	 * 파일 uuid 만들기
	 * @param single
	 * @param saveFolder
	 * @return saveName
	 * @throws IOException
	 */
	private String saveToResource(MultipartFile single, Resource saveFolder) throws IOException {
		String saveName = UUID.randomUUID().toString(); // 겹치지 않는 걸로 만들어주기 위해 random으로 생성
		Resource saveFileRes = saveFolder.createRelative(saveName);
		File saveFile = saveFileRes.getFile(); // 저장을 하기 위해선 File로 변환
		try (InputStream is = single.getInputStream();) {
			FileUtils.copyInputStreamToFile(is, saveFile); // 저장
		}
		return saveName;
	}

	/**
	 * 파일 삭제
	 */
	@Override
	public int removeBoardPostFile(String bpFileId) throws IOException {
		BoardPostFileVO attach = dao.getAttach(bpFileId);
		String bpOrgNm = attach.getBpOrgNm();
		String bpUuidName = attach.getBpUuidName();
		Resource imageFile = saveFolder.createRelative(bpUuidName);
		File file = imageFile.getFile();
		int cnt = 0;
		if (file.delete()) {
			cnt += dao.deleteFileSaveFile(bpFileId);
		} else {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, String.format("%s 파일을 찾을 수 없음", bpOrgNm));
		}
		return cnt;
	}

	/**
	 * 댓글목록 조회
	 */
	@Override
	public List<BoardCommentVO> retrieveBoardCommentList(String bpId) {
		return dao.selectBoardCommentList(bpId);
	}

	/**
	 * 댓글 삭제
	 */
	@Override
	public int removeBoardComment(String bcId) {
		return dao.deleteBoardComment(bcId);
	}

	/**
	 * 댓글 등록
	 */
	@Override
	public int createBoardComment(BoardCommentVO boardComment) {
		return dao.insertBoardComment(boardComment);
	}

	/**
	 * 나눔상태 갯수 조회
	 */
	@Override
	public  Map<String, Integer> shareCntTotal() {
		return dao.shareCntTotal();
	}

}
