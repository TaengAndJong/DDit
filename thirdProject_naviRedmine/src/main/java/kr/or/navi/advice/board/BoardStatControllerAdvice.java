package kr.or.navi.advice.board;

import java.util.List;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import kr.or.navi.common.dao.CommonDAO;
import kr.or.navi.vo.QnaStateVO;
import kr.or.navi.vo.ShareStatVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@ControllerAdvice(value= {"kr.or.navi.board","kr.or.navi.admin"})
public class BoardStatControllerAdvice {

	@Inject
	private CommonDAO dao;
	
	@ModelAttribute("shareState")
	public List<ShareStatVO> selectShareState(){
		return dao.selectShareStateList();
	}
	@ModelAttribute("qnaState")
	public List<QnaStateVO> selectQnaState(){
		return dao.selectQnaStateList();
	}
}
