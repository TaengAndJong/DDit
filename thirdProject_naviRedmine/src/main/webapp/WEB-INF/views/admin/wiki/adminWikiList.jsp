<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!-- 위키 상세정보 MODAL -->
<c:forEach items="${wikiList }" var="wl">
<div class="modal fade" id="${wl.wikiId}modal" tabindex="-1" aria-labelledby="wikiModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content admin-emp">
			<div class="modal-header">
				<h5 class="modal-title" id="wikiModalLabel">위키 정보</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row">
				
					<div class="col-md-12">
						<table class="table table-sm">
							<tbody class="admin-table">
								<tr>
									<th>위키명: </th>
									<td id="projectName">${wl.wikiTitle  }</td>
								</tr>
								<tr>
									<th>상태: </th>
									<td id="projectAdmin">${ wl.cmName }</td>
								</tr>
								<tr>
									<th>위키 등록일자 : </th>
									<td id="projectDateStart">${wl.proRegDtStr }</td>
								</tr>
								<tr>
									<th>위키 마감일자 : </th>
									<td id="projectDateExit">${wl.proDdlineExStr}</td>
								</tr>
								
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-bs-dismiss="modal">뒤로가기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</c:forEach>
<!-- / 위키 상세정보 MODAL -->


<!-- form  -->
<form id="searchForm">
	<input type="hidden" name="page"> 
	<input type="hidden" name="simpleCondition.searchType" value="${paging.simpleCondition.searchType }"> 
	<input type="hidden" name="simpleCondition.searchWord" value="${paging.simpleCondition.searchWord }">
</form>
<!-- form  -->

<div class="header-title select">
	<h2>
		<strong class="title-name">위키 관리</strong>
	</h2>
</div>

<!-- searchBar -->
<div data-pg-role="searchUI" data-pg-target="#searchForm"
	class="searchBox d-flex justify-content-end">

	<select class="me-1" name="simpleCondition.searchType">
		<option value="" label="전체" />
		<option value="title" label="제목" />
		<option value="name" label="작성자" />
	</select>

	<div class="fieldset flex">
		<input class="me-1" type="text" name="simpleCondition.searchWord"
			data-pg-init-value="${paging.simpleCondition.searchWord }"
			title="검색어를 입력해주세요" value="${paging.simpleCondition.searchWord }"
			placeholder="검색어 입력" />
		<button type="button" class="btn btn-primary" data-pg-role="searchBtn">검색</button>
	</div>
</div>
<!-- searchBar -->

<!-- ui : table s -->
<div class="side_inner">
	<div class="content-box">
		<div class="content">
			<div class="inner html">

				<table class="table text-center">
						<caption class="sr-only">위키 목록 테이블입니다.</caption>
					
						<colgroup>
							<col style="width: 5%">
							<col style="width: 10%;">
							<col style="width: 10%;">
							<col style="width: auto;">
							<col style="width: 10%;">
							<col style="width: 10%;">
							<col style="width: 10%;">
						</colgroup>
					
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">프로젝트ID</th>
								<th scope="col">상태</th>
								<th scope="col">프로젝트명</th>
								<th scope="col">담당자</th>
								<th scope="col">등록일자</th>
								<th scope="col">마감일자</th>
					
							</tr>
						</thead>
					<c:forEach items="${wikiList}" var="wl">
						<tbody>
							<!-- 일반 -->
							<tr>
								<th scope="row">${wl.rnum }</th>
								<th scope="row">${wl.proId }</th>
								<td><c:if test="${wl.cmName eq '안정'}">
										<span class="category ordinary">${wl.cmName }</span>
									</c:if> <c:if test="${wl.cmName eq '긴급'}">
										<span class="category emergency">${wl.cmName }</span>
									</c:if> <c:if test="${wl.cmName eq '신규'}">
										<span class="category new">${wl.cmName }</span>
									</c:if></td>
								<td><a href="#" data-bs-toggle="modal" data-bs-target="#${wl.wikiId}modal">
																					${wl.wikiTitle }</a></td>
								<td>${wl.empName }</td>
								<td>${wl.proRegDtStr }</td>
								<td>${wl.proDdlineExStr }</td>
							</tr>
							<!-- 일반 -->
						</tbody>
					</c:forEach>
				</table>
			</div>
			${pagingHTML }
		</div>
		<!--하단부 페이징 -->

		<!-- 하단부 페이징과 삭제버튼 -->
	</div>
</div>

<script src="<c:url value='/resources/js/common/paging.js'/>"></script>
