<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="login border formBox">
	<strong class="tit fs-5">학생용 로그인</strong>
	<form id="submitForm" class="form-inline" method="post"
		action="${pageContext.request.contextPath}/student/studentCheck.do"
		enctype="application/x-www-form-urlencoded">
		<div class="form-group">
			<label for="loginID" class="sr-only">학생번호</label> <input type="text"
				class="form-control" id="loginID" name="stdNo" placeholder="학생번호입력">
		</div>
		<input type="submit" id="loginBtn" class="btn btn-primary ml-1"
			value="로그인">
	</form>
	
	<c:choose>
		<c:when test="${not empty message && not empty message.trim()}">
			<div class="info-box p-3 mt-3">
				<div class="info-inner flex">
					<i class="icon"> <svg xmlns="http://www.w3.org/2000/svg"
							width="16" height="16" fill="currentColor"
							class="bi bi-info-circle-fill" viewBox="0 0 16 16">
	                        <path
								d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16m.93-9.412-1 4.705c-.07.34.029.533.304.533.194 0 .487-.07.686-.246l-.088.416c-.287.346-.92.598-1.465.598-.703 0-1.002-.422-.808-1.319l.738-3.468c.064-.293.006-.399-.287-.47l-.451-.081.082-.381 2.29-.287zM8 5.5a1 1 0 1 1 0-2 1 1 0 0 1 0 2" />
	                    </svg>
					</i> <span>${message}</span>
				</div>
			</div>
			<c:remove var="message" scope="session" />
		</c:when>
		<c:otherwise>
			<!-- message가 비어있거나 공백인 경우 아무것도 출력되지 않음 -->
			<c:remove var="message" scope="session" />
		</c:otherwise>
	</c:choose>


</div>
<script>
let form = $("form").attr("id");
let btn = $("#submitForm").find("[type='submit']");
let submitForm = "#"+form;
console.log(submitForm)
$(btn).on("click",function(event){//이벤트버블링 제한 : 버튼으로 제한
	event.preventDefault;
	
	$(submitForm).submit();
	
	return false;
	
});

</script>



