package kr.or.navi.board.photo.service;

import java.io.IOException;
import java.util.List;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.BoardCommentVO;
import kr.or.navi.vo.BoardPostFileVO;
import kr.or.navi.vo.BoardPostVO;

public interface PhotoService {
	
	/**
	 * 
	 * @return
	 */
	public List<BoardPostVO> retrieveAnoListBoard();
	
	public List<BoardPostVO> retrievePhotoList(PaginationInfo paging) throws IOException;
	
	public BoardPostVO retrievePhoto(String bpId);
	
	public int modifyPhoto(BoardPostVO vo) throws IOException;
	
	public int removePhoto(String bpId);
	
	public int createPhoto(BoardPostVO vo) throws IOException;

//	public BoardPostFileVO retrieveImg(String bpId);
	
	
	public List<BoardPostFileVO> retrievePhotoFile(String bpId);
	
	public int viewCnt(String bpId);
	
	public ResponseEntity<Resource> downloadFile(String bpFileId) throws IOException;
	
	public int removeBoardPostFile(String bpFileId) throws IOException;
	
	//댓글관련 service methods
	
	public List<BoardCommentVO> retrieveBoardCommentList(String bpId);
	
	public int removeBoardComment(String bcId);
	
	public int createBoardComment(BoardCommentVO boardComment);
}
