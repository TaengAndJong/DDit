package kr.or.navi.project.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import javax.inject.Inject;

import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.IssueCommentVO;
import kr.or.navi.vo.IssueVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
class IssueDAOTest extends AbstractRootContextTest{
	@Inject
	IssueDAO dao;
	@Test
	void test() {
		List<IssueVO> list = dao.selectIssueList("P00001",new PaginationInfo());
		log.info("list:{}",list);
	}
	@Test
	void test1() {
		IssueVO issue = dao.selectIssue("I00001");
		log.info("issue : {}", issue);
	}
	@Test
	void test2() {
		List<IssueCommentVO> list = dao.selectIssueCommentList("I00002");
		log.info("list : {}", list);
	}


}
