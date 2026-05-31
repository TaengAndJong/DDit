<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<form id="searchForm">
	<input type="hidden" name="page" />
	<input type="hidden" name="projectState" value="${paging.detailCondition.projectState }" />
	<input type="hidden" name="project" value="${paging.detailCondition.project }" />
	<input type="hidden" name="state" value="${paging.detailCondition.state }" />
</form>

<div data-pg-role="searchUI" data-pg-target="#searchForm" class="searchBox d-flex justify-content-end">

	<select class="me-1" name="state" data-pg-init-value="${paging.detailCondition.state}">
	    <option value="" ${empty paging.detailCondition.state ? 'selected' : ''}>전체</option>
	    <option value="ing" ${paging.detailCondition.state == 'ing' ? 'selected' : ''}>진행중</option>
	    <option value="end" ${paging.detailCondition.state == 'end' ? 'selected' : ''}>마감</option>
	</select>
	
	<select class="me-1" name="projectState" data-pg-init-value="${paging.detailCondition.projectState }">
		<option value>상태선택</option>
		<c:forEach items="${projectStateList }" var="prost">
			<option value="${prost.cmId }">${prost.cmName }</option>
		</c:forEach>
	</select>
	
	<div class="fieldset flex">
		<input class="me-1" type="text" name="project" data-pg-init-value="${paging.detailCondition.project }"
			value="${paging.detailCondition.project }" placeholder=" 담당자 또는 프로젝트명" />
		<button type="button" class="btn btn-primary" data-pg-role="searchBtn">검색</button>
	</div>
</div>

<table class="table text-center">
	<caption class="sr-only">내 프로젝트 목록</caption>
	
	<colgroup>
		<col style="width: 8%;">
		<col style="width: 8%;">
		<col style="width: auto;">
		<col style="width: 10%;">
		<col style="width: 10%;">
		<col style="width: 8%;">
	</colgroup>

	<thead>
		<tr>
			<th scope="col">프로젝트상태</th>
			<th scope="col">담당자</th>
			<th scope="col">프로젝트명</th>
			<th scope="col">등록일</th>
			<th scope="col">마감예정일</th>
			<th scope="col">마감여부</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${not empty projectList }">
			<c:forEach items="${projectList }" var="project">
				<tr>
					<td>
					    <span class="category projectState">${project.cmName}</span>
					</td>
					
					<td>${project.empName}</td>
					<td class="text-start">
						<a href="${pageContext.request.contextPath}/project/dashboard/${project.proId}" class="text-link d-flex new">
						<c:if test="${project.proStId eq 'PS0001' }">
								<span class="icon new_icon"> <span class="sr-only">new</span>
								</span>
						</c:if>
						<em class="text-elipsis">${project.proName }</em></a>
					</td>
					<td>${project.proRegDtStr}</td>
					<td>${project.proDdlineExStr}</td>
					<td>${project.proDdlineYn}</td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty projectList }">
			<tr>
				<td colspan="8" class="text-center">등록된 프로젝트가 없습니다.</td>
			</tr>
		</c:if>
	</tbody>
</table>

${pagingHTML }
<script src="<c:url value='/resources/js/common/paging.js'/>"></script>
<script src="<c:url value='/resources/mypage/js/myPage.js'/>"></script>
