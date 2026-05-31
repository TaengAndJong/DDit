<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form"  prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags"  prefix="spring"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!doctype html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><tiles:getAsString name="title" /></title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath }/resources/images/main/noImg.jpg" />
    <tiles:insertAttribute name="preScript" />
</head>
<body _c_t_j1="1">
<tiles:insertAttribute name="headerMenu" />
<tiles:insertAttribute name="subMenu"/>
<tiles:insertAttribute name="contentPage"/>
<tiles:insertAttribute name="footer"/>
<tiles:insertAttribute name="postScript"/>
</body>

</html>