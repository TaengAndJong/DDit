package kr.or.navi.advice.project;

import java.util.List;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import kr.or.navi.advice.dao.RoleDAO;
import kr.or.navi.common.dao.CommonDAO;
import kr.or.navi.vo.CommonVO;
import kr.or.navi.vo.RoleVO;


@ControllerAdvice(value = {"kr.or.navi","kr.or.navi.admin"})
public class ProjectControllerAdvice {
	@Inject
	private CommonDAO dao;
	
	@Inject
	private RoleDAO roleDao;
	@ModelAttribute("projectStateList")
	public List<CommonVO> addProjectStateList(){
		return dao.selectProjectStateList();
	}
	@ModelAttribute("issueStateList")
	public List<CommonVO> addIssueStateList(){
		return dao.selectIssueStateList();
	}
	@ModelAttribute("issueImportStateList")
	public List<CommonVO> addIssueImportStateList(){
		return dao.selectIssueImportStateList();
	}
	@ModelAttribute("roleList")
	public List<RoleVO> addRoleList(){
		return roleDao.selectRoleList();
	}
	
}
