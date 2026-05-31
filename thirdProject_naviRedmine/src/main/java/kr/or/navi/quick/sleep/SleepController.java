package kr.or.navi.quick.sleep;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.navi.security.RealUser;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping
public class SleepController {
	
	@GetMapping("/sleepAlarm")
	public String test(@RealUser EmpVO realUser, Model model) {
		
		String empName = realUser.getEmpName();
		model.addAttribute("empName", empName);
		return "chat/sleepAlarm";
	}
	
}