package kr.or.navi.admin.board.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.navi.admin.board.dao.AdminBoardDAO;
import kr.or.navi.vo.BoardPostVO;

@Service
public class AdminBoardServiceImpl implements AdminBoardService {
	@Inject
	private AdminBoardDAO adminBoardDao;

	@Override
	public int boardCheckedDelete(List<BoardPostVO> board) {
		return adminBoardDao.deleteCheckedProject(board);
	}

}
