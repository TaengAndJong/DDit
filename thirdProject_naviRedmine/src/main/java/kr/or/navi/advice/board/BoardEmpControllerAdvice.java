package kr.or.navi.advice.board;

import java.util.List;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import kr.or.navi.mapper.dao.EmpDAO;
import kr.or.navi.vo.EmpVO;

@ControllerAdvice(value= {"kr.or.navi.board","kr.or.navi.form","kr.or.navi.admin"})
public class BoardEmpControllerAdvice {
	
	@Inject
	private EmpDAO dao;
	
//	@ModelAttribute("EmpNameList")
	public List<EmpVO> selectEmpNameList(){
		return dao.selectList();
	}

}
