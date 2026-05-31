package kr.or.navi.advice.board;

import java.util.List;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import kr.or.navi.common.dao.CommonDAO;
import kr.or.navi.vo.CommonVO;

@ControllerAdvice(value = {"kr.or.navi.board","kr.or.navi.wiki","kr.or.navi.admin", "kr.or.navi.mypagedetail", "kr.or.navi.mypage"})
public class BoardControllerAdvice {
	@Inject
	private CommonDAO dao;
	
	@ModelAttribute("boardTypeList")
	public List<CommonVO> selectBoardTypeList(){
		return dao.selectBoardTypeList();
	}
}
