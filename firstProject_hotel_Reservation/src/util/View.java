package util;

public interface View {
	int HOME = 1;
	// 고객
	int CUSTOMER = 2; // 기존데이터
	int CUSTOMER_SIGNUP = 21; // 회원가입
	int CUSTOMER_LOGIN = 22; // 로그인
	int CUSTOMER_UPDATE = 23;	// 회원정보수정
	
	// 예약
	int RESERVE = 3; // 예약메뉴
	int RESERVE_ROOM = 31; // 방 데이터 출력, 방 예약하기
	int RESERVEROOM_PROCESS = 32;
	int RESERVEROOM_LIST = 33;
	int RESERVE_LIST = 34; // 예약목록조회
	int RESERVE_CANCEL = 35; // 예약취소 =>홈으로

	// 객실
	int ROOM = 4;
	int ROOM_GRADE = 41;// 객실등급
	int ROOM_NUMBER= 42;//객실호수(정보)
	int ROOM_PRICE = 43;// 객실가격
	int ROOM_PERSON = 44;// 수용인원
	// 객실예약
	
	int SEARCH = 5;
	int SEARCH_CHECK = 51;
	int SEARCH_CANCEL = 52;
			
	

	int PAY_TOTAL = 6;// 총결제금액
	

}
