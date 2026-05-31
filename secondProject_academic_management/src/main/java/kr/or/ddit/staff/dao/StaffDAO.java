package kr.or.ddit.staff.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.common.paging.PaginationInfo;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.StudentVO;

public interface StaffDAO {
	/**
	 * 전체 학생의 수를 조회 (totalRecord)
	 * 
	 * @param paging
	 * @return
	 */
	public int selectTotalRecordStudent(PaginationInfo paging);

	/**
	 * 학생 목록 조회, 검색과 페이징 적용
	 * 
	 * @param paging
	 * @return 존재하지 않는 경우, list.size()==0
	 */
	public List<StudentVO> selectStudentList(PaginationInfo paging);

	/**
	 * 학생 정보 단건조회
	 * 
	 * @param stuNo 조회할 학생의 학번
	 * @return 존재하지 않는 경우, null 반환
	 */
	public StudentVO selectStudent(@Param("stdName") String stdName);

	/**
	 * 전체 교수의 수를 조회 (totalRecord)
	 * 
	 * @param paging
	 * @return
	 */
	public int selectTotalRecordProfessor(PaginationInfo paging);

	/**
	 * 교수 목록 조회, 검색과 페이징 적용
	 * 
	 * @param paging
	 * @return 존재하지 않는 경우, list.size()==0
	 */
	public List<ProfessorVO> selectProfessorList(PaginationInfo paging);

	/**
	 * 교수 정보 단건조회
	 * 
	 * @param proNo 조회할 학생의 학번
	 * @return 존재하지 않는 경우, null 반환
	 */
	public ProfessorVO selectProfessor(@Param("proNo") String proNo);

	/**
	 * 학생 신규 등록
	 * 
	 * @param student
	 * @return 등록된 레코드 수 > 0 ? 성공
	 */
	public int insertStudent(StudentVO student);

	/**
	 * 학생 정보 수정
	 * 
	 * @param student
	 * @return 수정된 레코드 수 > 0 ? 성공
	 */
	public int updateStudent(StudentVO student);

	/**
	 * 학생 정보 삭제
	 * 
	 * @param stuNo (학번)
	 * @return 삭제된 레코드 수 > 0 ? 성공
	 */

	public int deleteStudent(String stdNo);

	/**
	 * 교수 신규 등록
	 * 
	 * @param professor
	 * @return 등록된 레코드 수 > 0 ? 성공
	 */
	public int insertProfesor(ProfessorVO professor);

	/**
	 * 교수 정보 수정
	 * 
	 * @param student
	 * @return 수정된 레코드 수 > 0 ? 성공
	 */
	public int updateProfessor(ProfessorVO professor);

	/**
	 * 교수 정보 삭제
	 * 
	 * @param ProNo (교수번호)
	 * @return 삭제된 레코드 수 > 0 ? 성공
	 */
	public int deleteProfessor(String proNo);

}
