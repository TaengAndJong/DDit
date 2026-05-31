<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="login border formBox" id="submitForm" action="">
	<strong class="tit fs-5">교수용 로그인</strong>
	<form class="form-inline">
		<!-- 데이터 전송용 -->
		<input type="hidden" name="searchType" value="${condition.proNo}" />
		<!-- 데이터 전송용 -->
		<div class="form-group">
			<label for="loginID" class="sr-only">Password</label> <input
				type="text" class="form-control" id="loginID" value="${proNo}"
				name="proNo" placeholder="교수번호입력">
		</div>
		<input type="submit" id="loginBtn" class="btn btn-primary ml-1"
			value="로그인">
	</form>
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
</div>
