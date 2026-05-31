<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!-- form  -->
<form id="searchForm">
	<input type="hidden" name="page" />
	<input type="hidden" name="searchType" value="${paging.simpleCondition.searchType}" /> 
	<input type="hidden" name="searchWord" value="${paging.simpleCondition.searchWord}" />
</form>
<!-- form  -->

<!-- searchBar -->
<div data-pg-role="searchUI" data-pg-target="#searchForm"
	class="searchBox d-flex justify-content-end">
	 <select class="me-1" name="searchType">
		<option value="" label="전체" />
		<option value="title" label="제목" />
		<option value="name" label="작성자" />
	</select>

	<div class="fieldset flex">
		<input class="me-1" type="text" name="searchWord"
			data-pg-init-value="${paging.simpleCondition.searchWord }"
			title="검색어를 입력해주세요" value="${paging.simpleCondition.searchWord }"
			placeholder="검색어 입력" />
		<button type="button" class="btn btn-primary" data-pg-role="searchBtn">검색</button>
	</div>
</div>
<!-- searchBar -->


<!-- 서식공지 테이블 -->	
	<table class="table text-center">
					<caption class="sr-only">서식 공지 테이블입니다.</caption>
					<colgroup>
						<col style="width: 9%;">
						<col style="width: auto;">
						<col style="width: 30%;">
<%-- 						<col style="width: 10%;"> --%>
					</colgroup>
					<thead>
						<div class="p-3 mb-2 bg-dark bg-gradient text-white">
						<strong>공지사항</strong>
						</div>
<!-- 							<th scope="col">게시판 분류</th> -->
<!-- 							<th scope="col">제목</th> -->
<!-- 							<th scope="col">등록일자</th> -->
<!-- 							<th scope="col">조회수</th> -->
					</thead>
					<tbody>
						<c:forEach items="${anoList }" var="ano">
						<tr>
						<td>
							<c:if test="${ano.bpNtcName  eq '공지'}">
								<span class="category emergency">${ano.bpNtcName }</span>
							</c:if> 
							<c:if test="${ano.bpNtcName  eq '서식'}">
								<span class="category ordinary">${ano.bpNtcName }</span>
							</c:if> 
							<c:if test="${ano.bpNtcName  eq '칭찬공간'}">
								<span class="category cate2">${ano.bpNtcName }</span>
							</c:if> 
							<c:if test="${ano.bpNtcName  eq '포토공간'}">
								<span class="category cate3">${ano.bpNtcName }</span>
							</c:if> 
							<c:if test="${ano.bpNtcName  eq 'QNA'}">
								<span class="category project">${ano.bpNtcName }</span>
							</c:if> 
							<c:if test="${ano.bpNtcName  eq '나눔공간'}">
								<span class="category share">${ano.bpNtcName }</span>
							</c:if> 
							</td>
							<td class="text-start"><a href="${pageContext.request.contextPath }/board/ano/${ano.bpId}" class="text-link d-flex new">
									<c:if test="${empty ano.nowCheck}">
										<span class="icon new_icon">
												<span class="sr-only">new</span>
											</span>
									</c:if>
									<em class="text-elipsis">[공지] ${ano.bpTitle }</em>
								</a>
							</td>
							<div class="left float">
							<td>${ano.bpRegDtStr }</td>
							</div>
<%-- 							<td>${ano.bpCnt }</td> --%>
						</tr>
						</c:forEach>
					</tbody>
				</table>
<!-- 서식공지 테이블 -->				






<!-- ui : table s -->
<table class="table text-center">
	<caption class="sr-only">서식자료 목록 테이블입니다.</caption>

	<colgroup>
		<col style="width:10%">
		<col style="auto">
		<col style="width:10%">
		<col style="width:10%">
		<col style="width:10%">
	</colgroup>

	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">제목</th>
			<th scope="col">작성자</th>
			<th scope="col">등록일자</th>
			<th scope="col">조회수</th>
		</tr>
	</thead>

	<c:forEach items="${formList }" var="fl">
		<tbody>
			<!-- 일반 -->
			<tr>
				<th scope="row">${fl.rnum }</th>
				<td class="text-start">
					<!-- 새글일 때 new 클래스 추가 -->
				<a href="${pageContext.request.contextPath }/board/form/${fl.bpId}"
					class="text-link d-flex new">
					 <!-- icon new_icon 추가 -->
					<c:if test="${empty fl.nowCheck}">
										<span class="icon new_icon">
												<span class="sr-only">new</span>
											</span>
									</c:if>
					 <em class="text-elipsis">${fl.bpTitle}</em>
				</a>
				</td>
				<td>${fl.empName }</td>
				<td>${fl.bpRegDtStr }</td>
				<td>${fl.bpCnt }</td>
			</tr>
			<!-- 일반 -->
	</c:forEach>
	</tbody>
</table>

<!-- button -->
<!-- <div class="btn-box clearfix mt-4"> -->
<!-- 	<div class="right float-end"> -->
<%-- 		<a href="${pageContext.request.contextPath }/board/form/register"><button class="btn btn-primary">등록</button></a> --%>
<!-- 	</div> -->
<!-- </div> -->
<!-- button -->

<script>



</script>
	${pagingHTML }
										
<script src="<c:url value='/resources/js/common/paging.js'/>">
</script>