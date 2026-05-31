package kr.or.ddit.student.service;

import java.util.List;

import kr.or.ddit.common.paging.PaginationInfo;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.ClassVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.SubjectVO;

public interface StudentService {
	
	public StudentVO retrieveStudent(String stdNo);
	public int modifyStudent(StudentVO student);
	public List<SubjectVO> retrieveSubjectList(String stdNo, PaginationInfo paging);
	public boolean registerClass(ClassVO vo);
}
