package dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import util.JDBCUtil;


public class ReserveDAO {
	private static ReserveDAO instance = null;

	private ReserveDAO() {
	}

	public static ReserveDAO getInstance() {
		if (instance == null)
			instance = new ReserveDAO();
		return instance;
	}

	JDBCUtil jdbc = JDBCUtil.getInstance();

	public List<Map<String, Object>> list() {
		return jdbc.selectList("SELECT * FROM ROOM ORDER BY ROM_PRICE,ROM_NO");

	}
	
//	등급(수용인원)에 따른 방 조회 메서드
	public List<Map<String, Object>> UseableList(int roomType) {
		
		 char charGrade = ' ';
	    if(roomType==1) {
	        charGrade = 'S'; //charGrade 변수에 저장해서 변환해줘야 
	    } else if (roomType==2) {
	        charGrade = 'D';
	    } else {
	        charGrade = 'P';
	    }
	    
	    //System.out.println("가져오는 방등급값  확인하기"+charGrade);
		//ROM_PER 방의 타입 가져오기 M
		return jdbc.selectList("SELECT * FROM ROOM WHERE ROM_GRD='"+charGrade +"' ORDER BY ROM_PRICE,ROM_NO");

	}
	
	
	//예약번호만 예약테이블에 넣으려면

	
	public int statusUpdate(String romNo){
		String sql = "UPDATE ROOM SET STATUS = 'X' WHERE ROM_NO = ?";
		List<Object> param = new ArrayList<Object>();
		param.add(romNo);
//		System.out.println(romNo);
//		System.out.println(jdbc.update(sql, param));
		return jdbc.update(sql, param) ;
		
		// 퇴실일 11시 넘으면  o -> x 로 변경
		
		
	}
	

	
   public Map<String, Object> selectOne(String sql){
	      return jdbc.selectOne(sql);
   }
   
   // 결과 가져와 여기서 ?
//   public int seccessReserve(List<Object> seccessReserve) {
//	   
//	   return jdbc.update("INSERT INTO RMRES(ROM_NO,CUS_TEL, RES_NO, CHECKIN, CHECKOUT, RES_PRICE,ADDPER) VALUES(?,?,?,?,?,?,?)", seccessReserve);
//   }
//   
   //반환값 타입확인하고 여기도 맞춰주기
  public int seccessReserve(String selectRoomNumber, String custel,String resStr, String checkin, String checkout,int price){

	   String sql = "INSERT INTO RESERVE(ROM_NO, CUS_TEL, RES_NO, CHECKIN, CHECKOUT, RES_PRICE) VALUES(?,?,?,?,?,?)";
	    List<Object> param = new ArrayList<Object>();
	    param.add(selectRoomNumber);
	    param.add(custel);
	    param.add(resStr);
	    param.add(checkin);
	    param.add(checkout);
	    param.add(price);
	    
//		반환하는 값의 타입 먼저 확인하기
	    return jdbc.update(sql, param);
	    
	}
   
//   public int seccessReserve(String selectRoomNumber, String custel, String resStrNum, String checkin, String checkout, int price) {
//	    String sql = "INSERT INTO RESERVE(ROM_NO, CUS_TEL, RES_NO, CHECKIN, CHECKOUT, RES_PRICE) VALUES(?,?,?,?,?,?)";
//	    List<Object> param = new ArrayList<Object>();
//	    param.add(selectRoomNumber);
//	    param.add(custel);
//	    param.add(resStrNum);
//	    param.add(checkin);
//	    param.add(checkout);
//	    param.add(price);
//
//	    return jdbc.update(sql, param);
//	}
  

}
