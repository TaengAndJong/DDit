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


<!-- 나눔공지 테이블 -->	
	<table class="table text-center">
					<caption class="sr-only">칭찬공지 테이블입니다.</caption>
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
<!-- 나눔공지 테이블 -->


<!-- ui : table s -->
<table class="table text-center">
	<caption class="sr-only">칭찬 목록 테이블입니다.</caption>
	
	<colgroup>
		<col style="width: 8%">
		<col style="width: 5%">
		<col style="width: auto;">
		<col style="width: 10%;">
		<col style="width: 10%;">
		<col style="width: 10%;">

	</colgroup>

	<thead>
	<tr>
<%-- 	<strong style="display:block;">최고의 우수사원 : ${ }</strong> --%>
<%-- 	<em style="display:block;">칭찬순위 : 2등 ${ } 3등 ${ }</em> --%>
	</tr>
		<tr>
			<th scope="col">즐겨찾기</th>
			<th scope="col">번호</th>
			<th scope="col">제목</th>
			<th scope="col">작성자</th>
			<th scope="col">등록일자</th>
			<th scope="col">조회수</th>
		</tr>
	</thead>
	
<c:forEach items="${praisList }" var="pl">

	<tbody>
		<!-- 일반 -->
		<tr>
			<td>
	            <c:set var="a" value="" />
			    <c:forEach items="${bkList}" var="bk">
			        <c:if test="${bk.bpId eq pl.bpId}">
			            <c:set var="a" value="active" />
			        </c:if>
			    </c:forEach>
			    <button class="kinBtn border-0 boardBookmark ${a}"
			            data-mark-id="${pl.bpId}">
			        <i class="icon kin"></i><i class="sr-only">즐겨찾기버튼</i>
			    </button>
			</td>
			<th scope="row">${pl.rnum }</th>
			<td class="text-start">
				<!-- 새글일 때 new 클래스 추가 -->
				<a href="${pageContext.request.contextPath }/board/prais/${pl.bpId}" class="text-link d-flex new">
					<c:if test="${empty pl.nowCheck}">
						<span class="icon new_icon">
							<span class="sr-only">new</span>
						</span>
					</c:if>
				</span> <em class="text-elipsis">${pl.bpTitle }</em>
			</a>
			</td>
			<td>${pl.empName }</td>
			<td>${pl.bpRegDtStr }</td>
			<td>${pl.bpCnt }</td>
		</tr>
		<!-- 일반 -->

	</tbody>
</c:forEach>
</table>

<div class="btn-box clearfix mt-4">
	<div class="right float-end">
		<a href="${pageContext.request.contextPath }/board/prais/add"><button class="btn btn-primary">등록</button></a>
	</div>
</div>
<!-- 버튼 알아서 퍼가셈 -->

<!-- ui : table e -->

<!-- pagenation -->
${pagingHTML }
<script src="<c:url value='/resources/js/common/paging.js'/>">
</script>

<script src="<c:url value='/resources/mypage/js/bookmark.js'/>"></script>
<!-- pagenation -->

