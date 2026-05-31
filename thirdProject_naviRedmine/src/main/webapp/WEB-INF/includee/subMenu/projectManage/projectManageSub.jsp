<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form"  prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags"  prefix="spring"%>
		<!-- 2차네비 -->
		<div class="sub_inner clearfix">
			<!-- 제목 -->
			<div class="title">
				<strong> ${project.proId } : ${project.proName } </strong>
			</div>
			<!-- 제목 -->
			<div class="util">
				<ul class="util_list">
					<!-- <li class="share">
                    <button class="icon share border-0"><span class="sr-only">컨텐츠공유버튼</span></button>
                </li> -->
					<li class="util_li">
						<button class="icon print border-0">
							<span class="sr-only">컨텐츠 프린트버튼</span>
						</button>
					</li>
				</ul>

			</div>
<form:form method="GET" id="menuForm">
</form:form>
<form:form method="POST" id="authForm" action="${pageContext.request.contextPath}/project/manage/${project.proId }/auth">
</form:form>
			<!-- BOOTSTRAP TAB -->
			<c:if test="${not empty project4MenuList}">
			
			<nav class="sub_navi tab">
				<div class="nav nav-tabs pro-nav" id="nav-tab" role="tablist" data-pro="${proId}">
					<c:forEach items="${project4MenuList}" var="menu">
					<button class="nav-link pro-ac " id="nav${menu.rescIdx}" data-bs-toggle="tab"
						data-bs-target="#nav${menu.rescIdx}-con" type="button" role="tab"
						aria-controls="nav${menu.rescIdx}-con" aria-selected="true"
						data-url="${pageContext.request.contextPath}${menu.rescUrl}"
						data-val="${menu.rescMenu}"
						>
						${menu.rescMenu}</button>
					</c:forEach>
				</div>
			</nav>
			</c:if>
			<div class="tab-content" id="nav-tabContent">
						<div class="tab-pane active show" tabindex="0">