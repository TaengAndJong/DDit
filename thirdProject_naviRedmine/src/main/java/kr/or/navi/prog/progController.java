package kr.or.navi.prog;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class progController {
	@GetMapping("/prog")
	public void prog() {
		log.info("prog  페이지 로드");
	}
}
