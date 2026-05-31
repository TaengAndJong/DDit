<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>


<!-- ui 02 table-->
<div class="ui">
	<strong class="ui-title">강의코드 ${subCd} - <small>강의 리스트
			조회</small></strong>
	<div class="content">
		<div class="inner html">
			<table class="table table table-bordered">

				<colgroup>
					<col style="width: 5%;">
					<col style="width: auto;">
					<col style="width: 20%;">
					<col style="width: 20%;">
					<col style="width: 10%;">
					<col style="width: 20%;">
					<col style="width: 5%;">
				</colgroup>
				<thead>
					<tr class="table-primary text-center">
						<th>학번</th>
						<th>이름</th>
						<th>전화번호</th>
						<th>주소</th>
						<th>지도교수</th>
						<th>점수부여</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty studentList}">
							<c:forEach items="${studentList}" var="student">
								<tr>
									<td>${student.stdNo}</td>
									<td>${student.stdName}</td>
									<td>${student.stdTelno}</td>
									<td>${student.stdAddress}</td>
									<td>${student.proNo}</td>
									<td>
										<input type="number" name="clsScore" max="100" min="1">
										<input type="button" name="btn"value="점수부여" data-st="${student.stdNo}">
									</td>
									<td data-result="${student.stdNo}"></td>
								</tr>
							</c:forEach>
						</c:when> 
						<c:otherwise>
							<tr>
								<td colspan="5">조건에 맞는 회원이 없음.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</div>
</div>
<form id="scoreForm" method="post" action='<c:url value="/professor/professorStudent.do"/>'>
	<input type="text" name="clsScore">
	<input type="text" name="stdNo" value="" >
	<input type="text" name="subCd" value="${subCd}">
</form>
<script src='<c:url value="/resorces/js/app/professor/score.js"/>'></script>