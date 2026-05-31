package kr.or.navi.common.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.navi.vo.CommonVO;
import kr.or.navi.vo.QnaStateVO;
import kr.or.navi.vo.ShareStatVO;

@Mapper
public interface CommonDAO {
	public List<CommonVO> selectProjectStateList();
	public List<CommonVO> selectIssueStateList();
	public List<CommonVO> selectIssueImportStateList();
	public List<CommonVO> selectBoardTypeList();
	public List<ShareStatVO> selectShareStateList();
	public List<QnaStateVO> selectQnaStateList();
	public CommonVO selectOne(String cmId);
}
