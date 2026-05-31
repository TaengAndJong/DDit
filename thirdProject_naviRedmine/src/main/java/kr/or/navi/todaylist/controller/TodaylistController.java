package kr.or.navi.todaylist.controller;


import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.inject.Inject;
import javax.xml.soap.Detail;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.navi.advice.task.TaskControllerAdvice;
import kr.or.navi.common.paging.BootstrapFormBasePaginationRenderer;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.common.paging.PaginationRenderer;
import kr.or.navi.security.RealUser;
import kr.or.navi.todaylist.dao.TodayListDAO;
import kr.or.navi.todaylist.service.TodayListService;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.TaskProcessStatusVO;
import kr.or.navi.vo.TaskStatusVO;
import kr.or.navi.vo.TaskVO;
import kr.or.navi.vo.TodayListVO;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@RequestMapping("/todaylist")
@Controller
public class TodaylistController {

	@Inject
	TodayListService todaylistService;
	@Inject
	TaskControllerAdvice taskCommonService;
	
	@PostMapping
	public String todaylist(@RealUser EmpVO realUser, @RequestBody List<Map<String, String>> request, Model model) {
	    List<TodayListVO> allTodayList = new ArrayList<>();
	    String empId = realUser.getEmpId();
	    for (Map<String, String> taskObj : request) {
	        String taskId = taskObj.get("taskId");
	        List<TodayListVO> list = todaylistService.selectTodayList(empId, taskId);
	        allTodayList.addAll(list);
	    }
	    
	    model.addAttribute("allTodayList", allTodayList);
	    log.info("taskIdList--------------{}", allTodayList);
	    return "todaylist/tdList"; // 해당 JSP 페이지로 이동
	}
	
	@GetMapping
	public String todaylistModal(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage
			,@RequestParam Map<String, Object> detailCondition
			,@RealUser EmpVO realUser		
			,Model model) {
				LocalDate nowLd = LocalDate.now();
				String now=nowLd.format(DateTimeFormatter.ISO_DATE);
				DayOfWeek dayOfWeek = nowLd.getDayOfWeek();
				String week = getKoreanDayOfWeek(dayOfWeek);
				model.addAttribute("now",now);
				model.addAttribute("week",week);
				PaginationInfo paging = new PaginationInfo(5,5); // 스크린 사이즈와, 블럭 사이즈
				
				 // 검색 searchForm에서 부터 넘어오는 파라미터값 
				paging.setCurrentPage(currentPage); 
				paging.setDetailCondition(detailCondition);
			    
				String taskManId = realUser.getEmpId();
				List<TodayListVO> taskList =todaylistService.selectTaskList(paging, taskManId);
				List<TaskStatusVO> taskstatusList = taskCommonService.addProjectStateList();
				List<TaskProcessStatusVO> tpsStatusList =taskCommonService.addProcessStatusVO();
				model.addAttribute("taskList",taskList); 
				model.addAttribute("taskstatusList",taskstatusList);
				model.addAttribute("tpsStatusList",tpsStatusList);
				List<TodayListVO> todayList = todaylistService.selectTodayListAll(taskManId);
				model.addAttribute("todayList",todayList); 
				log.info("todayList : {}",todayList);
				
				//4.페이지네이션 그려주기
				PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
				//5.페이지네이션 html String값으로 넘겨주기
				String pagingHTML = renderer.renderPagination(paging);
				//6.모델에 담아서 뷰로 보내기
				model.addAttribute("pagingHTML",pagingHTML);
				model.addAttribute("paging",paging);
			
		
		return "todaylist/tdList";
	}
	private static String getKoreanDayOfWeek(DayOfWeek dayOfWeek) {
        switch (dayOfWeek) {
            case MONDAY:
                return "월요일";
            case TUESDAY:
                return "화요일";
            case WEDNESDAY:
                return "수요일";
            case THURSDAY:
                return "목요일";
            case FRIDAY:
                return "금요일";
            case SATURDAY:
                return "토요일";
            case SUNDAY:
                return "일요일";
            default:
                return "";
        }
    }
	

	 //비동기 요청 할 떄에도 서버에서 메소드를 받아줄 컨트롤러 필요
	//Spring MVC에서 @ResponseBody를 사용하면 해당 메서드가 직접 데이터를 반환하고, Spring은 이 데이터를 HTTP 응답 본문에 직렬화하여 클라이언트에게 보냄
	//Post요청으로 받아온 데이터는 파라미터로 받아줘야함
	@PostMapping("todayModal")
	@ResponseBody
	public List<TodayListVO> test(
	        @RealUser EmpVO realUser,
	        Model model) {
		 String taskManId = realUser.getEmpId();
	    List<TodayListVO> taskList = todaylistService.selectTaskAllList(taskManId);
	    log.info("todayModal------------:{}",taskList);
	    return taskList;
	}

	@PostMapping("search")
	@ResponseBody
	public List<TodayListVO> search(
	        @RealUser EmpVO realUser,
	        @RequestBody Map<String, Object> requestBody,
	        Model model) {
		
			PaginationInfo paging = new PaginationInfo();
			
			 String taskManId = realUser.getEmpId();
			 String ts = (String) requestBody.get("ts");
			 String tps = (String) requestBody.get("tps");
			 String word = (String) requestBody.get("word");
		 
			 paging.addDetailCondition("ts", ts);
			 paging.addDetailCondition("tps", tps);
			 paging.addDetailCondition("word", word);
			 
			 List<TodayListVO> searchList = todaylistService.selectTaskList(paging,taskManId);
			 log.info("requestBody------------:{}",requestBody);
			 log.info("taskManId------------:{}",taskManId);
			 log.info("searchList------------:{}",searchList);
	    return searchList;
	
	}
		
	
	
	/*
	 * requestBoby 원본 데이터 [{sendData2=[{taskId=T00030}, {taskId=T00032} ....  }]
	 * checkedInput 원본데이 {sendData2=[{taskId=T00030}, {taskId=T00032}]}
	 * taskIdList 원본데이터 [{taskId=T00030}, {taskId=T00032}]
	 * */
	
	@PostMapping("addList")
	@ResponseBody 
	public  List<TodayListVO> addTdList(@RealUser EmpVO realUser,
	                               @RequestBody List<Map<String, Object>> requestBody,
	                               Model model) {
	    
		log.info("requestBody --------------:{}",requestBody);
		 // checkedInput에서 taskId 배열 추출
	    List<Map<String, Object>> taskIdList = (List<Map<String, Object>>) requestBody;
	    log.info("taskIdList:{}", taskIdList);
	    
	    // taskIdList의 value를 전부 배열에 담기
	    List<String> taskIdValues = taskIdList.stream()
	            .map(map -> map.get("taskId").toString())
	            .collect(Collectors.toList());
	    List<TodayListVO> allTodayList = new ArrayList<>();
	    // 모든 조회 결과를 담을 리스트 생성
	    // 오늘의 일정에 insert 시키는 부분 => tlRegDt(추가일로 자동반영), tlIdx(자동증가시키기), taskId(for문에서 봅음), empId(realUser 에서 받음)
	    String empId = realUser.getEmpId(); // 직원 ID 가져오기
	
	    for (String taskId : taskIdValues) { // taskIdValues 리스트의 각 요소에 대해 반복문 실행
	        // 각 taskId에 대한 조회 수행
	        List<TodayListVO> todayList = todaylistService.selectTodayList(empId,taskId);
	        // 조회 결과를 전체 리스트에 추가
	        log.info("todayList :{}",todayList);
	        TodayListVO tdVo = new TodayListVO() ;     
	        tdVo.setEmpId(empId);
	        tdVo.setTaskId(taskId);
	        // taskId와 empId를 이용하여 일정 추가
	        todaylistService.insertTdList(tdVo); // Insert 대상 목록 전달
	        allTodayList.addAll(todayList);
	    }
	   return todaylistService.selectTodayListAll(realUser.getEmpId());
	
	}
	
	
	/*
	 * json으로 보내면 배열 안에 객체의 형식으로 데이턱 넘어오기 때문에 자바타입도 동일하게 맞춰줘야한다.
	 * List<Map<String, Object>>
	 * 
	 * Map<String, Object>는 객체와 동일하게 {key:value}의 형태로 맞춰줌
	 * body에 객체를 묶어서 보내기때문에 List로 한 번더 감싸준다.!
	 * */
	
	
	@PostMapping("delete")
	@ResponseBody
	public String deleteTdList(@RealUser EmpVO realUser,
			 @RequestBody  List<Map<String, Object>>  requestBody,
            Model model) {
		
		log.info("삭제메소드입니다: {}" , requestBody);
		
		  // taskIdList의 value를 전부 배열에 담기
	    List<String> taskIdValues = requestBody.stream()
	            .map(map -> map.get("taskId").toString())
	            .collect(Collectors.toList());
	    
	    int tdDelList = 0;
	    List<TodayListVO> allTodayList = new ArrayList<>();
	    
	    for (String taskId : taskIdValues) { // taskIdValues 리스트의 각 요소에 대해 반복문 실행
	        // 각 taskId에 해당하는 데이터 삭제
	      tdDelList = todaylistService.deleteTdList(taskId,realUser.getEmpId());
	      log.info("tdDelList",tdDelList); 
	    
	    }
	    
		return "삭제가 완료되었습니다.";
	}
	
	@PostMapping("update")
	@ResponseBody
	public Map<String,	Integer> updateTdList(@RealUser EmpVO realUser,
			 @RequestBody  List<TaskVO>  requestBody,
            Model model) {
		log.info("업데이트 메시지입니다: {}" , requestBody);
		int cnt = todaylistService.modifyTodayList(requestBody);
		Map<String,	Integer> map = new HashMap<String, Integer>();
	    map.put("cnt", cnt);
		return map;
	}
	
	
	
	
	
}
