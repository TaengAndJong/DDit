package kr.or.ddit.professor.service;

import java.util.List;

import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.SubjectVO;

public interface ProfessorService {
	/**
	 * 교수 존재 여부 확인
	 * @param proNo
	 * @return 교수가 존재하면 true 없으면 false
	 */
	public boolean checkProfessor(String proNo);
	/**
	 * 해당 교수 강의를 수강중인 학생 조회
	 * @param proNo 조회할 교수
	 * @param subCd 강의 코드
	 * @return 수강중인 학생 리스트
	 */
	public List<StudentVO> retrieveMyLectureStudentes(String proNo,String subCd);
	/**
	 * 교수의 강의 리스트 조회
	 * @param proNo 조회할 교수 번호
	 * @return 강의 리스트
	 */
	public List<SubjectVO> retriveMySubject(String proNo);
	
	/**
	 * 강의 점수 수정 및 등록
	 * @param stdNo 수강 학생 번호
	 * @param subCd 수강 강의 코드
	 * @param score 점수
	 * @return 성공시 true 실패시 false
	 */
	public boolean registerScore(String stdNo,String subCd,int score);
	
}
