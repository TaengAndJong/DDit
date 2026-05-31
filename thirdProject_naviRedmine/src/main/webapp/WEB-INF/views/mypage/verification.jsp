<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<style>
.icon.group{background-size:100%}
.card{padding: 60px 50px}
</style>

<div class="d-flex justify-content-center">
    <div class="card view-info border-white">
      
        <form:form class="commonForm" action="${pageContext.request.contextPath}/mypage/verification" method="post">
        
        	<div class="d-flex">
	        	<div class="icon-logo_custom">
	        	</div>
        	</div>
        	
        	<h5 class="mt-2 mb-4  GmarketSans border-top pt-5 border-white d-flex align-items-center fw-bold">
	        	<i class="icon group"></i><span>내 정보 수정 인증</span>
	        </h5>
        	<div class="searchBox input-info mt-3 text-center d-flex">
				<div class=" col-sm-9">
					<input type="password" title="비밀번호를 입력해주세요." placeholder="비밀번호를 입력해주세요." class="form-control" id="password" name="password" required autocomplete="new-password">
				</div>
				<button type="submit" class="btn btn-login btn-custom col-sm-3">확인</button>
			</div>
        
        </form:form>
        <c:if test="${not empty message}">
            <p>${message}</p>
        </c:if>
    </div>
</div>