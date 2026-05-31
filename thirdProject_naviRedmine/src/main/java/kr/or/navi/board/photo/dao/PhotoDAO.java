package kr.or.navi.board.photo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.BoardCommentVO;
import kr.or.navi.vo.BoardPostFileVO;
import kr.or.navi.vo.BoardPostVO;
import kr.or.navi.vo.EmpVO;

@Mapper
public interface PhotoDAO {
	
	/**
	 * 포토게시판 공지 목록 조회
	 * @return
	 */
	public List<BoardPostVO> selectAnoListBoard();
	
	/**
	 * 포토게시판 목록 조회
	 * @param paging
	 * @return
	 */
	public List<BoardPostVO> selectPhotoList(PaginationInfo paging);
	
	/**
	 * 포토게시판 목록 갯수 조회
	 * @param paging
	 * @return
	 */
	public int totalRecord(PaginationInfo paging);
	
	/**
	 * 포토게시글 단건 조회
	 * @param bpId
	 * @return
	 */
	public BoardPostVO selectPhoto(@Param("bpId") String bpId);
	
	/**
	 * 포토게시판 수정
	 * @param vo
	 * @return
	 */
	public int updatePhoto(@Param("vo") BoardPostVO vo);
	
	/**
	 * 포토게시판 삭제
	 * @param bpId
	 * @return
	 */
	public int deletePhoto(@Param("bpId") String bpId);
	
	/**
	 * 포토게시판 등록
	 * @param vo
	 * @return
	 */
	public int insertPhoto(BoardPostVO vo);
	
	/**
	 * 파일 등록
	 * @param fvo
	 * @return
	 */
	public int insertFile(BoardPostFileVO fvo);
	
	/**
	 * 섬네일 이미지 조회
	 * @param bpId
	 * @return
	 */
	public BoardPostFileVO selectImg(@Param("bpId") String bpId);
	
	/**
	 * 파일 목록 조회
	 * @param bpId
	 * @return
	 */
	public List<BoardPostFileVO> selectFile(@Param("bpId") String bpId); //파일 가져오는 쿼리
	
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
	
	/**
	 * 섬네일 이미지 조회
	 * @param bpId
	 * @return
	 */
	public BoardPostFileVO getBoardImgFile(@Param("bpId") String bpId);
	
}
