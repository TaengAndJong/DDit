<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>



<div class="header-title select">
	<h2>
		<strong class="title-name">공지사항 관리</strong>
	</h2>
</div>

<form id="searchForm">
	<input type="hidden" name="page" /> 
	<input type="hidden" name="baordType" value="${paging.detailCondition.baordType }" /> 
	<input type="hidden" name="word" value="${paging.detailCondition.word }" />
</form>

<div data-pg-role="searchUI" data-pg-target="#searchForm"
	class="searchBox d-flex justify-content-end">

	<select class="me-1" name="baordType"
		data-pg-init-value="${paging.detailCondition.baordType }">
		<option value>게시판 분류</option>
		<c:forEach items="${boardTypeList }" var="boardType">
			<option value="${boardType.cmId }">${boardType.cmName }</option>
		</c:forEach>
	</select>
	<div class="fieldset flex">
		<input class="me-1" type="text" name="word"
			data-pg-init-value="${paging.detailCondition.word }"
			title="검색어를 입력해주세요" value="${paging.detailCondition.word }"
			placeholder="검색어 입력" />
		<button type="button" class="btn btn-primary" data-pg-role="searchBtn">검색</button>
	</div>
</div>

<!--inner-->
<div class="side_inner">
	<div class="content-box">
		<div class="content">
			<div class="inner html">
				<table class="table task-list text-center">
					<colgroup>
						<col style="width: 5%;">
						<col style="width: 10%;">
						<col style="width: 20%;">
						<col style="width: auto;">
						<col style="width: 10%;">
						<col style="width: 10%;">
					</colgroup>

					<thead class="admin-thead">
						<tr>
							<th><input type="checkbox"></th>
							<th scope="col">게시판 번호</th>
							<th scope="col">게시판 분류</th>
							<th scope="col">제목</th>
							<th scope="col">등록일자</th>
							<th scope="col">조회수</th>
						</tr>
					</thead>
					<tbody>
					<c:if test="${not empty anoList }">
						<c:forEach items="${anoList }" var="ano">
						<tr>
							<td><input type="checkbox"></td>
							<th>${ano.bpId }</th>
							<td>${ano.bpNtcName }</td>
							<td class="text-start">
								<a href="${pageContext.request.contextPath }/admin/ano/mod/${ano.bpId}">
								<c:if test="${empty ano.nowCheck}">
									<span class="icon new_icon">
										<span class="sr-only">new</span>
									</span>
								</c:if> 
								${ano.bpTitle }
								</a>
							</td>
							<td>${ano.bpRegDtStr }</td>
							<td>${ano.bpCnt }</td>
						</tr>
						</c:forEach>
						</c:if>
						<c:if test="${empty anoList }">
							<tr>
								<td colspan="6" class="text-center">검색 결과가 없습니다.</td>
							</tr>
						</c:if>
						<!-- 1 -->
					</tbody>
				</table>
				<!-- ui : table e -->


					<div class="right float-end">
						<a href="${pageContext.request.contextPath }/admin/ano/add"><button class="btn btn-primary">등록</button></a>
						<button class="btn btn-danger">삭제</button>
					</div>

			</div>
		</div>
		${pagingHTML }
	</div>
</div>
<!--inner-->

<script src="<c:url value='/resources/js/common/paging.js'/>"></script>