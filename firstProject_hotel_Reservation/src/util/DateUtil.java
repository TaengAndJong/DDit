package util;

import java.time.LocalDateTime;

public class DateUtil {

	static LocalDateTime localDataTime = LocalDateTime.now();
	static int year = localDataTime.getYear();
	static int month = localDataTime.getMonthValue();
	static int day = localDataTime.getDayOfMonth();
	static int hour = localDataTime.getHour();
	
	static int staydate = 0;
	static int startday = DateUtil.startDay();
	
	//문자열 년월일시
	public static String strReserveTime() {
		String strYear = String.valueOf(year);
		String strMonth = String.valueOf(month);
		String strDay = String.valueOf(day);
		String strHour = String.valueOf(hour);

		return strYear + "년 " + strMonth + "월 " + strDay + "일 " + strHour + "시";

	}

	//문자열 년월일
	public static String checkInDate() {

		String strYear = String.valueOf(year);
		String strMonth = String.valueOf(month);
		String strDay = String.valueOf(day);
		return strYear + "년 " + strMonth + "월 " + strDay + "일 ";

	}
	

	
	public static String strCurYear() {
		String strYear = String.valueOf(year);
		return strYear;
	}
	
	
	//문자열 월까지
	public static String strCurMonth() {
		String strMonth = String.valueOf(month);
		return strMonth;
	}
	
	//문자열 년월
	public static  String yearMonth() {
		return strCurYear() + "년 " + strCurMonth() + "월 ";
	}
	
	//문자열 시간만
	public static String strCurHour() {
		String strHour = String.valueOf(month);
		return strHour;
	}
	
	
	
	//정수타입 체크인 일만
	public static int startDay() {
		int startday = day;
		return startday;
	}
	
	
//	숙박일자 메소드
	public static int Oneday() {
		staydate = DateUtil.startDay() + 1;
		return staydate;
	}

	public static int Twodays() {
		staydate = DateUtil.startDay() + 2;
		return staydate;
	}

	public static int Threedays() {
		staydate = DateUtil.startDay() + 3;
		return staydate;
	}
	
	
	//정수타입 퇴실일자
/*	public static int endDay() {
		
		
		
		
	return endDay;
	}*/
	

	
	public static void main(String[] args) {
	
		System.out.println(startDay());
	}

}
