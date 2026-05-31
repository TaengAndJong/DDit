package kr.or.navi.board.share.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.BoardCommentVO;
import kr.or.navi.vo.BoardPostFileVO;
import kr.or.navi.vo.BoardPostVO;

@Mapper
public interface ShareDAO {
	
	/**
	 * 나눔게시판 공지목록 조회
	 * @return
	 */
	public List<BoardPostVO> selectAnoListBoard();
	
	/**
	 * 나눔게시판 목록 조회
	 * @param paging
	 * @return
	 */
	public List<BoardPostVO> selectShareList(PaginationInfo paging);
	
	/**
	 * 페이징처리 목록 갯수 조회
	 * @param paging
	 * @return
	 */
	public int totalRecord(PaginationInfo paging);
	
	/**
	 * 나눔게시글 단건 조회
	 * @param bpId
	 * @return
	 */
	public BoardPostVO selectShare(@Param("bpId") String bpId);
	
	/**
	 * 나눔게시판 수정
	 * @param vo
	 * @return
	 */
	public int updateShare(@Param("vo")BoardPostVO vo);
	
	/**
	 * 나눔게시판 삭제
	 * @param bpId
	 * @return
	 */
	public int deleteShare(@Param("bpId") String bpId);
	
	/**
	 * 나눔게시판 등록
	 * @param vo
	 * @return
	 */
	public int insertShare(BoardPostVO vo);
	
	/**
	 * 파일 업로드
	 * @param fvo
	 * @return
	 */
	public int insertFile(BoardPostFileVO fvo);
	
	/** 
	 * 파일 목록 조회
	 * @param bpId
	 * @return
	 */
	public List<BoardPostFileVO> selectFile(@Param("bpId") String bpId);
	
	/**
	 * 조회수 증가
	 * @param bpId
	 * @return
	 */
	public int updateCnt(@Param("bpId") String bpId);
	
	/**
	 * 
	 * @param bpFileId
	 * @return
	 */
	public BoardPostFileVO getAttach(@Param("bpFileId") String bpFileId);
	
	/**
	 * 업로드 파일 삭제
	 * @param bpFileId
	 * @return
	 */
	public int deleteFileSaveFile(String bpFileId);
	
	/**
	 * 댓글 목록 조회
	 * @param bpId
	 * @return
	 */
	public List<BoardCommentVO> selectBoardCommentList(String bpId);
	
	/**
	 * 댓글 삭제
	 * @param bcId
	 * @return
	 */
	public int deleteBoardComment(String bcId);
	
	/**
	 * 댓글 등록
	 * @param boardComment
	 * @return
	 */
	public int insertBoardComment(BoardCommentVO boardComment);
	
	/**
	 * 나눔상태 갯수
	 * @return
	 */
	public Map<String, Integer> shareCntTotal();
}
