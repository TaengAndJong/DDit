package kr.or.navi.advice.mypage;

import java.util.List;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import kr.or.navi.mypage.dao.DeptDAO;
import kr.or.navi.mypage.dao.PositionDAO;
import kr.or.navi.vo.DeptVO;
import kr.or.navi.vo.PositionVO;

@ControllerAdvice(value = {"kr.or.navi.mypage","kr.or.navi.mypagedetail","kr.or.navi.admin"})
public class MypageControllerAdvice {
	@Inject
	private DeptDAO dao;
	
	@Inject
	private PositionDAO pdao;
	
	@ModelAttribute("deptList")
	public List<DeptVO> addDeptList(){
		return dao.selectDeptList();
	}

	@ModelAttribute("positionList")
	public List<PositionVO> addPositionList(){
		return pdao.selectPositionList();
	}
	
}
