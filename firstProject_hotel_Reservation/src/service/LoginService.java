package service;

import java.util.Map;

import controller.controller;
import dao.LoginDAO;
import util.ScanUtil;
import util.View;

public class LoginService {
		//싱글톤 패턴을 만든다.
	private static LoginService instance = null;
	private LoginService() {}
	public static LoginService getInstance() {
		if(instance == null)
			instance = new LoginService();
		return instance;
	}
	
	public static int LoginCount = 0;
	
	//Dao를 부른다
	LoginDAO dao = LoginDAO.getInstance();
	int pageNo = 0;
	
	public int login() {
		System.out.println("::===============  대덕인재호텔 키오스크   ===============::");
		System.out.println();
		System.out.print("이      름 : ");
		String name = ScanUtil.nextLine();
		System.out.println();
		System.out.print("전화번호 : ");
		String tell = ScanUtil.nextLine();
		
		Map<String, Object> result = dao.login(name, tell);
		
		if(result != null && result.get("CUS_TEL").equals(tell)) {
			controller.sessionStorage.put("login",true);
			controller.sessionStorage.put("loginInfo",result);
			System.out.println();
			System.out.println("::================================================::");
			System.out.println();
			System.out.println("어서오십시오 "+result.get("CUS_NAME") +"님  오늘도 좋은하루 되시길 바랍니다." );
			System.out.println();
			pageNo = View.RESERVE;
		}else {
			System.out.println();
				System.out.println("다시 로그인해주세요!");
				pageNo = View.HOME;
		}
		return pageNo;
	}
}
