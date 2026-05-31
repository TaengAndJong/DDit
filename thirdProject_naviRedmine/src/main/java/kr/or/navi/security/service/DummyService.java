package kr.or.navi.security.service;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import kr.or.navi.security.EmpVOWrapper;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class DummyService {
	public void dummyLogic() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		EmpVOWrapper principal = (EmpVOWrapper) authentication.getPrincipal();
		EmpVO realUser = principal.getRealUser();
		log.info("현재 로그인되어있는 사용자 : {}",realUser.getEmpName());
	}
}
