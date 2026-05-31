<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form"  prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags"  prefix="spring"%>
    <%@ taglib uri="http://www.springframework.org/security/tags"  prefix="security"%>
<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0,shrink-to-fit=no">
	<meta http-equiv="X-UA-compatible" content="IE=edge">
	<%-- meta --%>
	<meta name="title" content="SKJ-Project Management System">
	<meta name="author" content="SKJ 대덕인재개발원 3조">
	<meta name="keywords" content="SKJ-Project Management System, PMS">
	<meta name="description" content="대덕인재개발원 인공지능AI반 최종프로젝트 PMS 3조 SKJ">
	<meta name="copyright" content="대덕인재개발원 인공지능AI반 최종프로젝트 PMS 3조 SKJ">
	<%-- meta --%>
	<%-- og  --%>
	<meta property="og:title" content="SKJ-Project Management System">
	<meta property="og:type" content="Project Management System">
	<meta property="og:site_name" content="SKJ-Project Management System">
	<meta property="og:description" content="대덕인재개발원 인공지능AI반 최종프로젝트 PMS 3조 SKJ">
	<meta property="og:image" content="${pageContext.request.contextPath }/resources/images/layout/og.jpg">
	<%-- og  --%>
	<title>SKJ-PMS</title>
<security:csrfMetaTags/>
	<%-- script --%>
	<script src="${pageContext.request.contextPath }/resources/js/common/jquery-3.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/assets/dist/js/bootstrap.bundle.min.js"></script>
    
	<!--admin -->
    <link rel="stylesheet" href='${pageContext.request.contextPath }/resources/admin/css/adminlayout.css'>
    <link rel="stylesheet" href='${pageContext.request.contextPath }/resources/css/template/prog.css'>
    <link rel="stylesheet" href='${pageContext.request.contextPath }/resources/css/template/B/sublayoutB.css'>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/template/B/footerB.css" />
    <!-- 알람 -->
 <script src="${pageContext.request.contextPath}/resources/push/bin/push.js" type="text/javascript"></script>
<%--  <script src="${pageContext.request.contextPath}/resources/push/bin/serviceWorker.min.js" type="text/javascript"></script> --%>
  <script src="${pageContext.request.contextPath}/resources/push/src/serviceWorker.js" type="text/javascript"></script>
   <script src="${pageContext.request.contextPath }/resources/navipush/naviAlram.js"></script>
<!-- 알람 -->