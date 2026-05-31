package kr.or.navi.board.ano.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.BoardPostFileVO;
import kr.or.navi.vo.BoardPostVO;

@Mapper
public interface AnoDAO {
	public List<BoardPostVO> selectAnoMainList();//메인데이터
	public List<BoardPostVO> selectAnoList(PaginationInfo paging);
	public int totalRecord(PaginationInfo paging);
	public BoardPostVO selectAno(@Param("bpId") String bpId);
	public int updateAno(@Param("vo") BoardPostVO vo); //,@Param("empId") String empId
	public int deleteAno(@Param("bpId") String bpId);
	public int insertAno(BoardPostVO vo);
	
	public int insertFile(BoardPostFileVO fvo);
	
	public List<BoardPostFileVO> selectFile(@Param("bpId") String bpId);
	public int updateCnt(@Param("bpId") String bpId);
	public BoardPostFileVO getAttach(@Param("bpFileId") String bpFileId);
	public int deleteFileSaveFile(String bpFileId);
}
