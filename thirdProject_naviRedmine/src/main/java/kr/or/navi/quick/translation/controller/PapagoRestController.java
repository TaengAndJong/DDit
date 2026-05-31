package kr.or.navi.quick.translation.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.navi.quick.translation.vo.TransVO;
import kr.or.navi.util.HttpUtil;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping
public class PapagoRestController {
	String clientId = "r3shn186hf";//애플리케이션 클라이언트 아이디값";
    String clientSecret = "jB9isCyIHO6sIe5twjIcKp1MwwBdnQkqMRSk06Yd";//애플리케이션 클라이언트 시크릿값";
    String apiURL = "https://naveropenapi.apigw.ntruss.com/nmt/v1/translation";
    
	/**
	 * 문자별 나라 파악을 위한 요청 응답 컨트롤러
	 * @param text 사용자로 부터 받은 문자
	 * @return api를 통해 받은 응답
	 */
	@GetMapping("/lang")
	@ResponseBody
    public Object callAPI(@RequestParam("text") String text){
		String checkURL = "https://naveropenapi.apigw.ntruss.com/langs/v1/dect";
        HashMap<String, Object> check = new HttpUtil()
				.header("X-NCP-APIGW-API-KEY-ID", clientId)
				.header("X-NCP-APIGW-API-KEY", clientSecret)
				.header("Content-Type","application/x-www-form-urlencoded;charset=UTF-8")
				.header("Accept","application/json;charset=UTF-8")
				.method("POST")
				.url(checkURL)
				.queryString("query", text)
				.build();
		return check;
	}
	
	/**
	 * 번역을 위한 컨트롤러
	 * @param source 번역할 문자(text)의 나라코드
	 * @param target 번역을 원하는 나라코드
	 * @param text 번역할 문자
	 * @return api를 통해 받은 응답
	 */
	@GetMapping("/trans")
	@ResponseBody
	public HashMap<String, Object> transf(String source, String target, String text){
		HashMap<String, Object> trans = new HttpUtil()
				.header("X-NCP-APIGW-API-KEY-ID", clientId)
				.header("X-NCP-APIGW-API-KEY", clientSecret)
				.header("Content-Type","application/x-www-form-urlencoded;charset=UTF-8")
				.body("source",source)
				.body("target",target)
				.body("text",text)
				.method("POST")
				.url(apiURL)
				.build();
		return trans;
	}
}
