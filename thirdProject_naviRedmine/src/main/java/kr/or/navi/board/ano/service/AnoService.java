package kr.or.navi.board.ano.service;

import java.io.IOException;
import java.util.List;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.BoardPostFileVO;
import kr.or.navi.vo.BoardPostVO;

public interface AnoService {
	public List<BoardPostVO> retrieveAnoMainList();//메인데이터
	public List<BoardPostVO> retrieveAnoList(PaginationInfo paging);
	public BoardPostVO retrieveAno(String bpId);
	public int modifyAno(BoardPostVO vo) throws IOException; //,String empId
	public int removeAno(String bpId);
	public int createAno(BoardPostVO vo) throws IOException;
	
	public List<BoardPostFileVO> retrieveAnoFile(String bpId);
	public int viewCnt(String bpId);
	public ResponseEntity<Resource> downloadFile(String bpFileId) throws IOException;
	public int removeBoardPostFile(String bpFileId) throws IOException;
}
