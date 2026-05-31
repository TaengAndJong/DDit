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
		<option value="name" label="프로젝트ID" />
	</select>

	<div class="fieldset flex">
		<input class="me-1" type="text" name="searchWord"
			data-pg-init-value="${paging.simpleCondition.searchWord }"
			title="검색어를 입력해주세요" value="${paging.simpleCondition.searchWord }"
			placeholder="검색어 입력" />
		<button type="button" class="btn btn-primary" data-pg-role="searchBtn">검색</button>
	</div>
</div>

<!-- ui : table s -->
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
			<td>
				<c:if test="${wl.cmName eq '안정'}">
					<span class="category ordinary">${wl.cmName }</span>
				</c:if>
				<c:if test="${wl.cmName eq '긴급'}">
					<span class="category emergency">${wl.cmName }</span>
				</c:if>
				<c:if test="${wl.cmName eq '신규'}">
					<span class="category new">${wl.cmName }</span>
				</c:if>
			</td>
			<td class="text-start">
				<!-- 새글일 때 new 클래스 추가 --> <a href="${pageContext.request.contextPath }/wiki/${wl.wikiId}" class="text-link d-flex new">
					<!-- icon new_icon 추가 -->  <c:if
								test="${wl.cmName eq '신규' }">
								<span class="icon new_icon"> <span class="sr-only">new</span>
								</span>
							</c:if><em class="text-elipsis">${wl.proName }</em>
			</a>
			</td>
			<td>${wl.empName }</td>
			<td>${wl.proRegDtStr }</td>
			<td>${wl.proDdlineExStr }</td>
			<c:forEach items="${fileList }" var="f">
				<td><a href="${pageContext.request.contextPath }/wiki/download/${f.wfId}"><c:choose>
								<c:when test="${empty f.wkFileGbId}">
									<em class="file_name">첨부된 파일이 없습니다.</em>
								</c:when>
								<c:otherwise>
									<c:if test="${f.wkFileGbId eq 'pdf' }">
										<i class="icon pdf"><em class="sr-only">${f.wkFileGbId }</em></i>
									</c:if>
									<c:if test="${f.wkFileGbId eq 'txt' }">
										<i class="icon txt"><em class="sr-only">${f.wkFileGbId }</em></i>
									</c:if>
									<c:if test="${f.wkFileGbId eq 'jpg'}">
										<i class="icon txt"><em class="sr-only">${f.wkFileGbId }</em></i>
									</c:if>
									<c:if test="${f.wkFileGbId eq 'png' }">
										<i class="icon txt"><em class="sr-only">${f.wkFileGbId }</em></i>
									</c:if>
									<c:if test="${f.wkFileGbId eq 'word' }">
										<i class="icon word"><em class="sr-only">${f.wkFileGbId }</em></i>
									</c:if>
									<c:if test="${f.wkFileGbId eq 'xlsx' }">
										<i class="icon xlsx"><em class="sr-only">${f.wkFileGbId }</em></i>
									</c:if>
									<c:if test="${f.wkFileGbId eq 'zip' }">
										<i class="icon zip"><em class="sr-only">${f.wkFileGbId }</em></i>
									</c:if>
									<c:if test="${f.wkFileGbId eq 'hwp' }">
										<i class="icon hangle"><em class="sr-only">${f.wkFileGbId }</em></i>
									</c:if>
									<c:if test="${f.wkFileGbId eq 'ppt' }">
										<i class="icon ppt"><em class="sr-only">${f.wkFileGbId }</em></i>
									</c:if>
									<c:if test="${f.wkFileGbId eq 'pptx' }">
										<i class="icon ppt"><em class="sr-only">${f.wkFileGbId }</em></i>
									</c:if>
								</c:otherwise>
							</c:choose></a></td>
			</c:forEach>
		</tr>
		<!-- 일반 -->
	</tbody>
</c:forEach>
</table>

<!-- button -->

<!-- button -->
 
${pagingHTML }
<script src="<c:url value='/resources/js/common/paging.js'/>"></script>
<script src="<c:url value='/resources/project/js/project.js'/>"></script> 