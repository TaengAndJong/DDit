package kr.or.navi.board.share.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.BoardCommentVO;
import kr.or.navi.vo.BoardPostFileVO;
import kr.or.navi.vo.BoardPostVO;

public interface ShareService {
	
	/**
	 * 나눔게시판 공지목록 조회
	 * @return
	 */
	public List<BoardPostVO> retrieveAnoListBoard();

	/**
	 * 나눔게시판 목록 조회
	 * @param paging
	 * @return
	 */
	public List<BoardPostVO> retrieveShareList(PaginationInfo paging);
	
	/**
	 * 나눔 게시글 단건 조회
	 * @param bpId
	 * @return
	 */
	public BoardPostVO retrieveShare(String bpId);
	
	/**
	 * 나눔게시판 수정
	 * @param vo
	 * @return
	 * @throws IOException
	 */
	public int modifyShare(BoardPostVO vo) throws IOException;
	
	/**
	 * 나눔게시판 삭제
	 * @param bpId
	 * @return
	 */
	public int removeShare(String bpId);
	
	/**
	 * 나눔게시판 등록
	 * @param vo
	 * @return
	 * @throws IOException
	 */
	public int createShare(BoardPostVO vo) throws IOException;
	
	/**
	 * 나눔게시판 파일 조회
	 * @param bpId
	 * @return
	 */
	public List<BoardPostFileVO> retrieveShareFile(String bpId);
	
	/**
	 * 조회수
	 * @param bpId
	 * @return
	 */
	public int viewCnt(String bpId);
	
	/**
	 * 파일 다운로드
	 * @param bpFileId
	 * @return
	 * @throws IOException
	 */
	public ResponseEntity<Resource> downloadFile(String bpFileId) throws IOException;
	
	/**
	 * 업로드 파일 삭제
	 * @param bpFileId
	 * @return
	 * @throws IOException
	 */
	public int removeBoardPostFile(String bpFileId) throws IOException;
	
//	public BoardPostFileVO getAttach(String atchNo);
	
	/**
	 * 나눔상태 갯수 조회
	 * @return
	 */
	public  Map<String, Integer> shareCntTotal();
	
	
	//댓글관련 service methods
	/**
	 * 댓글 목록 조회
	 * @param bpId
	 * @return
	 */
	public List<BoardCommentVO> retrieveBoardCommentList(String bpId);
	
	/**
	 * 댓글 삭제
	 * @param bcId
	 * @return
	 */
	public int removeBoardComment(String bcId);
	
	/**
	 * 댓글 등록
	 * @param boardComment
	 * @return
	 */
	public int createBoardComment(BoardCommentVO boardComment);
}
