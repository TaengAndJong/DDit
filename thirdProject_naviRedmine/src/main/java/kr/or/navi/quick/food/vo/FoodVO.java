package kr.or.navi.quick.food.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

import kr.or.navi.quick.book.vo.BookVO;
import kr.or.navi.vo.WeatherVO;
import lombok.Data;
import lombok.EqualsAndHashCode;


@Data
@EqualsAndHashCode(of= {"foodId"})
public class FoodVO implements Serializable {
	
	@NotBlank
	private String foodId;//단건 조회, 특정대상 조회 할 식별자 변수
	@NotBlank
	private String foodPlace;// 음식점
	@NotBlank
	private String foodName; // 음식점이름
	private String foodImgUrl; // 음식점 이미지
	@Pattern(regexp="^[0-9\\-]*$")
	private String foodTel;// 음식점 전화번호
	private String foodAddr;// 음식점 주소
	private String foodOpenTime;// 음식점 오픈시간
	private String foodCloseTime;// 음식점 마감시간
	private String weatherId;
	private String empId;
	private String age;
	private String gen;
	
	//private WeatherVO weather;//날씨데이터 맵핑할 VO
	
	
	
	
}
