<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%--gantt --%>
	
        <script src="${pageContext.request.contextPath }/resources/js/common/gant/js/jquery.min.js"></script>
	    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
	    <script src="${pageContext.request.contextPath }/resources/js/common/gant/js/jquery.fn.gantt.js"></script>
	    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	    <script src="//cdnjs.cloudflare.com/ajax/libs/prettify/r298/prettify.min.js"></script>
    <%--gantt --%>
    <%--gant 에서만 간트 css 로인해 공통 테이블 틀어짐!--%>
	<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" type="text/css"> 
   	<link href="${pageContext.request.contextPath }/resources/js/common/gant/css/style.css" type="text/css" rel="stylesheet">
    <link href="//cdnjs.cloudflare.com/ajax/libs/prettify/r298/prettify.min.css" rel="stylesheet" type="text/css">
  	<%--gant --%>
<div class="gantt"></div>

         
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/project/js/gant.js"></script>

