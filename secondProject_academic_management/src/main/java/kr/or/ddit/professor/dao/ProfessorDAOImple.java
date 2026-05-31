package kr.or.ddit.professor.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import kr.or.ddit.db.CustomSqlSessionFactoryBulder;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.SubjectVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ProfessorDAOImple implements ProfessorDAO {
	private SqlSessionFactory sqlSessionFactory=
			CustomSqlSessionFactoryBulder.getSqlSessionFactrory();
	@Override
	public ProfessorVO selectProfessor(String proNo) {
		try(
			SqlSession sqlSession = sqlSessionFactory.openSession();
		){
			ProfessorDAO mapper = sqlSession.getMapper(ProfessorDAO.class);
			return mapper.selectProfessor(proNo);
		}
	}

	@Override
	public List<StudentVO> selectMyLectureStudentes(String proNo, String subNo) {
		try(
				SqlSession sqlSession = sqlSessionFactory.openSession();
			){
				ProfessorDAO mapper = sqlSession.getMapper(ProfessorDAO.class);
				return mapper.selectMyLectureStudentes(proNo,subNo);
			}
	}

	@Override
	public List<SubjectVO> selectMySubject(String proNo) {
		try(
				SqlSession sqlSession = sqlSessionFactory.openSession();
			){
				ProfessorDAO mapper = sqlSession.getMapper(ProfessorDAO.class);
				return mapper.selectMySubject(proNo);
			}
	}

	@Override
	public int insertScore(String stdNo, String subCd, int score) {
		try(
				SqlSession sqlSession = sqlSessionFactory.openSession();
			){
				ProfessorDAO mapper = sqlSession.getMapper(ProfessorDAO.class);
				int rw = mapper.insertScore(stdNo, subCd, score);
				sqlSession.commit();
				return rw;
			}catch (Exception e) {
			    e.printStackTrace(); // 또는 로그에 기록
			    return -1; // 실패를 나타내는 값 반환 또는 예외 처리 방식에 따라 다르게 처리
			}
	}

}
