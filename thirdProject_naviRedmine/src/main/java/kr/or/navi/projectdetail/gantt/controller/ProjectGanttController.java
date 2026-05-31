package kr.or.navi.projectdetail.gantt.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.navi.projectdetail.gantt.service.GanttService;
import kr.or.navi.projectdetail.gantt.service.GanttServiceImpl;
import kr.or.navi.projectdetail.gantt.vo.GanttEventVO;
import kr.or.navi.projectdetail.gantt.vo.GanttVOEvent;
import kr.or.navi.vo.TaskVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/project/gantt")
@Slf4j
public class ProjectGanttController {
	@Inject
	public GanttService gattService;
	
	@ResponseBody
	@PostMapping("{proId}")
	public List<GanttVOEvent> gantt(@PathVariable(name = "proId") String proId){
		List<GanttVOEvent> list = gattService.getGanttEventList(proId);
		log.info("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		log.info("list : {}",list);
		log.info("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		return list;
	}
	@GetMapping("{proId}")
	public String gnattPage(@PathVariable(name = "proId") String proId,Model model) {
		List<GanttVOEvent> list = gattService.getGanttEventList(proId);
		model.addAttribute("list",list);
		return "project/gantt/gantPage";
	}
	@PostMapping("{proId}/date")
	@ResponseBody
	public String ganttTaskDate(@PathVariable(name="proId") String proId,@RequestBody TaskVO updateVO) {
		log.info("updateVO : {}",updateVO);
		int cnt = gattService.modifyTask(updateVO);
		if(cnt>0) {
			return "ok";
		}else {
			return "false";
		}
	}
	
}
