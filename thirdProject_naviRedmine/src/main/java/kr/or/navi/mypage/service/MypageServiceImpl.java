package kr.or.navi.mypage.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.enumpkg.ServiceResult;
import kr.or.navi.mapper.dao.EmpDAO;
import kr.or.navi.mypage.dao.MypageDAO;
import kr.or.navi.vo.BoardPostVO;
import kr.or.navi.vo.BookmarkBoardVO;
import kr.or.navi.vo.BookmarkIssueVO;
import kr.or.navi.vo.BookmarkVO;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.IssueVO;
import kr.or.navi.vo.ProjectVO;

@Service
public class MypageServiceImpl implements MypageService {
	
	@Inject
	private EmpDAO dao;
	
	@Inject
	private MypageDAO mdao;
	
	/**
	 * 개인정보 수정
	 * @throws IOException 
	 */
	public ServiceResult modifyEmp(EmpVO vo) throws IOException {
		MultipartFile bpAttchFile = vo.getBpAttchFile();
		String uuid = null;
		if(bpAttchFile!=null) {
			 uuid = saveToResource(bpAttchFile, saveFolder);
		}
		ServiceResult result = null;
		result = mdao.updateEmp(vo) > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}
	@Value("file:D:/saveFiles/")
	private Resource saveFolder;
	private String saveToResource(MultipartFile single, Resource saveFolder) throws IOException {
		String saveName = UUID.randomUUID().toString(); //겹치지 않는 걸로 만들어주기 위해 random으로 생성
		Resource saveFileRes = saveFolder.createRelative(saveName);
		File saveFile = saveFileRes.getFile(); //저장을 하기 위해선 File로 변환
		try(
				InputStream is = single.getInputStream();
				){
			FileUtils.copyInputStreamToFile(is, saveFile); //저장
		}
		return saveName;
	}
	/**
	 * 개인정보 조회
	 */
	@Override
	public EmpVO selectOne(String empId) {
		return dao.selectOne(empId);
	}
	
	/**
	 * 나의 프로젝트 리스트
	 */
	@Override
	public List<ProjectVO> myProjectList(String empId, PaginationInfo paging) {
	    int totalRecord = mdao.selectTotalRecordProject(empId, paging);
	    paging.setTotalRecord(totalRecord);
	    List<ProjectVO> projectList = mdao.myProjectList(empId, paging);

	    // 프로젝트 리스트를 순회하면서 proDdlineYn이 "Y"인 경우 "마감"으로 변경합니다.
	    for (ProjectVO project : projectList) {
	        if ("Y".equals(project.getProDdlineYn())) {
	            project.setProDdlineYn("마감");
	        }
	    }

	    return projectList;
	}

	/**
	 * 나의 이슈 리스트
	 */
	@Override
	public List<IssueVO> myIssueList(String empId, PaginationInfo paging) {
		int totalRecord = mdao.selectTotalRecordIssue(empId, paging);
		paging.setTotalRecord(totalRecord);
		return mdao.myIssueList(empId, paging);
	}

	/**
	 * 나의 커뮤니티 리스트
	 */
	@Override
	public List<BoardPostVO> myBoardList(String empId, PaginationInfo paging) {
		int totalRecord = mdao.selectTotalRecordBoard(empId, paging);
		paging.setTotalRecord(totalRecord);
		return mdao.myBoardList(empId, paging);
	}
	
	public List<BookmarkVO> bookmarkList(String empId, PaginationInfo paging) {
		int totalRecord = mdao.selectTotalRecord(empId, paging);
		paging.setTotalRecord(totalRecord);
		return mdao.bookmarkList(empId, paging);
	}

	@Override
	public int createIssueBookmark(BookmarkIssueVO insertVO) {
		String empId = insertVO.getEmpId();
		String issueId = insertVO.getIssueId();
		BookmarkIssueVO authVO = mdao.selectBookMarkIssueVO(issueId, empId);
		if(authVO!=null && insertVO.equals(authVO)) {
			//있으면
			LocalDateTime biDelDt = authVO.getBiDelDt();
			if(biDelDt==null) {
				return mdao.updateBookMarkIssue(issueId, empId, "SYSTIMESTAMP");
			}else {
				return mdao.updateBookMarkIssue(issueId, empId, "NULL");
			}
		}else {
			//없으면
			return mdao.insertBookmarkIssue(insertVO);
		}
	}

	@Override
	public List<BookmarkIssueVO> retriveBookMarkIssueList(String empId,String proId) {
		return mdao.selectMyBookMarkIssueList(empId, proId);
	}

	@Override
	public int removeBookMarkIssue(String empId, String issueId) {
		return mdao.updateBookMarkIssue(issueId, empId, "SYSTIMESTAMP");
	}
	
	@Override
	public int createBoardBookmark(BookmarkBoardVO insertVO) {
		String empId = insertVO.getEmpId();
		String bpId = insertVO.getBpId();
		BookmarkBoardVO authVO = mdao.selectBookMarkBoardVO(bpId, empId);
		if(authVO!=null && insertVO.equals(authVO)) {
			LocalDateTime bbDelDt = authVO.getBbDelDt();
			if(bbDelDt == null) {
				return mdao.updateBookMarkBoard(bpId, empId, "SYSTIMESTAMP");
			}else {
				return mdao.updateBookMarkBoard(bpId, empId, "NULL");
			}
		}else {
			return mdao.insertBoardBookmark(insertVO);
		}
	}
	
	@Override
	public List<BookmarkBoardVO> retriveBookMarkBoardList(String empId) {
		return mdao.selectMyBookMarkBoardList(empId);
	}
	
	@Override
	public int removeBookMarkBoard(String bpId, String empId) {
		return mdao.updateBookMarkBoard(bpId, empId, "SYSTIMESTAMP");
	}
}