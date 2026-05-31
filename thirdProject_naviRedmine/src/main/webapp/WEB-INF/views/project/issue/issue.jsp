<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div class="info_box red mb-5">
<strong><i class="info"></i>현재 이슈 현황</strong>
	<ul class="ul bullet  mt-3">
		<li class="li indent mb-2">
			<span class="category new">신규</span>
			<span class="mx-2">${comp.IG0001 }</span>
			<span class="category cate3">진행</span>
			<span class="mx-2">${comp.IG0002 }</span>
			<span class="category cate2">해결</span>
			<span class="mx-2">${comp.IG0003 }</span>
			<span class="category emergency">보류</span>
			<span class="mx-2">${comp.IG0004 }</span>
			<span class="category diss">거절</span>
			<span class="mx-2">${comp.IG0005 }</span>
		</li>
	</ul>
</div>
<form id="searchForm">
	<input type="hidden" name="page" /> <input type="hidden" name="imprtId"
		value="${paging.detailCondition.imprtId }" /> <input type="hidden"
		name="issueId" value="${paging.detailCondition.issueId }" /> <input
		type="hidden" name="issueTitle"
		value="${paging.detailCondition.issueTitle }" />
</form>
<!-- searchBar -->
<div data-pg-role="searchUI" data-pg-target="#searchForm"
	class="searchBox d-flex">
	<!-- 입력용도 UI  -->
	<form id="registerForm" class="me-auto"
		action="${pageContext.request.contextPath}/project/issue/register/${project.proId }"
		method="get">
		<button class="btn btn-primary " id="registerBtn">이슈 등록</button>
	</form>
	<select class="me-1" name="issueId"
		data-pg-init-value="${paging.detailCondition.issueId }">
		<option value>분류선택</option>
		<c:forEach items="${issueStateList }" var="is">
			<option value="${is.cmId }">${is.cmName }</option>
		</c:forEach>
	</select> <select class="me-1" name="imprtId"
		data-pg-init-value="${paging.detailCondition.imprtId }">
		<option value>중요도선택</option>
		<c:forEach items="${issueImportStateList }" var="iip">
			<option value="${iip.cmId }">${iip.cmName }</option>
		</c:forEach>
	</select>
	<div class="fieldset flex">
		<input class="me-1" type="text"
			data-pg-init-value="${paging.detailCondition.issueTitle }"
			title="검색어를 입력해주세요" name="issueTitle" placeholder="검색어를 입력해주세요" />
		<button type="button" class="btn btn-primary" data-pg-role="searchBtn">검색</button>
	</div>
</div>
<!-- ui : table s -->
<table class="table text-center">
	<caption class="sr-only">프로젝트 목록 테이블입니다.</caption>

	<colgroup>
		<col style="width: 8%;">
		<col style="width: 5%;">
		<col style="width: 8%;">
		<col style="width: 8%;">
		<col style="width: 8%;">
		<col style="width: auto;">
		<col style="width: 10%;">
		<col style="width: 10%;">

	</colgroup>

	<thead>
		<tr>
			<th scope="col">즐겨찾기</th>
			<th scope="col">번호</th>
			<th scope="col">이슈 ID</th>
			<th scope="col">중요도</th>
			<th scope="col">상태</th>
			<th scope="col">이슈명</th>
			<th scope="col">작성자</th>
			<th scope="col">등록일</th>
			<!-- <th scope="col">중요도</th> -->
		</tr>
	</thead>
	<%-- ${issueList } --%>
	<tbody>
		<c:forEach items="${issueList }" var="issue">
			<!-- 1 -->
			<tr>
				<td>
	            <c:set var="a" value="" />
				<c:forEach items="${bkList }" var="bk">
					<c:if test="${bk.issueId eq  issue.issueId}">
					<c:set var="a" value="active" />
					</c:if>
				</c:forEach>
					<button class="kinBtn border-0 issueBookmark ${a}"
						data-mark-id="${issue.issueId }"
						data-pro-id="${issue.proId }">
						<i class="icon kin"></i><i class="sr-only">즐겨찾기버튼</i>
					</button>
				</td>
				<th scope="row">${issue.rnum }</th>
				<td>${issue.issueId }</td>			
				 <td>
					<c:if test="${issue.impName eq '낮음'}">
						<span class="category ordinary">${issue.impName }</span>
					</c:if>
					<c:if test="${issue.impName eq '보통'}">
						<span class="category cate4">${issue.impName }</span>
					</c:if>
					 <c:if test="${issue.impName eq '높음'}">
						<span class="category project">${issue.impName }</span>
					</c:if>
					 <c:if test="${issue.impName eq '긴급'}">
						<span class="category emergency">${issue.impName }</span>
					</c:if>
					
				</td>
 				 <td>
					<c:if test="${issue.stateName eq '해결'}">
						<span class="category cate2">${issue.stateName }</span>
					</c:if>
					<c:if test="${issue.stateName eq '보류'}">
						<span class="category emergency">${issue.stateName}</span>
					</c:if>
					 <c:if test="${issue.stateName eq '신규'}">
						<span class="category new">${issue.stateName}</span>
					</c:if>
					 <c:if test="${issue.stateName eq '진행'}">
						<span class="category cate3">${issue.stateName}</span>
					</c:if>
					 <c:if test="${issue.stateName eq '거절'}">
						<span class="category diss">${issue.stateName}</span>
					</c:if>
				</td>
				 
			 <%-- 	<td><span class="category ordinary">${issue.impName}</span></td>
				<td><span class="category ordinary">${issue.stateName}</span></td>  --%>
				
				
				<td class="text-start"><a
					href="${pageContext.request.contextPath }/project/issue/detail/${proId }/${issue.issueId}"
					class="text-link d-flex new"> 
					 <c:if test="${issue.stateName eq '신규'}">
						<span class="icon new_icon">
							<span class="sr-only">new</span>
					</span>
					</c:if>
					 <em class="text-elipsis">${issue.issueTitle}</em>
				</a></td>
				<td>${issue.empName }</td>
				<td>${issue.issueRegDtStr}</td>
			</tr>
			<!-- 1 -->
		</c:forEach>
	</tbody>
</table>
<!-- ui : table e -->

${pagingHTML }


<script src="<c:url value='/resources/js/common/paging.js'/>"></script>
<script src="<c:url value='/resources/mypage/js/bookmark.js'/>"></script>
