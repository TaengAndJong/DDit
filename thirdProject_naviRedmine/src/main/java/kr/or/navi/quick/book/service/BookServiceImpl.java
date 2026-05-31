package kr.or.navi.quick.book.service;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.navi.quick.book.dao.BookDAO;
import kr.or.navi.quick.book.vo.BookNameVO;
import kr.or.navi.quick.book.vo.BookVO;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BookServiceImpl implements BookService{
	
	@Inject
	private BookDAO bookDao;
	
	@Override
	public List<BookVO> selectbookList(){
		return bookDao.selectbookList();
	}
	
	@Override
	public List<BookNameVO> selectBookNameList(){
		return bookDao.selectbookNameList();
	}

	@Override
    public String getBookNameByBkId(String bkId) {
        return bookDao.getBookNameByBkId(bkId);
    }
	
	
	@Override
	public List<BookVO> recomBookList(EmpVO vo){
		String bk = vo.getEmpBkId();
		Integer empAge = vo.getEmpAge();
		Integer empCr = vo.getEmpCareer();
		HashMap<String, String> map = trasEmpData(bk, empAge, empCr);
		map.put("bk", bk);
		return bookDao.selectRecombookList(map);
	}
	
	private HashMap<String, String> trasEmpData(String bk, Integer empAge, Integer empCr) {
		HashMap<String, String> map = new HashMap<String, String>();

		if(empAge<30) {
			map.put("age", "0");
		}else if(empAge<40) {
			map.put("age", "1");
		}else if(empAge<50) {
			map.put("age", "2");
		}else if(empAge<60) {
			map.put("age", "3");
		}else {
			map.put("age", "4");
		}
		
		if(empCr<3) {
			map.put("cr", "0");
		}else if(empCr<6) {
			map.put("cr", "1");
		}else if(empCr<9) {
			map.put("cr", "2");
		}else {
			map.put("cr", "3");
		}
		
		return map;
	}
	
	@Override
	public int insertBook(String empId, String bkListId) {
		return bookDao.insertBook(empId, bkListId);
	}
}
