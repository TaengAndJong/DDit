package service;

//import java.util.Map;

//import java.util.ArrayList;
//import util.DateUtil; // 시간데이터 공통으로 사용파일
//import java.util.List;
//import java.util.Map;

import dao.ReserveDAO;
import util.ScanUtil;
import util.View;

public class ReserveService {
	
	private static ReserveService instance = null;

	private ReserveService() {}

	public static ReserveService getInstance() {
		if (instance == null)
			instance = new ReserveService();
		return instance;
	}

	ReserveDAO dao = ReserveDAO.getInstance();
	RoomProcess process = RoomProcess.getInstance();
	
	public int list() {
		
		System.out.println("::===============  대덕인재호텔 키오스크   ===============::");
		System.out.println();
		System.out.println("     1.방선택         2.예약조회          3.회원정보수정          4.종료           ");
		System.out.println();
		System.out.println("::================================================::");
		while (true) {
			System.out.print("원하시는 메뉴의 번호를 입력해주세요 :");
			System.out.print(" ");
			switch (ScanUtil.nextInt()) {
			case 1:
				System.out.println();
				process.SelectRoomStart();
				return View.RESERVE; // 방예약하는 곳으로 넘어감
			case 2:
				System.out.println();
				return View.SEARCH;
			case 3:
				System.out.println();
				return View.CUSTOMER_UPDATE;//
			case 4:
				System.out.println();
				System.out.println("감사합니다. 안녕히가십시오 ^-^");
				System.exit(0);
			}
			break;
		}
		System.out.println();
		return View.RESERVE; // 수정

	}


	
}
	