package kr.or.ddit.staff.service;

import java.util.List;

import kr.or.ddit.common.exception.PKNotFoundException;
import kr.or.ddit.common.paging.PaginationInfo;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.StudentVO;

/**
 * 학생 및 교수(crud)용 business logic layer
 *
 */
public interface StaffService {

	/**
	 * 학생 목록 조회
	 * totalRecord 와 페이징 처리 결과 데이터 목록 조회
	 * @param paging
	 * @return
	 */
	public List<StudentVO> retrieveStudentList(PaginationInfo paging);
	
	/**
	 * 교수 목록 조회
	 * totalRecord 와 페이징 처리 결과 데이터 목록 조회
	 * @param paging
	 * @return
	 */
	public List<ProfessorVO> retrieveProfessorList(PaginationInfo paging);
	
	/**
	 * 학생정보 상세조회
	 * @param StdName 조회할 회원의 primary key
	 * @return 존재하지 않는 경우, {@link PKNotFoundException}
	 */
	public StudentVO retrieveStudent(String stdName);
	
	/**
	 * 교수정보 상세조회
	 * @param ProNo 조회할 회원의 primary key
	 * @return 존재하지 않는 경우, {@link PKNotFoundException}
	 */
	public ProfessorVO retrieveProfessor(String ProNo);

	/**
	 * 학생신규등록
	 * @param student
	 * @return PKDUPLICATED, OK, FAIL
	 */
	public ServiceResult createStudent(StudentVO student);
	
	/**
	 * 교수신규등록
	 * @param Professor
	 * @return PKDUPLICATED, OK, FAIL
	 */
	public ServiceResult createProfessor(ProfessorVO Professor);

	/**
	 * 학생 정보 수정
	 * @param student
	 * @return INVALIDPASSWORD, OK, FAIL
	 */
	public boolean modifyStudent(StudentVO student);
	
	/**
	 * 교수 정보 수정
	 * @param student
	 * @return INVALIDPASSWORD, OK, FAIL
	 */
	public boolean modifyProfessor(ProfessorVO Professor);

	/**
	 * 학생 정보 삭제
	 * @param inputData
	 * @return INVALIDPASSWORD, OK, FAIL
	 */
	public ServiceResult removeStudent(StudentVO inputData);

	/**
	 * 교수 정보 삭제
	 * @param inputData
	 * @return INVALIDPASSWORD, OK, FAIL
	 */
	public ServiceResult removeProfessor(ProfessorVO inputData);

}
