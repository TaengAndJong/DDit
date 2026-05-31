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

<!-- 포토공지 테이블 -->	
	<table class="table text-center">
					<caption class="sr-only">나눔공지 테이블입니다.</caption>
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
									<span class="icon new_icon">
										<span class="sr-only">new</span>
									</span>
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
<!-- 포토공지 테이블 -->				

<!-- ui : 포토공간목록 s -->
<div class="row row-cols-1 row-cols-md-4 g-4 photo_list">
	<c:forEach items="${photoList}" var="pl">
		<!-- col -->
		<div class="col">
			<a href="${pageContext.request.contextPath }/board/photo/${pl.bpId}">
				<div class="card">
							<div class="card-top" style="padding: 10px;">
								<div class="photo_img">
										<div class="photo-sizing text-center">
											<img width="320px" height="380px" class="photomain" src="data:image/*;base64,${pl.base64Img }" alt="프로필이미지">
										</div>
									<div class="card-body">
										<strong class="card-title">
											<em class="text-elipsis">${pl.bpTitle }</em>
										</strong>
									</div>
									<ul	class="card-footer d-flex justify-content-between border-0 py-0">
											<li><span><i class="icon see_b"><em class="sr-only">조회수</em></i>${pl.bpCnt }</span></li>
											<li><span><i class="icon writer"><em class="sr-only">작성자</em></i>${pl.empName }</span></li>
											<li><span><i class="icon date"><em class="sr-only">날짜</em></i>${pl.bpRegDtStr} </span></li>
									</ul>
								</div>
							</div>
					</div>
			</a>
		</div>
	</c:forEach>
</div>
<!-- ui : 포토공간목록 e -->

<!-- button -->
<div class="btn-box clearfix mt-4">
	<div class="right float-end">
		<a href="${pageContext.request.contextPath }/board/photo/add"><button class="btn btn-primary">등록</button></a>
	</div>
</div>
<!-- button -->


<!-- pagenation -->
${pagingHTML }
										
<script src="<c:url value='/resources/js/common/paging.js'/>"></script>
<script src="<c:url value='/resources/mypage/js/bookmark.js'/>"></script>
<!-- pagenation -->
