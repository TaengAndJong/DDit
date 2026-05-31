package kr.or.navi.board.prais.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.BoardCommentVO;
import kr.or.navi.vo.BoardPostFileVO;
import kr.or.navi.vo.BoardPostVO;

@Mapper
public interface PraisDAO {
	
	/**
	 * 칭찬 게시판 공지 목록 조회
	 * @return
	 */
	public List<BoardPostVO> selectAnoListBoard();
	
	/**
	 * 칭찬 게시판 목록 조회
	 * @param paging
	 * @return
	 */
	public List<BoardPostVO> selectPraisList(PaginationInfo paging);
	
	/**
	 * 페이징 처리 칭찬 게시글 갯수 조회
	 * @param paging
	 * @return
	 */
	public int totalRecord(PaginationInfo paging);
	
	/**
	 * 칭찬게시글 단건 조회
	 * @param bpId
	 * @return
	 */
	public BoardPostVO selectPrais(@Param ("bpId") String bpId);
	
	/**
	 * 칭찬게시판 수정
	 * @param vo
	 * @return
	 */
	public int updatePrais(@Param("vo") BoardPostVO vo);
	
	/**
	 * 칭찬게시판 삭제
	 * @param bpId
	 * @return
	 */
	public int deletePrais(@Param("bpId") String bpId);
	
	/**
	 * 칭찬게시판 등록
	 * @param vo
	 * @return
	 */
	public int insertPrais(BoardPostVO vo);
	
	/**
	 * 파일 등록
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
	 * 파일 다운로드
	 * @param bpFileId
	 * @return
	 */
	public BoardPostFileVO getAttach(@Param("bpFileId") String bpFileId);
	
	/**
	 * 파일 업로드 삭제
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
}
