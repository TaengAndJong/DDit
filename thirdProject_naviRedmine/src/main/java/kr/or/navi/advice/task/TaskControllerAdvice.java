package kr.or.navi.advice.task;

import java.util.List;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import kr.or.navi.advice.dao.TaskCommonDAO;
import kr.or.navi.vo.CommonVO;
import kr.or.navi.vo.TaskProcessStatusVO;
import kr.or.navi.vo.TaskStatusVO;

@ControllerAdvice(value = {"kr.or.navi.projectdetail","kr.or.navi.task","kr.or.navi.admin","kr.or.navi.todaylist"})
public class TaskControllerAdvice {
	@Inject
	private TaskCommonDAO dao;
	/**
	 * 일감 상태 ADVICE
	 * @return
	 */
	@ModelAttribute("taskStatusList")
	public List<TaskStatusVO> addProjectStateList(){
		return dao.selectTaskStatusList();
	}
	
	/**
	 * 일감 진행률 ADVICE
	 * @return
	 */
	@ModelAttribute("taskProcessStatusList")
	public List<TaskProcessStatusVO> addProcessStatusVO(){
		return dao.selectTaskProcessStatusList();
	}
}
