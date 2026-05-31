package service;


import java.util.List;
import java.util.Map;

import dao.ReserveDAO;
import util.ScanUtil;
import util.View;
import util.JDBCUtil;


public class GuestCount{
	
	private static GuestCount instance= null;
	private GuestCount() {}
	public static GuestCount getInstance() {
		if (instance == null)
			instance = new GuestCount();
		return instance;
	}
	

	JDBCUtil jdbc = JDBCUtil.getInstance();
	ReserveDAO dao = ReserveDAO.getInstance();
	List<Map<String, Object>> list = dao.list();
	
 int totalPerson=0;
int addPay,totalPay,childePerson= 0;

 // 매개변수는 RoomProcess에서 초기값을  받아옴
	public int processRoomType(int roomType, int RoomPrice, int defaultPerson) {
	    int maxPerson = 0;

	    switch (roomType) {
	        case 1:
	            maxPerson = 4;
	            break;
	        case 2:
	            maxPerson = 5;
	            break;
	        case 3:
	            maxPerson = 6;
	            break;
	        default:
	            System.out.println("잘못된 방 타입입니다.");
	            return View.RESERVE;
	    }

	    System.out.println("             숙박인원수는  기본인원:" + defaultPerson + "(명) | 최대인원 : " + maxPerson + "명 입니다.");
	    System.out.println();
	    System.out.println("::================================================::");
	    System.out.println("일반인원 수를 선택 :  1.(1명)\t 2.(2명)\t 3.(3명)\t 4.(4명)");
	    System.out.print("일반인원 수 : ");
	    System.out.println();
	    int selectNum = ScanUtil.nextInt();
	    System.out.println();
	
		
		return GuestCount(selectNum, maxPerson, RoomPrice,defaultPerson,childePerson,totalPerson,addPay,totalPay);
	}
	
//		방 숙박인원(일반 ,영유아 , 총인원) ,인원에 따른 1박 결제요금
		public int GuestCount(int adultPerson, int maxPerson, int RoomPrice, int defaultPerson,int childePerson,int totalPerson,int addPay,int totalPay) {
		
	

	    if (adultPerson == maxPerson) { // 여기가 참이면 여기까지만 작동
	       
	        childePerson= 0;
	        totalPerson = adultPerson;
	        addPay=(10000 * (totalPerson-defaultPerson));
	        totalPay = addPay+RoomPrice;
	        		
	        System.out.println("정원이 다 예약되었습니다. \n 총 숙박인원 : " + totalPerson + "명\n  추가 인원 요금 : "
	        +addPay+"원 , 1박 결제요금 : " + totalPay + "입니다.");
	        
	        return  View.RESERVE;// 예약 가능한 방 조회로 이동
	        
	    } else if (adultPerson > 0 && adultPerson < maxPerson) {
	    	adultPerson = adultPerson; // 일반인원 총 수 
	        System.out.println("일반 수는 " + adultPerson + "명 입니다."); // 일반인원 총 수 출력 
	
	        //최대인원에서 일반인원수를 뺴줘야 나머지 영유아 인원석택가능
	        maxPerson = maxPerson - adultPerson;
	        System.out.println("::===============  대덕인재호텔 객실예약   ===============::");
	        System.out.println("                                        ");
	        System.out.println("    1.(0명)   2.(1명)   3.(2명)   4.(3명)   5.(4명)    ");
	        System.out.println("                                        ");
	        System.out.println("::================================================::");
	        //영유아가 없을 수도 있어서 -1
	        System.out.print("영유아 수 :");
	         	childePerson = ScanUtil.nextInt()-1;
	         	System.out.println();
	        if (childePerson >= 0 && childePerson <= maxPerson) {
	        	
	            totalPerson = childePerson + adultPerson;
	            
	            if(adultPerson <=2) {
	            	addPay = 0;
	            	totalPay = RoomPrice;
//	            	System.out.println("값들어오는지 확인");
	            }else{
//	            	System.out.println("값들어오는지 확인");
	            	  addPay = (10000 * (adultPerson-defaultPerson));
	            	  totalPay=RoomPrice+addPay;
	            }
	          
	            System.out.println("  영유아 : " + childePerson + "명, 총 숙박인원 : " + totalPerson + "명입니다.\n "
	                    + " 추가 인원 요금 : " + (addPay <= 0 ? 0 : (0 < addPay ? addPay : 0))+ "원 \n 1박 결제요금: " + totalPay + "입니다.");
	        }
	    }
	    System.out.println();
	    return View.RESERVE;
	}


	
}
