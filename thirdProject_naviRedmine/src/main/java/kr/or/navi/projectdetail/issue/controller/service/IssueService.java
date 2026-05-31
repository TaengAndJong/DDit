package kr.or.navi.projectdetail.issue.controller.service;

import java.io.IOException;
import java.util.List;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;

import kr.or.navi.vo.IssueCommentVO;
import kr.or.navi.vo.IssueFileVO;
import kr.or.navi.vo.IssueVO;

public interface IssueService {
	public IssueVO selectIssueOne(String issueId);
	public int removeIssue(String issueId);
	public int modifyIssue(IssueVO issue) throws IOException;
	public int createIssue(IssueVO issue) throws IOException;
	public List<IssueCommentVO> retrieveIssueCommentList(String issueId);
	public int removeIssueComment(String icId);
	public int createIssueComment(IssueCommentVO issueComment);
	public List<IssueFileVO> retriveFileList(String issueId);
	public ResponseEntity<Resource> downloadFile(String issfId) throws IOException;
	public int removeIssueFile(String issfId) throws IOException;
}
