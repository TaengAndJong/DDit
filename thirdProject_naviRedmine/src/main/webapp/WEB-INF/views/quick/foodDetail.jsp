<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form"  prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags"  prefix="spring"%>

<%-- 추천상세 --%>
<div class="view detail recomView" id="foodRecomView">
   <div class="view_inner d-flex">
	   <%-- 이미지 --%>
	    <div class="view-img">
			<div class="img-in no-img">
				<img src="${foodInfo.foodImgUrl}" class="card-img-top" alt="${foodInfo.foodPlace}${foodInfo.foodName}">
			</div>
	    </div>
	  	<%-- 이미지 --%>
	   	<%-- 정보 --%>
		<div class="view-content">
		    <strong class="view-tit d-flex align-items-center">${foodInfo.foodName}</strong>
		     <ul class="ul clearfix">
		       <li>
					<span class="list-tit">
						<i class="icon market_b"></i>
						가게명
					</span>
					${foodInfo.foodPlace}
				</li>
				<li>
					<span class="list-tit">
						<i class="icon placemarker_b"></i>
						주소
					</span>
					
					${foodInfo.foodAddr}
				</li>
				<li>
					<span class="list-tit">
						<i class="icon tel_b"></i>
						전화번호
					</span>
					${foodInfo.foodTel}
				</li>
				<li>
					<span class="list-tit">
						<i class="icon time_b"></i>
						영업시간
					</span>
					${foodInfo.foodOpenTime}
				</li>
				
				<c:if test="${not empty foodInfo.foodCloseTime}">
				<li>
					<span class="list-tit">
						<i class="icon time_b"></i>
						마감시간
					</span>
					${foodInfo.foodCloseTime}
				</li>
				</c:if>
		    </ul>
		</div>
	 	<%-- 정보 --%>
	</div>
  
</div>
<%-- 추천상세 --%>
<%-- 버튼 --%>
<div class="btn-box clearfix mt-4">
    <div class="right float-end">
    	<a  href="<c:url value='/quick/food'/>" class="btn btn-secondary" id="btnList">목록</a>
    </div> 
</div>
<%-- 버튼 --%>
