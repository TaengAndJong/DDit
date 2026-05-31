package controller;

import java.util.HashMap;
import java.util.Map;

import service.CustomerService;
import service.LoginService;
import service.ReserveService;
import service.RoomProcess;
import service.SearchService;
import util.PrintUtil;
import util.RealUtil;
import util.ScanUtil;
import util.View;

public class controller {
	// 세션
	static public Map<String, Object> sessionStorage = new HashMap<>();

	/////
	CustomerService customerService = CustomerService.getInstance();
	LoginService loginService = LoginService.getInstance();
	ReserveService reserveService = ReserveService.getInstance();
	SearchService searchService = SearchService.getInstance();
	RoomProcess process = RoomProcess.getInstance();

	public static void main(String[] args) {
//		new PrintUtil().intro();
		new RealUtil().intro2();
		new controller().start();
	}

	private void start() { // view로 페이지별 메소드 선언 및 정의
	
		int view = View.HOME;
		while (true) {
			switch (view) {
			case View.HOME:
				view = home();
				break;
			case View.CUSTOMER_LOGIN:
				view = loginService.login();
				break;
			case View.CUSTOMER_SIGNUP:
				view = customerService.signUp();
				break;
			case View.CUSTOMER_UPDATE:
				view = customerService.infoUpdate();
				break;
			case View.RESERVE:
				view = reserveService.list();
				break;
			case View.RESERVEROOM_PROCESS:
				view = process.SelectRoomStart();
				break;

			case View.SEARCH_CHECK:
				view = searchService.reserve_check();
				break;
			case View.SEARCH_CANCEL:
				view = searchService.reserve_cancel();
				break;
			case View.SEARCH:
				view = reserve_list();
				break;
			}
		}
	}

	private int home() {
		// System.out.println(sessionStorage.get("login"));
		// System.out.println(sessionStorage.get("loginInfo"));

		System.out.println("::================ 대덕인재호텔키오스크  ================::");
		System.out.println();
		System.out.println("              1.로그인	    2.회원가입 	            ");
		System.out.println();
		System.out.println("::================================================::");
		System.out.print(" 번호입력 : ");
		switch (ScanUtil.nextInt()) {
		case 1:
			System.out.println();
			return View.CUSTOMER_LOGIN;
		case 2:
			System.out.println();
			return View.CUSTOMER_SIGNUP;

		default:
			System.out.println();
			return View.HOME;

		}
	}

	public int reserve_list() {
		System.out.println("::================ 대덕인재호텔키오스크  ================::");
		System.out.println();
		System.out.println("        1.예약조회                2.예약취소               3.뒤로가기                 ");
		System.out.println();
		System.out.println("::================================================::");
		System.out.print("번호 입력 :");
		switch (ScanUtil.nextInt()) {
		case 1:
			System.out.println();
			return View.SEARCH_CHECK;// 데이터베이스에 저장된 예약번호의 내용 출력
		case 2:
			System.out.println();
			return View.SEARCH_CANCEL;
		default:
			System.out.println();
			return View.RESERVE;
		}
	}

}