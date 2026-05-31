package kr.or.ddit.professor.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import org.junit.jupiter.api.Test;

import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.SubjectVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
class ProfessorDAOTest {
	ProfessorDAO dao = new ProfessorDAOImple();
	@Test
	void test() {
		int rw = dao.insertScore("18AA010001", "181AA101", 11);
		log.info("row{}",rw);
	}
}
