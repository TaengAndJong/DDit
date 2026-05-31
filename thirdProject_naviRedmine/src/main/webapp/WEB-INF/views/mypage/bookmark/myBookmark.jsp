<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<form id="searchForm">
	<input type="hidden" name="page" />
	<input type="hidden" name="Mark" value="${paging.detailCondition.Mark }" />
</form>
<!-- searchBar -->
<div data-pg-role="searchUI" data-pg-target="#searchForm"
	class="searchBox d-flex justify-content-end">
	
	<div class="fieldset flex">
		<input class="me-1" type="text" name="Mark"  data-pg-init-value="${paging.detailCondition.Mark }" placeholder="제목 또는 작성자" />
		<button type="button" class="btn btn-primary" data-pg-role="searchBtn">검색</button>
	</div>
</div>

<table class="table text-center">
	<caption class="sr-only">내 프로젝트 목록</caption>
	
	<colgroup>
		<col style="width: 3%;">
		<col style="width: 15%;">
		<col style="width: 15%;">
		<col style="width: auto;">
		<col style="width: 8%;">
		<col style="width: 10%;">
	</colgroup>

	<thead>
		<tr>
			<th scope="col"></th>
			<th scope="col">북마크ID</th>
			<th scope="col">카테고리명</th>
			<th scope="col">제목</th>
			<th scope="col">작성자</th>
			<th scope="col">등록일</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${not empty list }">
			<c:forEach items="${list }" var="list">
				<tr>
					<td>
					<c:if test="${list.titleId.startsWith('B')}">
					<button class="kinBtn border-0 boardMark active"
						data-board-id="${list.titleId }">
							<i class="icon kin" data-board-id="${list.titleId }"></i><i class="sr-only">즐겨찾기버튼</i>
						</button>
					</c:if>
					<c:if test="${list.titleId.startsWith('I')}">
						<button class="kinBtn border-0 issueMark active"
						data-issue-id="${list.titleId }">
							<i class="icon kin" data-issue-id="${list.titleId }"></i><i class="sr-only">즐겨찾기버튼</i>
						</button>
					</c:if>
					</td>
					<td>${list.bmId }</td>
					<td>
					    <c:choose>
					        <c:when test="${list.ctgryNm eq '공지'}">
					            <span class="category emergency" ><em class="text-elipsis">${list.ctgryNm}</em></span>
					        </c:when>
					        <c:when test="${list.ctgryNm eq '서식'}">
					            <span class="category ordinary"><em class="text-elipsis">${list.ctgryNm}</em></span>
					        </c:when>
					        <c:when test="${list.ctgryNm eq '칭찬공간'}">
					            <span class="category cate2"><em class="text-elipsis">${list.ctgryNm}</em></span>
					        </c:when>
					        <c:when test="${list.ctgryNm eq '포토공간'}">
					            <span class="category cate3"><em class="text-elipsis">${list.ctgryNm}</em></span>
					        </c:when>
					        <c:when test="${list.ctgryNm eq 'QNA'}">
					            <span class="category project"><em class="text-elipsis">${list.ctgryNm}</em></span>
					        </c:when>
					        <c:when test="${list.ctgryNm eq '나눔공간'}">
					            <span class="category share"><em class="text-elipsis">${list.ctgryNm}</em></span>
					        </c:when>
					        <c:otherwise>
					            <span class="category emergency text-elipsis" style="height:35px"><em>${list.ctgryNm}</em></span>
					        </c:otherwise>
					    </c:choose>
					</td>
					<%-- <td>${list.ctgryNm}</td>  --%>
					<td class="text-start">
					<c:if test="${list.ctgryId.startsWith('P')}">
						<a href="${pageContext.request.contextPath }/project/issue/detail/${list.ctgryId }/${list.titleId}" class="text-link d-flex new">
						<span class="icon new_icon"><span class="sr-only">new</span></span>
						<em class="text-elipsis">${list.title }</em></a>
					</c:if>
					<c:if test="${list.ctgryId.startsWith('B')}">
						<a href="${pageContext.request.contextPath }/board/${list.ctgryUrl }/${list.titleId}" class="text-link d-flex new">
						<span class="icon new_icon"><span class="sr-only">new</span></span>
						<em class="text-elipsis">${list.title }</em></a>
					</c:if>
					</td>
					<td>${list.regNm}</td>
					<td>${list.regDtStr}</td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty list }">
			<tr>
				<td colspan="8" class="text-center">등록된 즐겨찾기가 없습니다.</td>
			</tr>
		</c:if>
	</tbody>
</table>

${pagingHTML }
<script src="<c:url value='/resources/js/common/paging.js'/>"></script>
<script src="<c:url value='/resources/mypage/js/bookmark.js'/>"></script>