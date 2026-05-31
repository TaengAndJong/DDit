package kr.or.navi.advice.alram;

import java.util.Collections;
import java.util.List;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import kr.or.navi.mypagedetail.alarm.dao.AlramDAO;
import kr.or.navi.security.RealUser;
import kr.or.navi.vo.AlarmVO;
import kr.or.navi.vo.CommonVO;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@ControllerAdvice(value = {"kr.or.navi.admin","kr.or.navi.board"
		,"kr.or.navi.board","kr.or.navi.admin","kr.or.navi.index"
		,"kr.or.navi.mypage","kr.or.navi.mypagedetail","kr.or.navi.project","kr.or.navi.projectdetail","kr.or.navi.admin","kr.or.navi.quick"})
public class AlramControllerAdvice {
	@Inject
	private AlramDAO dao;
	
	@ModelAttribute("alramDisplayList")
	public List<AlarmVO> selectAlramList(@RealUser EmpVO realUser){
		log.info("alramDisplayList");
		return dao.selectDisplayAlramList(realUser.getEmpId());
	}

}
