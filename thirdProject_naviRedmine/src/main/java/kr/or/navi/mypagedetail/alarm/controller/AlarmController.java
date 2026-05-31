package kr.or.navi.mypagedetail.alarm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.navi.common.paging.BootstrapFormBasePaginationRenderer;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.common.paging.PaginationRenderer;
import kr.or.navi.mypagedetail.alarm.service.AlramService;
import kr.or.navi.security.RealUser;
import kr.or.navi.vo.AlarmVO;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.ProjectVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/mypage/alarm")
public class AlarmController {
	@Inject
	private AlramService service;
	@GetMapping
	public String mypageAlarm(@RealUser EmpVO realUser
			,@RequestParam Map<String, Object> detailCondition
			, @RequestParam(name="page", required = false, defaultValue = "1") int currentPage
			,Model model
	) {
		model.addAttribute("realUser", realUser);
		log.info("detailCondition : {}",detailCondition);
		PaginationInfo paging = new PaginationInfo(10,10);
		paging.setCurrentPage(currentPage);
		paging.setDetailCondition(detailCondition);
		List<AlarmVO> alarmList = service.retriveAlarmList(realUser.getEmpId(),paging);
		model.addAttribute("alarmList", alarmList);
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML",pagingHTML);
		model.addAttribute("paging",paging);
		return "mypage/alarm";
	}
	@PostMapping
	public Map<String, Integer> readAlramAll(@RealUser EmpVO realUser){
		int cnt=service.modifyReadAll(realUser.getEmpId());
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("cnt", cnt);
		return map;
	}
}
