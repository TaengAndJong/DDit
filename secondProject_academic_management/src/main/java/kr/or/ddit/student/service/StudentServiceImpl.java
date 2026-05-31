package kr.or.ddit.student.service;

import java.util.List;

import kr.or.ddit.common.paging.PaginationInfo;
import kr.or.ddit.student.dao.StudentDAO;
import kr.or.ddit.student.dao.StudentDAOImpl;
import kr.or.ddit.vo.ClassVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.SubjectVO;

public class StudentServiceImpl implements StudentService {

	//service는 DAO와 의존관계
	StudentDAO dao = new StudentDAOImpl();
	
	
	@Override
	public StudentVO retrieveStudent(String stdNo) {
	
		return dao.selectStudent(stdNo);
	
	}
	
	@Override
	public int modifyStudent(StudentVO student) {
		int rowcnt = 0;
		if(dao.updateStudent(student) > 0) {
			rowcnt =1;
			
		}
		return rowcnt;
	}


	@Override
	public List<SubjectVO> retrieveSubjectList(String stdNo, PaginationInfo paging) {
		int totalLecord = dao.subjectTotalLecord(stdNo, paging);
		paging.setTotalRecord(totalLecord);
		return dao.selectSubjectList(stdNo, paging);
	}




	@Override
	public boolean registerClass(ClassVO vo) {
		int rowcnt = dao.insertClass(vo);
		if(rowcnt>0) {
			return true;
		}else {
			return false;
		}
	}

}
