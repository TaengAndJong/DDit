package kr.or.ddit.student.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.common.paging.PaginationInfo;
import kr.or.ddit.vo.ClassVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.SubjectVO;

public interface StudentDAO {
	
	/*
	 * 필요한 데이터
	 * 학생
	 * 1) 학생 개인에 대한 모든 데이터 - 
	 * 2) 학생 개인정보 수정 
	 * 
	 * 수강신청
	 * 1) 전체 강의목록 조회
	 * 2) 검색 옵션에 따른 리스트 조회
	 * 3) 수강신청시 완료 -> insert CLASS 테이블로 score  0 과 해당 학생명
	 * 4) 수강신청 조회 -> score가 0 인 컬럼만 조회 과 해당 학생명
	 * */
	
	public StudentVO selectStudent(@Param("stdNo") String stdNo);
	public int updateStudent(StudentVO student);
	public List<SubjectVO> selectSubjectList(@Param("stNo1") String stdNo,@Param("paging") PaginationInfo paging);
	public int subjectTotalLecord(@Param("stNo")String stdNo,PaginationInfo paging);
	public int insertClass(ClassVO vo);
	
}
