package kr.or.navi.board.form.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.BoardPostFileVO;
import kr.or.navi.vo.BoardPostVO;

@Mapper
public interface FormDAO {
	
	public List<BoardPostVO> selectAnoListBoard();
	
	public List<BoardPostVO> selectFormList(PaginationInfo paging);
	public int selectTotalRecord(PaginationInfo paging);
	public BoardPostVO selectForm(String bpId);
//이건뭘까	
	public int updateForm(@Param("vo")BoardPostVO form);
//이건뭘까	
	public int updateDetailForm(BoardPostVO updateBp);

	public int deleteForm(@Param("bpId") String bpId);
	public int insertForm(BoardPostVO insertBp);
	
	public int insertFile(BoardPostFileVO fvo);
	public List<BoardPostFileVO> selectFile(@Param("bpId") String bpId);
	public int updateCnt(@Param("bpId") String bpId);
	public BoardPostFileVO getAttach(@Param("bpFileId") String bpFileId);
	public int deleteFileSaveFile(String bpFileId);
}
