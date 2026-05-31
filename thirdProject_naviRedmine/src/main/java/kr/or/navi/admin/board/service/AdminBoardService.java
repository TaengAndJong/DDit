package kr.or.navi.admin.board.service;

import java.util.List;

import kr.or.navi.vo.BoardPostVO;

public interface AdminBoardService {

	public int boardCheckedDelete(List<BoardPostVO> board);
}
