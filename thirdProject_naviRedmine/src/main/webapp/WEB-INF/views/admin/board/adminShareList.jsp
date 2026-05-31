<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!-- 게시글 상세정보 MODAL -->
<c:forEach items="${shareList }" var="board">
	<div class="modal fade" id="${board.bpId}modal" tabindex="-1"
		aria-labelledby="shareModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-scrollable">
			<div class="modal-content admin-board">
				<div class="modal-header">
					<h5 class="modal-title" id="shareModalLabel">게시글 정보</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-12">
							<table class="table table-sm">
								<tbody class="admin-table">
									<tr>
										<th>나눔상태 :</th>
										<td id="shareName">${board.shrName}</td>
									</tr>
									<tr>
										<th>제목 :</th>
										<td id="shareName">${board.bpTitle}</td>
									</tr>

									<tr>
										<th>작성자 :</th>
										<td id="shareEmp">${board.empName }</td>
									</tr>
									<tr>
										<th>작성일 :</th>
										<td id="shareDateStart">${board.bpRegDtStr }</td>
									</tr>

									<tr>
										<th>내용 :</th>
										<td></td>
									</tr>
								</tbody>
							</table>
							<div class="content" id="shareDetail">
								<p>${board.bpCn}</p>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary"
								data-bs-dismiss="modal">뒤로가기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</c:forEach>
<!-- / 게시글 상세정보 MODAL -->





<!-- form  -->
<form id="searchForm">
	<input type="hidden" name="page" /> 
	<input type="hidden" name="simpleCondition.searchType" value="${paging.simpleCondition.searchType}" /> 
	<input type="hidden" name="simpleCondition.searchWord" value="${paging.simpleCondition.searchWord}" />
</form>
<!-- form  -->

<div class="header-title select">
	<h2>
		<strong class="title-name">커뮤니티 관리 - 나눔게시판</strong>
	</h2>
</div>


<!-- 2차 메뉴탭 -->
<div class="nav nav-tabs" id="nav-tab" role="tablist">
	<a href="${pageContext.request.contextPath }/admin/board/photo">
		<button class="nav-link active" id="nav7" data-bs-toggle="tab"
		data-bs-target="#nav7-con" type="button" role="tab"
		aria-controls="nav7-con" aria-selected="true">포토게시판</button>
	</a> 
	<a href="${pageContext.request.contextPath }/admin/board/prais">
		<button class="nav-link" id="nav8" data-bs-toggle="tab"
		data-bs-target="#nav8-con" type="button" role="tab"
		aria-controls="nav8-con" aria-selected="false">칭찬게시판</button>
	</a>
	<a href="${pageContext.request.contextPath }/admin/board/share">
		<button class="nav-link" id="nav9" data-bs-toggle="tab"
		data-bs-target="#nav9-con" type="button" role="tab"
		aria-controls="nav9-con" aria-selected="false">나눔게시판</button>
	</a>
</div>
<!-- 2차 메뉴탭 -->






<!-- 입력 및 검색용도 UI  -->
<div data-pg-role="searchUI" data-pg-target="#searchForm"
	class="searchBox d-flex justify-content-end">
	<select class="me-1" name="simpleCondition.searchType"
		data-pg-init-value="${paging.simpleCondition.searchType }">
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
<!-- 입력 및 검색용도 UI  -->

<!-- ui : table s -->
<div class="side_inner">
	<div class="content-box">
		<div class="content">
			<div class="inner html">
				<table class="table text-center">
					<caption class="sr-only">나눔 목록 테이블입니다.</caption>

					<colgroup>
						<col style="width: 5%;">
						<col style="width: 15%;">
						<col style="width: auto;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
					</colgroup>

					<thead class="admin-thead">
						<tr>
							<th scope="col"><input class="form-check-input"
								type="checkbox" value="" id="flexCheckDefault"
								onclick="selectAll(this)"></th>
							<th scope="col">나눔상태</th>
							<th scope="col">제목</th>
							<th scope="col">작성자</th>
							<th scope="col">등록일</th>
							<th scope="col">조회수</th>
						</tr>
					</thead>
					<tbody>
						<!-- 일반 -->
						<c:forEach items="${shareList }" var="board">
							<tr>
							<!-- 1.체크박스 -->
								<td><input type="checkbox" class="shareCheckbox" id="shareCheck" value="${board.bpId}"></td>
								<td><c:if test="${board.shrName eq '나눔가능' }">
										<span class="category emergency">${board.shrName }</span>
										</c:if>
										<c:if test="${board.shrName eq '나눔완료' }">
										<span class="category ordinary">${board.shrName }</span>
								</c:if></td>
								<td class="text-start">
								<a a style="display:ruby" href="#"  data-bs-toggle="modal" data-bs-target="#${board.bpId}modal">
								<c:if test="${empty board.nowCheck}">
									<span class="icon new_icon">
										<span class="sr-only">new</span>
									</span>
								</c:if>
								<em class="text-elipsis">${board.bpTitle }</em>
								</a>
								</td>
								<td>${board.empName }</td>
								<td>${board.bpRegDtStr }</td>
								<td>${board.bpCnt }</td>
							</tr>
							<!-- 일반 -->
						</c:forEach>
					</tbody>

				</table>

				<div class="right float-end delete_content">
					<button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal">삭제</button>
					<form id="deleteForm" action="${pageContext.request.contextPath }/admin/board/share">
						<div class="modal fade info" id="deleteModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<strong class="modal-title fs-5" id="deleteModalLabel">안내</strong>
										<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body" id="deleteResult">"해당 글을 삭제하시겠습니까?"</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
										<button type="submit" class="btn btn-danger" id="deleteBtn">삭제</button>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
				${pagingHTML }
				<!-- 버튼 알아서 퍼가셈 -->
				<!-- ui : table e -->
			</div>
		</div>
	</div>
</div>
<!-- 체크박스 전체 선택 및 해제 스크립트-->
<script> 
	function selectAll(selectAll)  {
		const checkboxes = document.querySelectorAll('input[type="checkbox"]');
	   	checkboxes.forEach((checkbox) => {
	    checkbox.checked = selectAll.checked
	   });
	}
</script>
<!-- /체크박스 전체 선택 및 해제 스크립트-->

<script src="${pageContext.request.contextPath }/resources/admin/js/adminMove.js"></script>
<script src="<c:url value='/resources/admin/js/manageShare.js'/>"></script>
<script src="<c:url value='/resources/js/common/paging.js'/>"></script>
<!-- pagenation -->