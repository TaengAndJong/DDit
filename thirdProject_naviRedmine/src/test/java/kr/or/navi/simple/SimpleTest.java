package kr.or.navi.simple;

import java.util.ArrayList;
import java.util.List;

public class SimpleTest {
	public static void main(String[] args) {
		
		List<String> lines = new ArrayList<String>();
		
		for(int i=0; i<10; i++) {
			lines.add("테스트" + (i+1));
		}
		
//		boolean isFind = false;
//		isFind = lines.contains("테스트3");
//		for(String line:lines) {
//			if(line.equals("테스트3")) {
//				isFind = true;
//			}
//		}
//		
//		if(isFind) {
//			System.out.println("데이터있음");
//		}else {
//			System.out.println("데이터없음");
//		}
		
		List<SimpleVO> simpleVOList = new ArrayList<SimpleVO>();
		
//		SimpleVO simpleVO = null;
//		for(int i = 0; i<10; i++) {
//			simpleVO = new SimpleVO();
//			simpleVO.setName("홍길동" + (i+1));
//			simpleVO.setAddress("대전"+(i+1));
//			simpleVO.setAge(10+i);
//			simpleVOList.add(simpleVO);
//		}
//		
		// 데이터 찾기를 위한 파라미터용
//		simpleVO = new SimpleVO();
//		simpleVO.setName("홍길동3");
//		simpleVO.setAddress("대전3");
//		
//		boolean isFind = false;
//		isFind = simpleVOList.contains(simpleVO);
//		
////		for(SimpleVO listSimpleVO: simpleVOList) {
////			if(listSimpleVO.getName().equals(simpleVO.getName())
////					&& listSimpleVO.getAddress().equals(simpleVO.getAddress())) {
////				isFind = true;
////			}
////		}
//	
//		
//		if(isFind) {
//			System.out.println("데이터있음");
//			int index = simpleVOList.indexOf(simpleVO);
//			if(index > -1) {
//				System.out.println(simpleVOList.get(index));
//			}
//		}else {
//			System.out.println("데이터없음");
//		}
//		
		
//		String name = "홍길동";
//		String name = null;
//		
//		System.out.println("홍길동".equals(name)); // 시큐어코딩 가이드에 따른 수정
//
//		System.out.println(name.equals("홍길동"));
	}
}

