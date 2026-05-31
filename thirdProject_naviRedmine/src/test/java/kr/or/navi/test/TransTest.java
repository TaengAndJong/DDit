package kr.or.navi.test;

import static org.junit.jupiter.api.Assertions.*;

import java.util.Locale;

import org.junit.jupiter.api.Test;

import lombok.extern.slf4j.Slf4j;

@Slf4j
class TransTest {

	@Test
	void test() {
		String[] isoCountries = Locale.getISOCountries();
		String[] isoLanguages = Locale.getISOLanguages();
		for(String a : isoLanguages) {
			log.info("isoc : {}",a);
		}
	}

}
