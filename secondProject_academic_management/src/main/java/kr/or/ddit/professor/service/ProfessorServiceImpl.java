package kr.or.ddit.professor.service;

import java.util.List;

import kr.or.ddit.professor.dao.ProfessorDAOImple;
import kr.or.ddit.student.controller.StudentListController;
import kr.or.ddit.professor.dao.ProfessorDAO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.SubjectVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ProfessorServiceImpl implements ProfessorService{
	private ProfessorDAO dao = new ProfessorDAOImple();
	@Override
	public boolean checkProfessor(String proNo) {
		ProfessorVO selectProfessor = dao.selectProfessor(proNo);
		if(selectProfessor==null) {
			return false;
		}else {
			return true;
		}
		
	}

	@Override
	public List<StudentVO> retrieveMyLectureStudentes(String proNo, String subCd) {
		return dao.selectMyLectureStudentes(proNo, subCd);
	}

	@Override
	public List<SubjectVO> retriveMySubject(String proNo) {
		List<SubjectVO> selectMySubject = dao.selectMySubject(proNo);
		return selectMySubject;
	}

	@Override
	public boolean registerScore(String stdNo, String subCd, int score) {
		if(dao.insertScore(stdNo, subCd, score)>0) {
			return true;
		}else {
			return false;
		}
	}

}
