<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
.formBox{padding:20px 0;justify-content: flex-end; width: 100%;}
</style>


<!-- 타이틀  -->
<div class="topBox  mb-3 pb-2 border-bottom mt-1">
	<strong class="title fs-5 text ">교직원-학생정보</strong>
</div>
<!-- 타이틀  -->

<!-- 검색  -->
<form id="searchForm"
	action="<c:url value='/staff/staffStudentList.do'/>">
	<input type="hidden" name="page" /> <input type="hidden"
		name="searchType" value="${condition.searchType}" /> <input
		type="hidden" name="searchWord" value="${condition.searchWord}" />
</form>

<div data-pg-role="searchUI" data-pg-target="#searchForm" class="formBox flex">
	<select name="searchType" data-pg-init-value="${condition.searchType}">
		<option value>전체</option>
		<!-- 프롬프트 옵션  value는 공백 -->
		<option value="stdNo">학번</option>
		<option value="stdName">이름</option>
		<option value="proNo">담임교수</option>
	</select> <input type="text" name="searchWord"
		data-pg-init-value="${condition.searchWord}" title="검색어를 입력해주세요"
		placeholder="검색어를 입력해주세요" />
	<button type="button" class="btn btn-primary" data-pg-role="searchBtn">검색</button>
</div>
<!-- 검색 -->


<!-- ui : s -->
<table class="table table table-bordered" id="modalTable">
	<thead>
		<tr class="table-primary">
			<th>학번</th>
			<th>이름</th>
			<th>주민번호</th>
			<th>전화번호</th>
			<th>주소</th>
			<th>지도교수</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${not empty staffStudentList }">
			<c:forEach items="${staffStudentList }" var="student">
				<tr>
					<td class="stdNo">${student.stdNo }</td>
					<td class="stdName"><a href="javascript:;" title="학생이름"
						data-student-name="${student.stdName}"> ${student.stdName} </a></td>
					<td class="stdId">${student.stdId }</td>
					<td class="stdTelno">${student.stdTelno }</td>
					<td class="stdAddress">${student.stdAddress }</td>
					<td class="proNo">${student.proNo }</td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty staffStudentList }">
			<tr>
				<td colspan="6">학생 없음.</td>
			</tr>
		</c:if>
	</tbody>
</table>

<!-- modal -->
<div class="modal " id="">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<strong class="modal-title fs-5" id="exampleModalLabel">학생정보수정</strong>
			</div>
			<form id="updateForm">
				<div class="modal-body">
					<label for="stdNo" class="tit fs-6">학번</label> 
					<input type="text"
						id="stdNo" class="form-control" name="stdNo" readonly /> <label
						for="stdName" class="tit fs-6">이름</label> <input type="text"
						id="stdName" class="form-control" name="stdName" readonly /> <label
						for="stdId" class="tit fs-6">주민번호</label> <input type="text"
						id="stdId" class="form-control" name="stdId" readonly /> <label
						for="stdTelno" class="tit fs-6">전화번호</label> <input type="text"
						id="stdTelno" class="form-control" name="stdTelno" /> <label
						for="stdAddress" class="tit fs-6">주소</label> <input type="text"
						id="stdAddress" class="form-control" name="stdAddress" /> <label
						for="proNo" class="tit fs-6">지도교수</label> <input type="text"
						id="proNo" class="form-control" name="proNo" readonly />
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" id="closeBtn">닫기</button>
					<button type="submit" class="btn btn-primary">수정</button>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- modal -->
<div>
${pagingHTML }
</div>






<!-- Include your JavaScript file -->
<script src="<c:url value='/resorces/js/app/09/stdView.js'/>"></script>
<script src="<c:url value='/resorces/js/app/common/paging.js'/>"></script>

