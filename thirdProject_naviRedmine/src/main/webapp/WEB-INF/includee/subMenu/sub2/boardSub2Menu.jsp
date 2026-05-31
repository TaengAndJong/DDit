<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form"  prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags"  prefix="spring"%>
		<!-- 2차네비 -->
		<div class="sub_inner clearfix">
			<!-- 제목 -->
			<div class="title">
				<strong> 커뮤니티 </strong>
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
			
			<!-- BOOTSTRAP TAB -->
			<nav class="sub_navi tab">
				<div class="nav nav-tabs" id="nav-tab" role="tablist">
					<c:forEach items="${boardMenuList}" var="menu">
					<a class="moveMenu" data-url="${menu.rescUrl}" href="${pageContext.request.contextPath }${menu.rescUrl}"><button class="nav-link" id="nav${menu.rescIdx}" data-bs-toggle="tab"
						data-bs-target="#nav1-con" type="button" role="tab"
						aria-controls="nav1-con" aria-selected="true">
						${menu.rescMenu}</button></a>
					</c:forEach>
				</div>
			</nav>
			<div class="tab-content" id="nav-tabContent">
				<div class="tab-pane active show" tabindex="0">
<script>
$(document).ready(function(e){
	$(".moveMenu").each(function(i,e){
		let url = $(e).data("url");		
		let realUrl=window.location.href
		let arr = realUrl.split("/");
		console.log(arr[5])
		let a = arr[5].split("?");
		
		if(url.includes(a[0])){
			$(e).children().addClass("active");
		}
	})
	
})
</script>