<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!-- form  -->
<form id="searchForm">
	<input type="hidden" name="page" /> <input type="hidden"
		name="searchType" value="${paging.simpleCondition.searchType}" /> <input
		type="hidden" name="searchWord"
		value="${paging.simpleCondition.searchWord}" />
</form>
<!-- form  -->

<div class="header-title select">
	<h2>
		<strong class="title-name">서식게시판 관리</strong>
	</h2>
</div>

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

<!-- ui : table s -->
<div class="side_inner">
	<div class="content-box">
		<div class="content">
			<div class="inner html">
				<table class="table task-list text-center">
					<colgroup>
						<col style="width: 8%;">
						<col style="width: auto;">
						<col style="width: 10%;">
						<col style="width: 15%;">
						<col style="width: 15%;">
						<col style="width: 10%;">
					</colgroup>
					<thead class="admin-thead">
						<tr>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">작성자</th>
							<th scope="col">등록일자</th>
							<th scope="col">수정일자</th>
							<th scope="col">조회수</th>
						</tr>
					</thead>

					<tbody>
						<c:if test="${not empty formList }">
							<c:forEach items="${formList }" var="fl">
								<tr>
									<th scope="row">${fl.rnum }</th>
									<td class="text-start">
										<a href="${pageContext.request.contextPath }/admin/form/${fl.bpId}">
										<c:if test="${empty fl.nowCheck}">
											<span class="icon new_icon">
												<span class="sr-only">new</span>
											</span>
										</c:if> 
										${fl.bpTitle}
										</a>
									</td>
									<td>${fl.empName }</td>
									<td>${fl.bpRegDtStr }</td>
									<td>
										<c:if test="${empty fl.bpModDtStr}">수정내역 없음</c:if> 
										<c:if test="${not empty fl.bpModDtStr}">${fl.bpModDtStr }</c:if>
									</td>
									
									<td>${fl.bpCnt }</td>
								</tr>
								<!-- 일반 -->
							</c:forEach>
						</c:if>
						<c:if test="${empty formList }">
							<tr>
								<td colspan="6" class="text-center">검색 결과가 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>

				<!-- button -->
				<div class="btn-box clearfix mt-4">
					<div class="right float-end">
						<a href="${pageContext.request.contextPath }/admin/form/add"><button
								onclick="moveAdd()" class="btn btn-primary">등록</button></a>
					</div>
				</div>
				<!-- button -->

			</div>
		</div>
		<!--하단부 페이징 -->
		${pagingHTML }
		<!-- 하단부 페이징과 삭제버튼 -->
	</div>
</div>

<script src="<c:url value='/resources/js/common/paging.js'/>"></script>