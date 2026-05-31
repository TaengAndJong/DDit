package kr.or.navi.quick.translation.controller;

import static org.junit.jupiter.api.Assertions.*;

import java.util.HashMap;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;

import kr.or.navi.AbstractRootContextTest;
import kr.or.navi.util.HttpUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
class PapagoRestControllerTest extends AbstractRootContextTest{
	String clientId = "r3shn186hf";//애플리케이션 클라이언트 아이디값";
    String clientSecret = "jB9isCyIHO6sIe5twjIcKp1MwwBdnQkqMRSk06Yd";//애플리케이션 클라이언트 시크릿값";
    String apiURL = "https://naveropenapi.apigw.ntruss.com/nmt/v1/translation";
    String checkURL = "https://naveropenapi.apigw.ntruss.com/langs/v1/dect";

	@Test
	void test() {
		HashMap<String, Object> check = new HttpUtil()
				.header("X-NCP-APIGW-API-KEY-ID", clientId)
				.header("X-NCP-APIGW-API-KEY", clientSecret)
				.header("Content-Type","application/x-www-form-urlencoded;charset=UTF-8")
				.header("Accept","application/json;charset=UTF-8")
				.method("POST")
				.url(checkURL)
				.queryString("query", "안녕")
				.build();
		log.info("check : {}",check.get("body"));
	}
	@Test
	void test122() {
		log.info("!!!!!!!!!!!!!!!!!!!!!!!!!1");
		log.info("!!!!!!!!!!!!!!!!!!!!!!!!!1");
		log.info("!!!!!!!!!!!!!!!!!!!!!!!!!1");
		log.info("!!!!!!!!!!!!!!!!!!!!!!!!!1");
		HashMap<String, Object> trans = new HttpUtil()
				.header("X-NCP-APIGW-API-KEY-ID", clientId)
				.header("X-NCP-APIGW-API-KEY", clientSecret)
				.header("Content-Type","application/x-www-form-urlencoded;charset=UTF-8")
				.header("Accept","application/json;charset=UTF-8")
				.method("POST")
				.queryString("source","kr")
				.queryString("target","en")
				.queryString("text","안녕")
				.url(apiURL)
				.build();
		log.info("check : {}",trans);
	}

}
