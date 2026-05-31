package kr.or.navi.sub;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/sub/sub01.do")
@Slf4j
public class subController {
	@GetMapping
	public String sub() {
		return "chat/sub01";
	}
}
