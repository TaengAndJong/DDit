<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<form id="searchForm">
	<input type="hidden" name="page" />
	<input type="hidden" name="state" value="${paging.detailCondition.state }" />
	<input type="hidden" name="imprtId" value="${paging.detailCondition.imprtId }" />
	<input type="hidden" name="issueId" value="${paging.detailCondition.issueId }" />
	<input type="hidden" name="issueTitle" value="${paging.detailCondition.issueTitle }" />
</form>
<!-- searchBar -->
<div data-pg-role="searchUI" data-pg-target="#searchForm"
	class="searchBox d-flex justify-content-end">
	
	<!-- 입력용도 UI  -->
	<select class="me-1" name="state" data-pg-init-value="${paging.detailCondition.state}">
		<option value="" ${empty paging.detailCondition.state ? 'selected' : ''}>전체</option>
		<option value="ing" ${paging.detailCondition.state == 'ing' ? 'selected' : ''}>진행중</option>
		<option value="end" ${paging.detailCondition.state == 'end' ? 'selected' : ''}>삭제</option>
	</select> <select class="me-1" name="issueId" data-pg-init-value="${paging.detailCondition.issueId }">
		<option value>분류선택</option>
		<c:forEach items="${issueStateList }" var="is">
			<option value="${is.cmId }">${is.cmName }</option>
		</c:forEach>
	</select> <select class="me-1" name="imprtId" data-pg-init-value="${paging.detailCondition.imprtId }">
		<option value>중요도선택</option>
		<c:forEach items="${issueImportStateList }" var="iip">
			<option value="${iip.cmId }">${iip.cmName }</option>
		</c:forEach>
	</select>
	
	<div class="fieldset flex">
		<input class="me-1" type="text" name="issueTitle"  data-pg-init-value="${paging.detailCondition.issueTitle }" placeholder=" 이슈명" />
		<button type="button" class="btn btn-primary" data-pg-role="searchBtn">검색</button>
	</div>
</div>
<!-- ui : table s -->
<table class="table text-center">
	<caption class="sr-only">내 이슈 목록</caption>

	<colgroup>
		<col style="width: 4%;">
		<col style="width: 8%;">
		<col style="width: 8%;">
		<col style="width: 10%;">
		<col style="width: auto;">
		<c:if test="${paging.detailCondition.state != 'ing'}">
			<col style="width: 10%;">
		</c:if>
		<col style="width: 8%;">
	</colgroup>

	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">중요도</th>
			<th scope="col">분류</th>
			<th scope="col">프로젝트명</th>
			<th scope="col">이슈명</th>
			<th scope="col">등록일</th>
			<c:if test="${paging.detailCondition.state != 'ing'}">
				<th scope="col">삭제일</th>
			</c:if>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${issueList }" var="issue">
			<tr>
				<td>${issue.rnum }</td>
				 <td><span class="category impState">${issue.impName }</span></td>
 				 <td><span class="category issueState">${issue.stateName }</span></td>
				<td>${issue.proId }</td>
				<td class="text-start">
					<a href="${pageContext.request.contextPath }/project/issue/detail/${issue.proId }/${issue.issueId}" class="text-link d-flex new">
					<c:if test="${issue.stateName eq '신규'}">
						<span class="icon new_icon">
							<span class="sr-only">new</span>
						</span>
					</c:if>
					 <em class="text-elipsis">${issue.issueTitle}</em>
				</a></td>
				<td>${issue.issueRegDtStr}</td>
				<c:if test="${paging.detailCondition.state != 'ing'}">
					<td>${issue.issueDelDtStr}</td>
				</c:if>
			</tr>
		</c:forEach>
	</tbody>
</table>
<!-- ui : table e -->

${pagingHTML }
<script src="<c:url value='/resources/js/common/paging.js'/>"></script>
<script src="<c:url value='/resources/mypage/js/myPage.js'/>"></script>