package kr.or.navi.board.qna.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.BoardPostVO;

@Mapper
public interface QnaDAO {
	
	public List<BoardPostVO> selectAnoListBoard();
	
	public List<BoardPostVO> selectQnaList(PaginationInfo paging);
	public int totalRecord(PaginationInfo paging);
	public List<BoardPostVO> selectFqaList(PaginationInfo paging);
	public int faqTotalRecord(PaginationInfo paging);
	public BoardPostVO selectQna(String bpId);
	public int updateQna(@Param("vo") BoardPostVO vo);
	public int deleteQna(@Param("bpId") String bpId);
	public int insertQna(BoardPostVO vo);
	public int updateAnswerQna(@Param("vo") BoardPostVO vo);
	public int updateCnt(@Param("bpId") String bpId);
	
	public Map<String, Integer> qnaCntTotal();
	
}
