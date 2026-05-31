<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!-- form  -->
<form id="searchForm">
	<input type="hidden" name="page"> <input type="hidden"
		name="simpleCondition.searchType"
		value="${paging.simpleCondition.searchType }"> <input
		type="hidden" name="simpleCondition.searchWord"
		value="${paging.simpleCondition.searchWord }">
</form>
<!-- form  -->

<div class="header-title select">
	<h2>
		<strong class="title-name">질문관리 - FAQ</strong>
	</h2>
</div>




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
						<col style="width: 5%">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: auto;">
						<col style="width: 10%;">
						<col style="width: 10%;">
					</colgroup>

					<thead class="admin-thead">
						<tr>
							<th scope="col"><input class="form-check-input"
								type="checkbox" value="" id="flexCheckDefault"
								onclick="selectAll(this)"></th>
							<th scope="col">번호</th>
							<th scope="col">답변상태</th>
							<th scope="col">작성자</th>
							<th scope="col">제목</th>
							<th scope="col">등록일자</th>
							<th scope="col">조회수</th>

						</tr>
					</thead>
					<c:if test="${not empty qnaList }">
						<c:forEach items="${qnaList }" var="ql">
							<tbody>
								<!-- 일반 -->
								<tr>
									<td><input type="checkbox" class="qnaCheckbox"
										id="qnaCheck" value="${ql.bpId}"></td>
									<th scope="row">${ql.rnum }</th>
									<td><c:if test="${ql.qnaName eq '답변완료' }">
											<span class="category new">${ql.qnaName }</span>
										</c:if> <c:if test="${ql.qnaName eq '미답변' }">
											<span class="category ordinary">${ql.qnaName }</span>
										</c:if></td>
									<td>${ql.empName }</td>
									<td class="text-start">
										<!-- 새글일 때 new 클래스 추가 --> <a
										href="${pageContext.request.contextPath }/admin/qna/answer/${ql.bpId}"
										class="text-link d-flex new"> <!-- icon new_icon 추가 --> <span
											class="icon new_icon"> <span class="sr-only">new</span>
										</span> <em class="text-elipsis">${ql.bpTitle }</em>
									</a>
									</td>
									<td>${ql.bpRegDtStr }</td>
									<td>${ql.bpCnt }</td>
								</tr>
								<!-- 일반 -->
							</tbody>
						</c:forEach>
					</c:if>
					<c:if test="${empty qnaList }">
						<tr>
							<td colspan="7" class="text-center">검색 결과가 없습니다.</td>
						</tr>
					</c:if>
				</table>
				<div class="right float-end delete_content">
					<a href="${pageContext.request.contextPath }/admin/qna/faq/add"><button
							class="btn btn-primary">등록</button></a>
					<button class="btn btn-danger" data-bs-toggle="modal"
						data-bs-target="#deleteModal">삭제</button>
					<form id="deleteForm"
						action="${pageContext.request.contextPath }/admin/qna/faq/add">
						<div class="modal fade info" id="deleteModal" tabindex="-1"
							aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<strong class="modal-title fs-5" id="deleteModalLabel">안내</strong>
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body" id="deleteResult">"해당 글을
										삭제하시겠습니까?"</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-secondary"
											data-bs-dismiss="modal">닫기</button>
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

<script src="<c:url value='/resources/js/common/paging.js'/>"></script>
<!-- pagenation -->