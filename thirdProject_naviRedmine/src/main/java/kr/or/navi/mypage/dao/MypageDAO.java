package kr.or.navi.mypage.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.BoardPostVO;
import kr.or.navi.vo.BookmarkBoardVO;
import kr.or.navi.vo.BookmarkIssueVO;
import kr.or.navi.vo.BookmarkVO;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.IssueVO;
import kr.or.navi.vo.ProjectVO;

@Mapper
public interface MypageDAO {
	
	// MyProjectList
    public List<ProjectVO> myProjectList(@Param("empId") String empId, @Param("paging") PaginationInfo paging);
    public int selectTotalRecordProject(@Param("empId") String empId, @Param("paging") PaginationInfo paging);
    
    // MyIssueList
    public List<IssueVO> myIssueList(@Param("empId") String empId, @Param("paging") PaginationInfo paging);
    public int selectTotalRecordIssue(@Param("empId") String empId, @Param("paging") PaginationInfo paging);
    
    // MyBoardList
    public List<BoardPostVO> myBoardList(@Param("empId") String empId, @Param("paging") PaginationInfo paging);
    public int selectTotalRecordBoard(@Param("empId") String empId, @Param("paging") PaginationInfo paging);
    
    // BookmarkList
    public List<BookmarkVO> bookmarkList(@Param("empId") String empId, @Param("paging") PaginationInfo paging);
    public int selectTotalRecord(@Param("empId") String empId, @Param("paging") PaginationInfo paging);
    
    // Issue insert
    public int insertBookmarkIssue(BookmarkIssueVO insertVO);
    // 검증 조회
    public BookmarkIssueVO selectBookMarkIssueVO(@Param("issueId") String issueId, @Param("empId")String empId);
    // 북마크 삭제
    public int updateBookMarkIssue(@Param("issueId") String issueId, @Param("empId")String empId, @Param("text") String text);    
    // 내 이슈 북마크 조회
    public List<BookmarkIssueVO> selectMyBookMarkIssueList(@Param("empId")String empId, @Param("proId")String proId);
    
    // Board insert
    public int insertBoardBookmark(BookmarkBoardVO insertVO);
    // 검증 조회
    public BookmarkBoardVO selectBookMarkBoardVO(@Param("bpId") String bpId, @Param("empId")String empId);
    // 북마크 삭제
    public int updateBookMarkBoard(@Param("bpId") String bpId, @Param("empId")String empId, @Param("text") String text);      
    // 내 커뮤니티 북마크 조회
    public List<BookmarkBoardVO> selectMyBookMarkBoardList(@Param("empId")String empId);
    
    // MyPage
	public int updateEmp(EmpVO vo);
	
	//IMG
}
