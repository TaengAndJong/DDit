package kr.or.ddit.professor.service;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class ProfessorServiceTest {
ProfessorService service = new ProfessorServiceImpl();
	@Test
	void test() {
		boolean registerScore = service.registerScore("22BA010001", "181AA104", 44);
		assertNotEquals(registerScore, true);
		System.out.println(registerScore);
	}

}
