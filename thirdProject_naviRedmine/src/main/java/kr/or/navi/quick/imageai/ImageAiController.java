package kr.or.navi.quick.imageai;

import java.util.HashMap;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.navi.util.HttpUtil;

@Controller
public class ImageAiController {
	String url = "http://127.0.0.1:5000/";
	String apiKey = "4435add9fef7c0694f63c5dcaf2d3582";
	@GetMapping("/quick/imageai")
	public Object prompt(@RequestParam("prompt") String prompt) {
		HashMap<String, Object> build = new HttpUtil()
		.header("Accept", "application/json")
		.queryString("prompt", prompt)
		.url("http://127.0.0.1:5000")
		.method("get")
		.build();
		return build;
	}
}
