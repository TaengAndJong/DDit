package kr.or.ddit.staff.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import kr.or.ddit.common.paging.PaginationInfo;
import kr.or.ddit.db.CustomSqlSessionFactoryBulder;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.StudentVO;

public class StaffDAOImpl implements StaffDAO {
	private SqlSessionFactory sqlSessionFactory = CustomSqlSessionFactoryBulder.getSqlSessionFactrory();

	@Override
	public int selectTotalRecordStudent(PaginationInfo paging) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession();) {
			StaffDAO mapperProxy = sqlSession.getMapper(StaffDAO.class);
			return mapperProxy.selectTotalRecordStudent(paging);
		}
	}

	@Override
	public List<StudentVO> selectStudentList(PaginationInfo paging) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession();) {
			StaffDAO mapperProxy = sqlSession.getMapper(StaffDAO.class);
			return mapperProxy.selectStudentList(paging);
		}
	}

	@Override
	public StudentVO selectStudent(String stdName) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession();) {
			StaffDAO mapperProxy = sqlSession.getMapper(StaffDAO.class);
			return mapperProxy.selectStudent(stdName);
		}
	}

	@Override
	public int selectTotalRecordProfessor(PaginationInfo paging) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession();) {
			StaffDAO mapperProxy = sqlSession.getMapper(StaffDAO.class);
			return mapperProxy.selectTotalRecordProfessor(paging);
		}
	}

	@Override
	public List<ProfessorVO> selectProfessorList(PaginationInfo paging) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession();) {
			StaffDAO mapperProxy = sqlSession.getMapper(StaffDAO.class);
			return mapperProxy.selectProfessorList(paging);
		}
	}

	@Override
	public ProfessorVO selectProfessor(String proNo) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession();) {
			StaffDAO mapperProxy = sqlSession.getMapper(StaffDAO.class);
			return mapperProxy.selectProfessor(proNo);
		}
	}

	@Override
	public int insertStudent(StudentVO student) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession(true);) {
			StaffDAO mapperProxy = sqlSession.getMapper(StaffDAO.class);
			int rowcnt = mapperProxy.insertStudent(student);
			return rowcnt;
		}
	}

	@Override
	public int updateStudent(StudentVO student) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession(true);) {
			StaffDAO mapperProxy = sqlSession.getMapper(StaffDAO.class);
			int rowcnt = mapperProxy.updateStudent(student);
			return rowcnt;
		}
	}

	@Override
	public int deleteStudent(String stdNo) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession(true);) {
			StaffDAO mapperProxy = sqlSession.getMapper(StaffDAO.class);
			int rowcnt = mapperProxy.deleteStudent(stdNo);
			return rowcnt;
		}
	}

	@Override
	public int insertProfesor(ProfessorVO professor) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession(true);) {
			StaffDAO mapperProxy = sqlSession.getMapper(StaffDAO.class);
			int rowcnt = mapperProxy.insertProfesor(professor);
			return rowcnt;
		}
	}

	@Override
	public int updateProfessor(ProfessorVO professor) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession(true);) {
			StaffDAO mapperProxy = sqlSession.getMapper(StaffDAO.class);
			int rowcnt = mapperProxy.updateProfessor(professor);
			sqlSession.commit();
			return rowcnt;
		}
	}

	@Override
	public int deleteProfessor(String ProNo) {
		try (SqlSession sqlSession = sqlSessionFactory.openSession(true);) {
			StaffDAO mapperProxy = sqlSession.getMapper(StaffDAO.class);
			int rowcnt = mapperProxy.deleteProfessor(ProNo);
			return rowcnt;
		}
	}

}
