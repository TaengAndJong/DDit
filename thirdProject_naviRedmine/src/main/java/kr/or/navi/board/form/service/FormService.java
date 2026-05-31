package kr.or.navi.board.form.service;

import java.io.IOException;
import java.util.List;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.BoardPostFileVO;
import kr.or.navi.vo.BoardPostVO;

public interface FormService {
	
	public List<BoardPostVO> retrieveAnoListBoard();
	
	public List<BoardPostVO> retrieveFormList(PaginationInfo paging);
	public BoardPostVO retrieveForm(String bpId);
//	public int formModify(BoardPostVO form);
	public int modifyForm(BoardPostVO updateBp) throws IOException;
	public int removeForm(String bpId);
	public int createForm(BoardPostVO insertBp) throws IOException;
	
	public List<BoardPostFileVO> retrieveFormFile(String bpId);
	public int viewCnt(String bpId);
	public ResponseEntity<Resource> downloadFile(String bpFileId) throws IOException;
	public int removeBoardPostFile(String bpFileId) throws IOException;
}
