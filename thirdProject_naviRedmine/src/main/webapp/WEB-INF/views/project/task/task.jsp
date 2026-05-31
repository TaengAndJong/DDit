<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
#myProgress {
  width: 100%;
  background-color: grey;
}

#myBar {
  width: 1%;
  height: 30px;
  background-color: #5346db;
  text-align: center; /* To center it horizontally (if you want) */
  line-height: 30px; /* To center it vertically */
  color: white;
}
</style>

<%-- 일감안내 --%>
<div class="info_box red mb-5">
<strong><i class="info"></i>일감처리기간 기준 안내</strong>


	<ul class="ul bullet  mt-3">
		<li class="li "><span class="fw-bold mb-3">- 일감상태에 따른
				마감기한을 준수해주시면 감사하겠습니다.</span></li>
		<li class="li indent mb-2"><span class="category emergency ">긴급</span>
			<span class="mx-2">일 경우, 일감이 등록된 날로부터 최대 3일까지 처리</span></li>
		<li class="li indent mb-2"><span class="category ordinary">일반</span>
			<span class="mx-2">일 경우, 일감이 등록된 날로부터 최대 7일까지 처리</span></li>
		<li class="li indent mb-2"><span class="category new">신규</span><span
			class="mx-2">일 경우, 일반과 동일하게 처리</span></li>
	</ul>
<strong><i class="info"></i>현재 일감 현황</strong>
	<ul class="ul bullet  mt-3">
		<li class="li indent mb-2">
			<span class="category new">신규</span>
			<span class="mx-2">${addTaskCnt.T00001 }</span>
			<span class="category ordinary">일반</span>
			<span class="mx-2">${addTaskCnt.T00002 }</span>
			<span class="category emergency">긴급</span>
			<span class="mx-2">${addTaskCnt.T00003 }</span>
		</li>
	</ul>
	<strong class="h4 GmarketSans bold mb-0">전체 일감 진행률</strong>
	<div id="myProgress"class="mt-3">
	 	 <div id="myBar">1%</div>
	</div>
</div>
<%-- 일감안내 --%>

<script>
var i = 0;
move();
//프로젝트 진행률 스크립트
function move() {
  if (i == 0) {
    i = 1;
    var elem = document.getElementById("myBar");
    var width = 10;
    var id = setInterval(frame, 10);	//올라가는 시간 지연 용도
    function frame() {
      if (width >= ${addTaskCnt.totalIng }) {
        clearInterval(id);
        i = 0;
      } else {
        width++;
        elem.style.width = width + "%";
        elem.innerHTML = width + "%";
      }
    }
  }
}
</script>
<%-- 검색폼 --%>
<form id="searchForm">
	<input type="hidden" name="page" /> 
<!-- 일감 상태 검색 hidden input -->
	<input type="hidden" name="ts" value="${paging.detailCondition.ts }" /> 
<!-- 일감 진행률 검색 hidden input -->
	<input type="hidden" name="tps" value="${paging.detailCondition.tps }" /> 
<!-- 일감 내용 검색 hidden input -->
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
		<col style="width: 5%;">
		<col style="width: 10%;">
		<col style="width: auto;">
		<col style="width: 5%;">
		<col style="width: 5%;">
		<col style="width: 5%;">
		<col style="width: 8%;">
	</colgroup>

	<thead>
		<tr>
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
					<td>${task.taskId }</td>
					<td><c:if test="${task.taskStatus.tsName eq '일반'}">
							<span class="category ordinary">${task.taskStatus.tsName }</span>
						</c:if> <c:if test="${task.taskStatus.tsName eq '긴급'}">
							<span class="category emergency">${task.taskStatus.tsName }</span>
						</c:if> <c:if test="${task.taskStatus.tsName eq '신규'}">
							<span class="category new">${task.taskStatus.tsName }</span>
						</c:if></td>
					
					
					<td class="text-start"><a
						href="<c:url value='/project/task/${project.proId }/${task.taskId }'/>"> <em
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
		<a href="${pageContext.request.contextPath}/project/task/${project.proId }/taskRegister"
			class="btn btn-primary">등록</a>
	</div>
</div>
<!-- 버튼 알아서 퍼가셈 -->


<%-- 일감목록--%>


${pagingHTML }
<script src="<c:url value='/resources/js/common/paging.js'/>"></script>