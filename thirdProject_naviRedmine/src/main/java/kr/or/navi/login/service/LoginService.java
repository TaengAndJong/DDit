package kr.or.navi.login.service;

import java.util.Map;

import kr.or.navi.vo.EmpVO;

public interface LoginService {
	public Map<String, String> checkAuthEmpId(EmpVO emp);
	public Map<String, String> checkAuthEmpPs(EmpVO emp);
}
