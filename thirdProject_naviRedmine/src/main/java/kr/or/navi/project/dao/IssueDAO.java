package kr.or.navi.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.IssueCommentVO;
import kr.or.navi.vo.IssueFileVO;
import kr.or.navi.vo.IssueVO;

@Mapper
public interface IssueDAO {
	public IssueVO selectIssue(@Param("issueId") String issueId);
	public List<IssueVO> selectIssueList(@Param("proId") String proId,@Param("paging") PaginationInfo paging);
	public int selectTotalRecord(@Param("proId1") String proId,@Param("paging") PaginationInfo paging);
	public int deleteIssue(@Param("issueId") String issueId);
	public int updateIssue(IssueVO issue);
	public int insertIssue(IssueVO issue);
	public int insertFile(IssueFileVO issueFile);
	
	public List<IssueCommentVO> selectIssueCommentList(String issueId);
	public int deleteIssueComment(String icId);
	public int insertIssueComment(IssueCommentVO issueComment);
	
	
	public List<IssueFileVO> selectIssueFileList(String issueId);
	public IssueFileVO selectIssueFile(String issfId);
	public int deleteIssueFile(String issfId);
}
