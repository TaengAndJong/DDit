<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- 검색폼 --%>
<form id="searchForm">
	<input type="hidden" name="page" /> 
	<input type="hidden" name="ts" value="${paging.detailCondition.ts }" /> 
	<input type="hidden" name="tps" value="${paging.detailCondition.tps }" /> 
	<input type="hidden" name="word" value="${paging.detailCondition.word }" />
</form>
<%-- 				<form id="registerForm" action="${pageContext.request.contextPath}/project/register.do" method="get"></form> --%>
<div data-pg-role="searchUI" data-pg-target="#searchForm"
	class="searchBox d-flex justify-content-end">

	<select class="me-1" name="ts"
		data-pg-init-value="${paging.detailCondition.ts }">
		<option value="">일감 상태</option>
		<c:forEach items="${taskStatusList }" var="ts">
			<option value="${ts.tsId }">${ts.tsName }</option>
		</c:forEach>
	</select> <select class="me-1" name="tps"
		data-pg-init-value="${paging.detailCondition.tps }">
		<option value="">진행률</option>
		<c:forEach items="${taskProcessStatusList }" var="tps">
			<option value="${tps.tpsId }">${tps.tpsIng }</option>
		</c:forEach>
	</select>
	<div class="fieldset flex">
		<input class="me-1" type="text" name="word"
			data-pg-init-value="${paging.detailCondition.word }"
			title="검색어를 입력해주세요" value="${paging.detailCondition.word }"
			placeholder="프로젝트 검색" />
		<button type="button" class="btn btn-primary" data-pg-role="searchBtn">검색</button>
	</div>

</div>


<%-- 검색 --%>
<%-- 검색폼 --%>
<%-- 일감목록 --%>

<table class="table text-center">
	<caption class="sr-only">일감목록 테이블입니다.</caption>
	<colgroup>
		<col style="width: 5%">
		<col style="width: 8%;">
		<col style="width: 10%;">
		<col style="width: 10%;">
		<col style="width: auto;">
		<col style="width: 10%;">
		<col style="width: 10%;">
		<col style="width: 10%;">
		<col style="width: 10%;">
	</colgroup>

	<thead>
		<tr>
			<th><input type="checkbox"></th>
			<th scope="col">번호</th>
			<th scope="col">일감ID</th>
			<th scope="col">상태</th>
			<th scope="col">제목</th>
			<th scope="col">담당자</th>
			<th scope="col">진행상태</th>
			<th scope="col">진행률</th>
			<th scope="col">등록일</th>
		</tr>
	</thead>
	<tbody>
		<!-- 	<span class="category ordinary">일반</span>
				<span class="category emergency">긴급</span>
				<span class="category new">신규</span> -->
		<!-- 일반 -->

		<c:if test="${not empty taskList }">
			<c:forEach items="${taskList }" var="task">
				<tr>
					<th><input type="checkbox"></th>
					<td>${task.rnum }</td>
					<td>${task.taskId }</td>
					<td><c:if test="${task.taskStatus.tsName eq '일반'}">
							<span class="category ordinary">${task.taskStatus.tsName }</span>
						</c:if> <c:if test="${task.taskStatus.tsName eq '긴급'}">
							<span class="category emergency">${task.taskStatus.tsName }</span>
						</c:if> <c:if test="${task.taskStatus.tsName eq '신규'}">
							<span class="category new">${task.taskStatus.tsName }</span>
						</c:if></td>
					<td class="text-start"><a
						href="<c:url value='/task/${task.taskId }'/>"> <em
							class="text-elipsis"><span class="fw-bold">[${task.projectVO.proName}]</span>
								&nbsp;${task.taskTitle }</em>
					</a></td>
					<td>${task.taskManEmp.empName }</td>
					<td>${task.taskProcessStatus.tpsName }</td>
					<td>${task.taskProcessStatus.tpsIng }</td>
					<td>${task.taskRegDtStr}</td>
				</tr>
			</c:forEach>

		</c:if>

	</tbody>

</table>

<div class="btn-box clearfix mt-4">
	<div class="right float-end">
		<a href="${pageContext.request.contextPath}/task/taskRegister"
			class="btn btn-primary">등록</a>
	</div>
</div>
<!-- 버튼 알아서 퍼가셈 -->


<%-- 일감목록--%>


${pagingHTML }
<script src="<c:url value='/resources/js/common/paging.js'/>"></script>