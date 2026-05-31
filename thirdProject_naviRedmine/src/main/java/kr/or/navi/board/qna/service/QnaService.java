package kr.or.navi.board.qna.service;

import java.util.List;
import java.util.Map;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.BoardPostVO;

public interface QnaService {
	
	public List<BoardPostVO> retrieveAnoListBoard();
	
	public List<BoardPostVO> retrieveQnaList(PaginationInfo paging);
	public List<BoardPostVO> retrieveFaqList(PaginationInfo paging);
	public BoardPostVO retrieveQna(String bpId);
	public int modifyQna(BoardPostVO vo);
	public int removeQna(String bpId);
	public int createQna(BoardPostVO vo);
	public int modifyAnswerQna(BoardPostVO vo);
	public int viewCnt(String bpId);
	
	public  Map<String, Integer> qnaCntTotal();
}
