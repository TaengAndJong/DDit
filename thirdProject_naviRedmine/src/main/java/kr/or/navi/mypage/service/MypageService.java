package kr.or.navi.mypage.service;

import java.io.IOException;
import java.util.List;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.enumpkg.ServiceResult;
import kr.or.navi.vo.BoardPostVO;
import kr.or.navi.vo.BookmarkBoardVO;
import kr.or.navi.vo.BookmarkIssueVO;
import kr.or.navi.vo.BookmarkVO;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.IssueVO;
import kr.or.navi.vo.ProjectVO;

public interface MypageService {
	
	// 직원의 정보를 조회하는 메서드
	public EmpVO selectOne(String empId);

	// 직원 정보를 수정하는 메서드
	public ServiceResult modifyEmp(EmpVO vo) throws IOException;

	// 특정 직원이 참여한 프로젝트 목록을 페이징하여 반환하는 메서드
	public List<ProjectVO> myProjectList(String empId, PaginationInfo paging);
	// 특정 직원이 관련된 이슈 목록을 페이징하여 반환하는 메서드
	public List<IssueVO> myIssueList(String empId, PaginationInfo paging);
	// 특정 직원이 작성한 게시글 목록을 페이징하여 반환하는 메서드
	public List<BoardPostVO> myBoardList(String empId, PaginationInfo paging);
	
	// 특정 직원이 북마크한 목록을 페이징하여 반환하는 메서드
	public List<BookmarkVO> bookmarkList(String empId, PaginationInfo paging);

	// 이슈에 북마크를 생성하는 메서드
	public int createIssueBookmark(BookmarkIssueVO insertVO);
	// 특정 직원이 특정 프로젝트의 북마크된 이슈 목록을 반환하는 메서드
	public List<BookmarkIssueVO> retriveBookMarkIssueList(String empId, String proId);
	// 이슈 북마크를 제거하는 메서드
	public int removeBookMarkIssue(String empId, String issueId);

	// 게시글에 북마크를 생성하는 메서드
	public int createBoardBookmark(BookmarkBoardVO insertVO);
	// 특정 직원이 북마크한 게시글 목록을 반환하는 메서드
	public List<BookmarkBoardVO> retriveBookMarkBoardList(String empId);
	// 게시글 북마크를 제거하는 메서드
	public int removeBookMarkBoard(String bpId, String empId);
	
}
