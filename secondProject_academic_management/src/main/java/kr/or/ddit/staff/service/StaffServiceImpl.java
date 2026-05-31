package kr.or.ddit.staff.service;

import java.util.List;

import kr.or.ddit.common.paging.PaginationInfo;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.staff.dao.StaffDAO;
import kr.or.ddit.staff.dao.StaffDAOImpl;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.StudentVO;

public class StaffServiceImpl implements StaffService {
	
	private StaffDAO dao = new StaffDAOImpl();

	@Override
	public List<StudentVO> retrieveStudentList(PaginationInfo paging) {
		 // 전체 레코드 수 조회
        int totalRecord = dao.selectTotalRecordStudent(paging);
        // 페이징 정보에 전체 레코드 수 설정
        paging.setTotalRecord(totalRecord);
        // 페이징 정보를 이용하여 제품 리스트 조회
        return dao.selectStudentList(paging);
	}

	@Override
	public List<ProfessorVO> retrieveProfessorList(PaginationInfo paging) {
		 // 전체 레코드 수 조회
        int totalRecord = dao.selectTotalRecordProfessor(paging);
        // 페이징 정보에 전체 레코드 수 설정
        paging.setTotalRecord(totalRecord);
        // 페이징 정보를 이용하여 제품 리스트 조회
        return dao.selectProfessorList(paging);
	}

	@Override
	public StudentVO retrieveStudent(String stdName) {
		return dao.selectStudent(stdName);
	}

	@Override
	public ProfessorVO retrieveProfessor(String ProNo) {
		return null;
	}

	@Override
	public ServiceResult createStudent(StudentVO student) {
		return null;
	}

	@Override
	public ServiceResult createProfessor(ProfessorVO Professor) {
		return null;
	}

	@Override
	public boolean modifyStudent(StudentVO student) {
		int updateStudent = dao.updateStudent(student);
		if(updateStudent>0) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public boolean modifyProfessor(ProfessorVO Professor) {
		int updateProfessor = dao.updateProfessor(Professor);
		if(updateProfessor>0) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public ServiceResult removeStudent(StudentVO inputData) {
		return null;
	}

	@Override
	public ServiceResult removeProfessor(ProfessorVO inputData) {
		return null;
	}

}
