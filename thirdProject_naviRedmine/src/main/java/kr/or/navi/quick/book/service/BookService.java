package kr.or.navi.quick.book.service;

import java.util.List;

import kr.or.navi.quick.book.vo.BookNameVO;
import kr.or.navi.quick.book.vo.BookVO;
import kr.or.navi.vo.EmpVO;

public interface BookService {
	List<BookVO> selectbookList();
	List<BookVO> recomBookList(EmpVO vo);
	int insertBook(String empId, String bkListId);
	List<BookNameVO> selectBookNameList();
	String getBookNameByBkId(String bkId);
	

}
