package kr.or.ddit.professor.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.SubjectVO;

public interface ProfessorDAO {
	/**
	 * 교수 한명 조회
	 * @param proNo
	 * @return 교수 한명 조회
	 */
	public ProfessorVO selectProfessor(String proNo);
	/**
	 *  교수 강의를 수강중인 학생 리스트 조회
	 * @param proNo
	 * @param subNo
	 * @return List<StudentVO> 
	 */
	public List<StudentVO> selectMyLectureStudentes(@Param("proNo") String proNo, @Param("subCd") String subCd);
	/**
	 * 교수의 강의 리스트 조회
	 * @param proNo
	 * @return List<SubjectVO>
	 */
	public List<SubjectVO> selectMySubject(String proNo);
	public int insertScore(@Param("scoreStdNo") String stdNo,@Param("scoreSubCd")String subCd,@Param("scoreScore") int score);
	
}
