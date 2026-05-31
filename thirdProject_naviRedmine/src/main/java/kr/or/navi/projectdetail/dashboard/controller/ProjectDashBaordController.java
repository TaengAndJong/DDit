package kr.or.navi.projectdetail.dashboard.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.project.service.ProjectService;
import kr.or.navi.projectdetail.dashboard.service.DashBoardService;
import kr.or.navi.projectdetail.dashboard.vo.IssueChartVO;
import kr.or.navi.projectdetail.dashboard.vo.TaskChartVO;
import kr.or.navi.projectdetail.dashboard.vo.TaskIngChartVO;
import kr.or.navi.projectdetail.dashboard.vo.TeamChartVO;
import kr.or.navi.projectdetail.filesave.controller.ProjectFilesaveController;
import kr.or.navi.projectdetail.issue.controller.service.IssueService;
import kr.or.navi.vo.IssueVO;
import kr.or.navi.vo.TaskVO;
import kr.or.navi.vo.TeamVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/project/dashboard")
@Slf4j
public class ProjectDashBaordController {
	@Inject
	private DashBoardService service;
	@Inject
	private ProjectService proService;
	
	@GetMapping("{proId}")
	public String dashboardPage(@PathVariable(name = "proId") String proId, Model model) {
		log.info("proId : {}", proId);
		List<TaskVO> retriveTaskList = service.retriveTaskList(proId);
		TaskIngChartVO ingChartVO= new TaskIngChartVO(retriveTaskList);
		model.addAttribute("ing", ingChartVO);
		
		TaskChartVO taskChartVO=new TaskChartVO(retriveTaskList);
		List<TeamVO> teamList = service.retriveTeamList(proId);
		
		TeamChartVO teamChartVO = new TeamChartVO(teamList);
		model.addAttribute("chart", taskChartVO);
		
		PaginationInfo paging = new PaginationInfo();
		List<IssueVO> issueList = proService.issueList(proId, paging);
		IssueChartVO issueChart = new IssueChartVO(issueList);
		model.addAttribute("team", issueChart);
		model.addAttribute("issueList",issueList);
		
		return "project/dashboard/dashboard";
	}
}
