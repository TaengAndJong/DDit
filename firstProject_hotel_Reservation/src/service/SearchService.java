package service;

import java.util.Map;

import controller.controller;
//import dao.ReserveDAO;
import dao.SearchDAO;
import util.JDBCUtil;
import util.ScanUtil;
import util.View;

public class SearchService {
	JDBCUtil jdbc = JDBCUtil.getInstance();
	SearchDAO reservdao = SearchDAO.getInstance();
	
	private static SearchService instance = null;

	private SearchService() {
	}

	public static SearchService getInstance() {
		if (instance == null)
			instance = new SearchService();
		return instance;
	}
	
	
	public int reserve_check() {
		
		System.out.println("::===============  대덕인재호텔 예약조회   ===============::");
		System.out.println();
		System.out.print("예약번호 : ");
		String num = ScanUtil.nextLine();
		System.out.println();
		Map<String, Object> result = reservdao.search(num);

		if (result != null && result.get("RES_NO").equals(num)) {
			controller.sessionStorage.put("reserve_list", true);
			System.out.println("::===============  대덕인재호텔 예약조회   ===============::");

			System.out.println();

//			Object ad = result.get("RMADDPER");
//			int b = 0;
//
//			if (ad instanceof Integer) {
//				int adValue = (int) ad;
//				if (adValue == 0) {
//					b = 0;
//				} else if (adValue == 1) {
//					b = 1;
//				} else if (adValue == 2) {
//					b = 2;
//				} else if (adValue == 3) {
//					b = 3;
//				} else if (adValue == 4) {
//					b = 4;
//				}
//			} else if (ad instanceof String) {
//				String adValue = (String) ad;
//				if (adValue.equals("0")) {
//					b = 0;
//				} else if (adValue.equals("1")) {
//					b = 1;
//				} else if (adValue.equals("2")) {
//					b = 2;
//				} else if (adValue.equals("3")) {
//					b = 3;
//				} else if (adValue.equals("4")) {
//					b = 4;
//				}
//			}

			System.out.print("예약번호  :" + result.get("RES_NO") + "        "+'\t');

			System.out.println("예약자명  :" + result.get("CUS_NAME"));
			System.out.println();
			System.out.print("객실 번호 :" + result.get("ROM_NO") + "     " + '\t');
			
			System.out.print("총 금액    :" + result.get("RES_PRICE") + '\n');
			//System.out.println("인원수   :" + (2) + '\n');

			System.out.println();
		
			System.out.print("입실일    :" + result.get("CHECKIN") + "     " + '\t');
			System.out.println("퇴실일    :" + result.get("CHECKOUT") + "     " + '\t');
			System.out.println();

			return View.RESERVE;

		} else {
			System.out.println("등록된 예약이 없습니다.");

			return View.RESERVE;
		} // return View.HOME;
	}

	public int reserve_cancel() {
		System.out.println("::===============  대덕인재호텔 예약취소   ===============::");
		System.out.println();
		System.out.print("예약번호 :");
		String resno = ScanUtil.nextLine();
		

		Map<String, Object> result1 = reservdao.searchreserve(resno);
		
		
		
		if (result1 != null || result1.get("RES_NO").equals(resno)) {
		
			int result = reservdao.cancel(resno);
			System.out.println(resno+"의 예약이 취소되었습니다.");
			System.out.println();
			return View.RESERVE;// 로그인 완료 후 화면으로 리턴
		} else {
			System.out.println("등록된 예약번호가 없습니다." + '\n');
			System.out.println();
			return View.RESERVE;
		}
		// return View.CUSTOMER;

	}
///
}	
	
	
	
	
	
	

