   <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<link type="text/css" rel="stylesheet" href="<c:url value='/resources/css/chat/error.css'/>"/>
<div class="mainbox">
	<div class="err">4</div>
		<div class ="far"><img src="${pageContext.request.contextPath}/resources/images/main/objBlue.png"></div>
	<div class="err2">4</div>
	<div class="msg">
		<p class ="page">PAGE NOT FOUND</p>
		<p>
			<a href="${pageContext.request.contextPath}">RETURN HOME</a>
		</p>
	</div>
</div>