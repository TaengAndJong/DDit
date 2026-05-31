<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form"  prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags"  prefix="spring"%>
				<!-- form  -->
<form id="searchForm">
	<input type="hidden" name="page" />
	<input type="hidden" name="searchType" value="${paging.simpleCondition.searchType}"/>
	<input type="hidden" name="searchWord" value="${paging.simpleCondition.searchWord}" />
</form>
<!-- form  -->
<!-- searchBar -->
<div data-pg-role="searchUI" data-pg-target="#searchForm"
	class="searchBox d-flex">
	<a href="${pageContext.request.contextPath }/project/filesave/add/${project.proId}" class="btn btn-primary me-auto" id="registerBtn">파일글 등록</a>
	 <select class="me-1" name="searchType" data-pg-init-value="${paging.simpleCondition.searchType }" >
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
				<table class="table text-center">
					<caption class="sr-only">프로젝트 목록 테이블입니다.</caption>

					<colgroup>
						<col style="width: 10%;">
						<col style="width: auto;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 10%;">

					</colgroup>

					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">파일저장소명</th>
							<th scope="col">작성자</th>
							<th scope="col">등록일</th>
							<th scope="col">수정일</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${fsList }" var="fs">
					
					
						<!-- 1 -->
						<tr>
							<th scope="row">${fs.rnum }</th>
							<td class="text-start"><a href="${pageContext.request.contextPath }/project/filesave/${fs.proId}/${fs.fsnId}" class="text-link d-flex new">
									<span class="icon new_icon">
										<span class="sr-only">new</span>
									</span>
									<em class="text-elipsis">${fs.fsnTitle }</em>
								</a>
							</td>
							<td>${fs.empName }</td>
							<td>${fs.fsnRegDtStr }</td>
							<c:choose>
							    <c:when test="${not empty fs.fsnModDt}">
							        <td>${fs.fsnModDtStr}</td>
							    </c:when>
							    <c:otherwise>
							        <td>수정내역 없음</td>
							    </c:otherwise>
							</c:choose>

						</tr>
						<!-- 1 -->
						</c:forEach>
					</tbody>
				</table>
				<!-- ui : table e -->
				
							${pagingHTML }			
									<script src="<c:url value='/resources/js/common/paging.js'/>"></script>