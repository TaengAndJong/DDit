package kr.or.navi.quick.book.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.quick.book.vo.BookNameVO;
import kr.or.navi.quick.book.vo.BookVO;
import kr.or.navi.vo.IssueVO;

@Mapper
public interface BookDAO {
	public List<BookVO> selectbookList();
	public List<BookNameVO> selectbookNameList();
	public List<BookVO> selectRecombookList(@Param("map") HashMap<String, String> map);
	public int insertBook(@Param("empId") String empId, @Param("bkListId") String bkListId);
	public String getBookNameByBkId(String bkId);
}
