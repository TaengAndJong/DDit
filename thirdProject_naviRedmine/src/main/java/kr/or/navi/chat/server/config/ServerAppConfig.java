package kr.or.navi.chat.server.config;

import java.util.Map;

import javax.websocket.server.ServerEndpointConfig.Configurator;

import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

/**
 * @Class Name : ServerAppConfig.java
 * @Description : EndPoint를 bean으로 담기 위해 설정하는 Configurator
 */
public class ServerAppConfig extends Configurator {

	@Override
	public <T> T getEndpointInstance(Class<T> endpointClass) throws InstantiationException {
		System.err.println("41195615691691" + endpointClass);
		// 현재 웹 애플리케이션 컨텍스트를 가져옴
		WebApplicationContext wac = ContextLoader.getCurrentWebApplicationContext();
		if (wac == null) {
			// WebApplicationContext를 찾을 수 없는 경우 예외를 발생
			throw new IllegalStateException("Failed to find WebApplicationContext");
		}
		// 해당 클래스의 빈들을 가져옴
		Map<String, T> beans = wac.getBeansOfType(endpointClass);
		System.err.println("beans" + beans);
		if (beans.isEmpty()) {
			// 빈이 없는 경우 새로운 빈 인스턴스를 초기화
			return wac.getAutowireCapableBeanFactory().createBean(endpointClass);
		}
		if (beans.size() == 1) {
			// 일치하는 빈 인스턴스를 반환
			return beans.values().iterator().next();
		} else {
			throw new IllegalStateException("Found more than one matching beans of type " + endpointClass);
		}
	}
}