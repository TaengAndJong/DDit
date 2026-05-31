<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
.topBox {
	justify-content: space-between;
	width: 100%
}
</style>
<!-- ui 02 table-->
<div class="ui">

	<!-- 타이틀  -->
	<div class="topBox  mb-3 pb-2 border-bottom mt-1 flex">
		<strong class="title fs-5 text "> 강의목록 조회 </strong> <span
			class="loginUser">교수번호: ${proNo}</span>
	</div>
	<!-- 타이틀  -->


	<div class="inner html">
		<table class="table table table-bordered">

			<colgroup>
				<col style="width: 15%;">
				<col style="width: 10%;">
				<col style="width: auto;">
				<col style="width: 10%;">
			</colgroup>
			<thead>
				<tr class="table-primary text-center">
					<th>강의코드</th>
					<th>강의구분</th>
					<th>강의명</th>
					<th>학점</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${not empty subjcetList}">
						<c:forEach items="${subjcetList}" var="subject">
							<tr class="text-center">
								<td>${subject.subCd}</td>
								<td>${subject.subGubun}</td>
								<td class="text-start"><a href="javscript:;"
									data-val="${subject.subCd}">${subject.subName}</a></td>
								<td>${subject.subCredit}</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="4">조건에 맞는 회원이 없음.</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>
</div>

<form id="subjectForm"
	action='<c:url value="/professor/professorStudent.do"/>'>
	<input type="hidden" name="subCd">
</form>
<script
	src='<c:url value="/resorces/js/app/professor/professorList.js"/>'></script>