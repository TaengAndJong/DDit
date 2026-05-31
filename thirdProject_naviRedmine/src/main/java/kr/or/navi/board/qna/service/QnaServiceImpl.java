package kr.or.navi.board.qna.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.navi.board.qna.dao.QnaDAO;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.BoardPostVO;

@Service
public class QnaServiceImpl implements QnaService{
	
	@Inject
	private QnaDAO dao;

	@Override
	public List<BoardPostVO> retrieveAnoListBoard() {
		return dao.selectAnoListBoard();
	}
	
	@Override
	public List<BoardPostVO> retrieveQnaList(PaginationInfo paging) {
		int totalRecord = dao.totalRecord(paging);
		paging.setTotalRecord(totalRecord);
		return dao.selectQnaList(paging);
	}
	
	public List<BoardPostVO> retrieveFaqList(PaginationInfo paging) {
		int totalRecord = dao.faqTotalRecord(paging);
		paging.setTotalRecord(totalRecord);
		return dao.selectFqaList(paging);
	}

	@Override
	public BoardPostVO retrieveQna(String bpId) {
		return dao.selectQna(bpId);
	}

	@Override
	public int modifyQna(BoardPostVO vo) {
		return dao.updateQna(vo);
	}

	@Override
	public int removeQna(String bpId) {
		return dao.deleteQna(bpId);
	}

	@Override
	public int createQna(BoardPostVO vo) {
		return dao.insertQna(vo);
	}

	@Override
	public int modifyAnswerQna(BoardPostVO vo) {
		return dao.updateAnswerQna(vo);
	}
	
	@Override
	public int viewCnt(String bpId) {
		return dao.updateCnt(bpId);
	}

	@Override
	public Map<String, Integer> qnaCntTotal() {
		return dao.qnaCntTotal();
	}

}
