<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학사관리프로그램-240102</title>
<jsp:include page="/WEB-INF/includee/preScript.jsp" />
</head>
<body data-context-path="${pageContext.request.contextPath}">
<%-- 상단메뉴는 바디안에 있어야야함 --%>
	<header>
		<jsp:include page="/WEB-INF/includee/headerMenu.jsp" />
	</header>
	<div class="wrap">
		<jsp:include page="${contentPage}"/>
	</div>

<jsp:include page="/WEB-INF/includee/postScript.jsp" />
</body>
</html>