package kr.or.ddit.student.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import kr.or.ddit.common.paging.PaginationInfo;
import kr.or.ddit.db.CustomSqlSessionFactoryBulder;
import kr.or.ddit.vo.ClassVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.SubjectVO;

public class StudentDAOImpl implements StudentDAO {

	// dao는 mybatis 와 의존관계
	SqlSessionFactory sqlSessionFactory = CustomSqlSessionFactoryBulder.getSqlSessionFactrory();

	@Override
	public StudentVO selectStudent(String stdNo) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession();) {
			StudentDAO mapperProxy = sqlSession.getMapper(StudentDAO.class);
			sqlSession.commit();
			return mapperProxy.selectStudent(stdNo);
		}
	}

	@Override
	public int updateStudent(StudentVO student) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession();) {
			StudentDAO mapperProxy = sqlSession.getMapper(StudentDAO.class);
			int rowcnt = mapperProxy.updateStudent(student);
			sqlSession.commit();
			return rowcnt;
		}
	}

	@Override
	public List<SubjectVO> selectSubjectList(String stdNo, PaginationInfo paging) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession();) {
			StudentDAO mapperProxy = sqlSession.getMapper(StudentDAO.class);
			return mapperProxy.selectSubjectList(stdNo, paging);
		}
	}

	@Override
	public int subjectTotalLecord(String stdNo, PaginationInfo paging) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession();) {
			StudentDAO mapperProxy = sqlSession.getMapper(StudentDAO.class);
			return mapperProxy.subjectTotalLecord(stdNo, paging);
		}
	}

	@Override
	public int insertClass(ClassVO vo) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession();) {
			StudentDAO mapperProxy = sqlSession.getMapper(StudentDAO.class);
			int rw = mapperProxy.insertClass(vo);
			sqlSession.commit();
			return rw;
		}
	}

}
