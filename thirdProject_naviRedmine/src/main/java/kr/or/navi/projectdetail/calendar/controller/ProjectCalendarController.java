package kr.or.navi.projectdetail.calendar.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.navi.projectdetail.calendar.service.TaskFullCalendarService;
import kr.or.navi.projectdetail.calendar.vo.AbstractEvent;
import kr.or.navi.projectdetail.calendar.vo.TaskFulAdapterVO;
import kr.or.navi.projectdetail.calendar.vo.TaskFulVOEvent;
import kr.or.navi.vo.TaskVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/project/calendar")
@Slf4j
public class ProjectCalendarController {
	@Inject
	private TaskFullCalendarService service;
	/**
	 * 프로젝트 상세에서 달력 페이지로 이동하기 위한 컨트롤러
	 * @param proId 프로젝트 ID
	 * @param model
	 * @return
	 */
	@GetMapping("{proId}")
	public String callanderPage(@PathVariable(name = "proId") String proId,Model model) {
		model.addAttribute("proId", proId);
		String nowStr = LocalDate.now().format(DateTimeFormatter.ISO_DATE);
		model.addAttribute("nowStr",nowStr);
		
		log.info("nowStr : {}",nowStr);
		return "project/callander/callander";
	}
	/**
	 * Adapter 패턴을 이용하여 fullcalendar 에 맞게 개발한 TaskFulVOEvent 리스트 조회 컨트롤러
	 * @param proId 프로젝트 ID
	 * @param model
	 * @return
	 */
	@GetMapping("{proId}/data")
	@ResponseBody
	public List<AbstractEvent<?>> callanderController(@PathVariable(name = "proId") String proId,Model model) {
		List<TaskFulAdapterVO> list = service.retrieveTaskAdapterList(proId);
		log.info("list.size : {}",list.size());
		return list.stream()
//				.filter(p->p.getSolaDateReal()!=null)
				.map(t->new TaskFulVOEvent(t))
				.collect(Collectors.toList());
	}
	/**
	 * 달력 모달 클릭시 해당 정보에 맞는 일감 목록 조회를 위한 컨트롤러
	 * @param proId 프로젝트 ID
	 * @param solaDate 날자정보를 가지고 있는 데이터
	 * @return
	 */
	@GetMapping("{proId}/{tsListId}/json")
	@ResponseBody
	public List<TaskVO> clickEventController(@PathVariable(name="proId")String proId,@PathVariable(name="tsListId")String solaDate){
		return service.retrieveTaskList(proId, solaDate);
	}
}
