package service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import dao.ReserveDAO;
import util.DateUtil;
import util.ScanUtil;
import util.View;

public class RoomProcess {

	private static RoomProcess instance = null;

	private RoomProcess() {
	}

	public static RoomProcess getInstance() {
		if (instance == null)
			instance = new RoomProcess();
		return instance;
	}
	///////////////////////////////////////////////////////

	// 전역변수
	public int selectNum, childePerson, totalPerson, inputNum = 0;// 1
	public int defaultPerson = 2;

	// 사용할 객체
	GuestCount gestCount = GuestCount.getInstance();
	ReserveDAO dao = ReserveDAO.getInstance();
	GuestCount gsDate = GuestCount.getInstance();
	// dao의 list 불러오기 (Sql input에 필요)
	List<Map<String, Object>> list = dao.list();

	int pageNo = 0;

	// 방 예약시작 메소드
	public int SelectRoomStart() {
		// 1. 방 등급 선택
		// 문구 출력
		System.out.println("::===============  대덕인재호텔 객실예약   ===============::");
		System.out.println();
		System.out.println("          1.스탠다드             2.디럭스            3.프리미엄                    ");
		System.out.println();
		System.out.println("::================================================::");
		System.out.print("입력 : ");
		// input 정수값 입력
		selectNum = ScanUtil.nextInt();
		// selectNum의 값이 case에 해당하면 문구 출력
		switch (selectNum) {
		case 1:
			System.out.println();
			System.out.println("스탠다드룸 선택");
			break;
		case 2:
			System.out.println();
			System.out.println("디럭스룸 선택");
			break;
		// return returnValue = selectNum;
		case 3:
			System.out.println();
			System.out.println("프리미엄룸 선택");
			// return returnValue = selectNum;
			break;
		default:
			System.out.println();
			System.out.println("잘못 선택하셨습니다.");
			System.out.println();
			return View.RESERVEROOM_PROCESS;

		}

		// 방 등급 선택 후 roomType의 변수에 입력된 정수값 저장
		int roomType = selectNum;
		// 숫자로 된 문자열S , D, P 필요

		// 문자열 타입 방 등급 변수 선언 초기화
		int roomGrade = 0;
		// 방

		switch (roomType) {
		case 1:
			// 영문을 아스키코드값으로 반환
			roomGrade = 83; // 스탠다드룸 선택

			break;
		case 2:
			roomGrade = 68; // 디럭스룸 선택
			break;
		case 3:
			roomGrade = 80; // 프리미엄룸 선택
			break;

		default:
			System.out.println();
			System.out.println("존재하지 않는 방입니다."); // 기본방 등급은 S
			System.out.println();
			return View.RESERVEROOM_PROCESS;
		}
		// 방선택 switch END;

		// 방 등급에 따른 가격 반환

		// char 타입의 문자 s,p,d를 아스키코드값(int)로 받아서 가격 출력해주기
		// 등급에 따른 방 가격 변수 생성 및 초기화

		int roomPrice = 0; // 방가격 초기화값
		switch (roomGrade) {
		case 83:
			roomPrice = 50000; // 스탠다드룸 선택
			break;
		case 68:
			roomPrice = 100000; // 디럭스룸 선택
			break;
		case 80:
			roomPrice = 200000; // 프리미엄룸 선택
			break;

		default:
			System.out.println();
			System.out.println("해당하는 방 가격이 없습니다.");
			System.out.println();
			return View.RESERVEROOM_PROCESS;
		}
		// 방등급 가격 End

		// 캐릭터타입의 방등급
		char charGrade = ' ';
		if (roomGrade == 83) {
			charGrade = 'S'; // charGrade 변수에 저장해서 변환해줘야
		} else if (roomGrade == 68) {
			charGrade = 'D';
		} else {
			charGrade = 'P';
		}

		// 방등급에 따른 가격

		// 숙박인원수 선택 ( 여기로 charGrade 이 들어옴
		System.out.println();
		System.out.println("선택하신 방의 등급 :" + charGrade + "등급입니다. \n" + "가격 :" + roomPrice
				+ "(기본인원:2명), \n ※※ 2인 이상일 때, 1인당 1만원의 추가요금이 발생합니다 (영유아는 제외)  ※※");
		System.out.println();

		System.out.println("::===============  대덕인재호텔 객실예약   ===============::");
		System.out.println();
		System.out.println("                                          숙박인원 입력 기준 안내       ");
		System.out.println("                            일반 :성인과 청소년 , 영유아:5세 아동까지 ");
		System.out.println();

		gestCount.processRoomType(roomType, roomPrice, defaultPerson);

		/// 사용가능한 방 정보 가져오기

		System.out.println("::===============  대덕인재호텔 객실예약   ===============::");
		System.out.println();
		System.out.println(" 방 호수	방등급           가격 	 수용인원 	객실유무  ");
		System.out.println();
		System.out.println("::================================================::");
		System.out.println();
		List<Map<String, Object>> UseableList = dao.UseableList(roomType);


		for (Map<String, Object> room : UseableList) {

			System.out.print("  " + room.get("ROM_NO") + "   " + room.get("ROM_GRD") + " 	");
			System.out.printf("%-4s	%4s", room.get("ROM_PRICE"), room.get("ROM_PER"));
			if (room.get("STATUS") == null || room.get("STATUS").equals("O")) {
				System.out.println("\t  O");
			} else {
				System.out.println("\t  X");
			}

			System.out.println(" ");

		}
//			사용가능한 방정보 END

// 			방호수 선택
		System.out.println("::================================================::");
		System.out.print("방호수(ex:대문자 방번호) : ");
//		a ->  selectRoomNumber 이름 바꿈
		String selectRoomNumber = ScanUtil.nextLine();
		// STATUS가 X 이면 선택불가
	      // 방선택 범위 벗어남 (조건 : 호수는 1~5까지만 있어서 6이상이거나 null이면 조건 발동)
	      // selectRoomNumber의 값이 없거나 공백만 포함된 경우
	      if (selectRoomNumber == null || selectRoomNumber.trim().isEmpty()) {
	         // selectRoomNumber.isEmpty() 만 쓰면 안됨, trim()을 사용해 양쪽 공백을 삭제해야 함
	         System.out.println("입력된 방번호가 없습니다.");
	         return View.RESERVEROOM_PROCESS;
	      }
	      // 끝자리가 6이상일때
	      int lastChar = selectRoomNumber.charAt(selectRoomNumber.length() - 1) + 0;
	      // 아스키코드로 방 값 int타입으로 받아줌
	      if (lastChar >= 54) {
	         System.out.println(lastChar);
	         System.out.println("존재하지 않는 방번호입니다.");
	         return View.RESERVEROOM_PROCESS;
	      } else {
	         System.out.println("선택하신 방은 " + selectRoomNumber + "호 입니다.");
	      }

	      // 입력문자가 조건에 맞지 않을 때 END
		System.out.print("전화번호 : ");
		String resevTelNum = ScanUtil.nextLine();

		// 입력문자 오류 반환부분
		switch (selectRoomNumber) {// 예외경우 케이스문 : 값이 없을 때, 숫자일때 , 네자리가 아닐 떄?
		case "D301":

			break;
		}
		// 입력문자 오류 반환부분 END

//			숙박일자  선택
		// 예약한 시간, 체크인, 체크아웃 시간
		System.out.println("::===============  대덕인재호텔 객실예약   ===============::");
		System.out.println();
		System.out.println("  1.[ 1박 2일 ]  2.[ 2박 3일 ]  3.[ 3박 4일 ]  4.[ 돌아가기 ] ");
		System.out.println();
		System.out.println("::================================================::");
		System.out.print("숙박일 수 입력 :");
		int totalStay = ScanUtil.nextInt();// 머무를 일수

		int CheckinTime = 3;
		int CheckoutTime = 11;
		String checkin = DateUtil.checkInDate();
		String checkout = " ";

		switch (totalStay) {

		case 1:
			checkout = DateUtil.yearMonth() + DateUtil.Oneday();
			System.out.println("체크 인  시간 : " + checkin  + CheckinTime + "시 \n" + "체크아웃 시간 : " + checkout + "일 "
					+ CheckoutTime + "시\n" + "숙박일 수 :" + totalStay + "일 입니다.");
			break;
		case 2:
			checkout = DateUtil.yearMonth() + DateUtil.Twodays();
			System.out.println("체크 인  시간 : " + checkin  + CheckinTime + "시 \n" + "체크아웃 시간 : " + checkout + "일 "
					+ CheckoutTime + "시\n" + "숙박일 수 :" + totalStay + "일 입니다.");
			break;
		case 3:
			checkout = DateUtil.yearMonth() + DateUtil.Threedays();
			System.out.println("체크 인  시간 : " + checkin  + CheckinTime + "시 \n" + "체크아웃 시간 : " + checkout + "일 "
					+ CheckoutTime + "시\n" + "숙박일 수 :" + totalStay + "일 입니다.");
			break;
		case 4:
			System.out.println();
			return View.RESERVE;

		default:
			System.out.println();
			return View.HOME;

		}

		// 정확한 방번호를 입력하지 않으면 예약이 안됨
		System.out.println(selectRoomNumber + "호수를 예약시겠습니까? (Y/N)");
		System.out.print("입력 :");
		String RoomNumberInput = ScanUtil.nextLine();
		// 방선택 후 예약 하기끝

		// 예약생성구문
		int resNo = 0;
		int resultCount = 0;
		switch (RoomNumberInput) {
		case "Y": case "y":
			// 예약번호증가 ,
			resultCount = 1;
			// 예약넘버 문자열 변수선언 및 초기화
			String resStrNum = "";
			// int resNo
			String sql = "select a.res_no " + "  from (select res_no " + "   from reserve " + "order by 1 desc) a "
					+ " where rownum = 1 ";

			int res = 0;
			String resStr = "";
			Map<String, Object> result = dao.selectOne(sql);
			if (result == null) {
				resNo = 1;
				resStr = "000" + resNo;
			} else {
				resNo = Integer.parseInt((String) (result.get("RES_NO"))) + 1;
				String tt = String.valueOf(resNo);
				for (int i = 0; i < 4 - tt.length(); i++) {
					resStr = resStr + "0";
				}
				resStr = resStr + resNo;
			} 

			
//		if(RoomNumberInput.equalsIgnoreCase("Y")) {
//			// 예약번호증가 ,
//			resultCount = 1;
//			// 예약넘버 문자열 변수선언 및 초기화
//			String resStrNum = "";
//			// int resNo
//			String sql = "SELECT * FROM RESERVE";
//			Map<String, Object> result = dao.selectOne(sql);
//			resNo = Integer.parseInt((String) (result.get("RES_NO"))) + 1; // 테이블에서 인덱스 가져와서 1씩증가되게 해야함
//
//			// 문자 네 자리수를 만들려고 String 전환
//			String strLength = String.valueOf(resNo);
//			// 조건문을 통해 2,3자리 일 때 숫자증가
//			for (int i = 0; i < 4 - strLength.length(); i++) { // strLength.length() =1 , 초기화 변수가 1자리라서 , 3번 순환 되기
//																// 때문에
//				resStrNum = resStrNum + "0";
//			}
//
//			// resStr 의 0의 개수는 3개 + 기존문자1개 = 총 4자리수
//			resStrNum = resStrNum + resNo; // 문자 + 정수 = 정수? 근데 String 타입
//
			List<Object> seccessReserve = new ArrayList<>();
			// 처리 건수 1 고정반환
			

			String custel = resevTelNum;
			dao.seccessReserve(selectRoomNumber, custel, resStr, checkin, checkout, roomPrice);
			// 예약테이블에 먼저 데이터 넣기

			System.out.println("예약" + resultCount + "건이 완료되었습니다. 예약번호는 :" + resStr+ "입니다.");
		System.out.println();
			return  resultCount;
		}
		System.out.println();
		return View.HOME;
		}
		// SelectRoom process end;
		
	}

///// Class END;
