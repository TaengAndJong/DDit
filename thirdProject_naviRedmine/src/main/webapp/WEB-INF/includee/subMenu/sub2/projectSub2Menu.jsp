<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form"  prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags"  prefix="spring"%>
		<!-- 2차네비 -->
		<div class="sub_inner clearfix">
			<!-- 제목 -->
			<div class="title">
				<strong> 프로젝트 </strong>
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
			<form id="ingForm">
				<input type="hidden" name="ing" value="${ing }">
			</form>
			<!-- BOOTSTRAP TAB -->
			<c:if test="${not empty project2MenuList}">
			
			<nav class="sub_navi tab">
				<div class="nav nav-tabs" id="nav-tab" role="tablist">
					<c:forEach items="${project2MenuList}" var="menu">
					<button class="nav-link pro-2 active" id="nav${menu.rescIdx}" data-bs-toggle="tab"
						data-bs-target="#nav${menu.rescIdx}-con" type="button" role="tab"
						aria-controls="nav${menu.rescIdx}-con" aria-selected="true">
						${menu.rescMenu}</button>
					</c:forEach>
				</div>
			</nav>
			</c:if>
			<div class="tab-content" id="nav-tabContent">
				<div class="tab-pane active show" tabindex="0">