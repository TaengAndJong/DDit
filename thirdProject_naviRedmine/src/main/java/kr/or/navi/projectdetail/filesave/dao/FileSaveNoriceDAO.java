package kr.or.navi.projectdetail.filesave.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.FileSaveFileVO;
import kr.or.navi.vo.FileSaveNoticeVO;
import kr.or.navi.vo.FileSaveVO;

@Mapper
public interface FileSaveNoriceDAO {
	public List<FileSaveNoticeVO> selectFileSaveNoiceList(@Param("paging") PaginationInfo paging,@Param("proId") String proId);
	public int selectTotalRecord(@Param("paging") PaginationInfo paging,@Param("proId")String proId);
	public FileSaveNoticeVO selectFileSaveNoriceOne(String fsnId);
	public int deleteFileSaveNotice(String fsnId);
	public int updateFileSaveNotice(FileSaveNoticeVO updateFs);
	public int insertFileSaveNotice(FileSaveNoticeVO insertFs);
	public FileSaveVO selectFileSave(String proId);
	public List<FileSaveFileVO> selectFileSaveFileList(String fsnId);
	public int insertFile(FileSaveFileVO file);
	public FileSaveFileVO selectFileSaveFile(String fsnId);
	public int deleteFileSaveFile(String fsnId);
}
