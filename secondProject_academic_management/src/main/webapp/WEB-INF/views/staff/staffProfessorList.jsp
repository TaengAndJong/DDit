<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
.formBox {
	padding: 20px 0;
	justify-content: flex-end;
	width: 100%;
}
</style>



<!-- 타이틀  -->
<div class="topBox  mb-3 pb-2 border-bottom mt-1">
	<strong class="title fs-5 text ">교직원-교수정보</strong>
</div>
<!-- 타이틀  -->

<!-- 검색  -->
<!-- ?action url 확인요망 -->
<form id="searchForm"
	action="<c:url value='/staff/staffProfessorList.do'/>">
	<input type="hidden" name="page" /> <input type="hidden"
		name="searchType" value="${condition.searchType}" /> <input
		type="hidden" name="searchWord" value="${condition.searchWord}" />
</form>

<div data-pg-role="searchUI" data-pg-target="#searchForm"
	class="formBox flex">
	<select name="searchType" data-pg-init-value="${condition.searchType}">
		<option value>전체</option>
		<!-- 프롬프트 옵션  value는 공백 -->
		<option value="proNo">교수코드</option>
		<option value="proName">이름</option>
		<option value="proMajor">전공</option>
	</select> <input type="text" name="searchWord"
		data-pg-init-value="${condition.searchWord}" title="검색어를 입력해주세요"
		placeholder="검색어를 입력해주세요" />
	<button type="button" class="btn btn-primary" data-pg-role="searchBtn">검색</button>
</div>
<!-- 검색 -->


<!-- ui : p -->
<table class="table table table-bordered" id="modalTable">
	<thead>
		<tr class="table-primary">
			<th>교수코드</th>
			<th>이름</th>
			<th>전공</th>
			<th>전화번호</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${not empty staffProfessorList }">
			<c:forEach items="${staffProfessorList }" var="professor">
				<tr>
					<td class="proNo">${professor.proNo }</td>
					<td class="proName"><a href="javascript:;" title="교수이름"
						data-professor-name="${professor.proName}">
							${professor.proName}</a></td>
					<td class="proMajor">${professor.proMajor }</td>
					<td class="proTelno">${professor.proTelno }</td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty staffProfessorList }">
			<tr>
				<td colspan="6">교수 없음.</td>
			</tr>
		</c:if>
	</tbody>
</table>

<!-- modal -->
<div class="modal " id="">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title fs-5" id="exampleModalLabel">교수정보수정</h1>
				<button type="button" class="btn-close " aria-label="Close"></button>
			</div>
			<form id="updateForm"
				action='<c:url value="/staff/staffProfessorList.do"/>' method="post">
				<div class="modal-body">
					<label for="proNo" class="tit fs-6">교수코드</label> <input type="text"
						id="proNo" class="form-control" name="proNo" readonly /> <label
						for="proName" class="tit fs-6">이름</label> <input type="text"
						id="proName" class="form-control" name="proName" readonly /> <label
						for="proMajor" class="tit fs-6">전공</label> <input type="text"
						id="proMajor" class="form-control" name="proMajor" readonly /> <label
						for="proTelno" class="tit fs-6">전화번호</label> <input type="text"
						id="proTelno" class="form-control" name="proTelno" />
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary btn-close">Close</button>
					<button type="submit" class="btn btn-primary">수정</button>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- modal -->

<div>${pagingHTML }</div>





<!-- Include your JavaScript file -->
<script src="<c:url value='/resorces/js/app/09/proView.js'/>"></script>
<script src="<c:url value='/resorces/js/app/common/paging.js'/>"></script>
