<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<!-- 일감 상세정보 MODAL -->
<c:forEach items="${taskList }" var="task">
<div class="modal fade" id="${task.taskId}modal" tabindex="-1" aria-labelledby="taskModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content admin-emp">
			<div class="modal-header">
				<h5 class="modal-title" id="taskModalLabel">일감 정보</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row">
				
					<div class="col-md-12">
						<table class="table table-sm">
							<tbody class="admin-table">
								<tr>
									<th>일감명: </th>
									<td id="taskName">${task.taskTitle  }</td>
								</tr>
								<tr>
									<th>담당자: </th>
									<td id="taskEmpName">${task.taskManEmp.empName }</td>
								</tr>
								<tr>
									<th>일감 등록일 : </th>
									<td id="taskDateStart">${task.taskRegDtStr}</td>
								</tr>
								<tr>
									<th>진행률 : </th>
									<td id="taskIng">${task.taskProcessStatus.tpsIng}</td>
								</tr>
								
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-bs-dismiss="modal">뒤로가기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</c:forEach>
<!-- / 일감 상세정보 MODAL -->

<!-- form  -->
<form id="searchForm">
	<input type="hidden" name="page" /> 
	<input type="hidden" name="ts" value="${paging.detailCondition.ts }" /> 
	<input type="hidden" name="tps" value="${paging.detailCondition.tps }" /> 
	<input type="hidden" name="word" value="${paging.detailCondition.word }" />
</form>
<!-- form  -->

<div class="header-title select">
	<h2>
		<strong class="title-name">일감 관리</strong>
	</h2>
</div>

<!-- searchBar -->
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
			placeholder="일감 검색" />
		<button type="button" class="btn btn-primary" data-pg-role="searchBtn">검색</button>
	</div>

</div>
<!-- searchBar -->

<!-- ui : table s -->
<div class="side_inner">
	<div class="content-box">
		<div class="content">
			<div class="inner html">

				<table class="table task-list text-center">
					<caption class="sr-only">일감목록 테이블입니다.</caption>
					<colgroup>
						<col style="width: 5%">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
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
							<th scope="col">일감ID</th>
							<th scope="col">상태</th>
							<th scope="col">담당자</th>
							<th scope="col">제목</th>
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
									<td><input type="checkbox" class="taskCheckbox" id="taskCheck" value="${task.taskId}"></td>
									<th>${task.taskId }</th>
									<td><c:if test="${task.taskStatus.tsName eq '일반'}">
											<span class="category ordinary">${task.taskStatus.tsName }</span>
										</c:if> <c:if test="${task.taskStatus.tsName eq '긴급'}">
											<span class="category emergency">${task.taskStatus.tsName }</span>
										</c:if> <c:if test="${task.taskStatus.tsName eq '신규'}">
											<span class="category new">${task.taskStatus.tsName }</span>
										</c:if></td>
									<td>${task.taskManEmp.empName }</td>
										
									<td><a href="#" data-bs-toggle="modal" data-bs-target="#${task.taskId}modal"> 
										<em class="text-elipsis text-start"> &nbsp;${task.taskTitle }</em>
<%-- 										<c:if test="${empty task.nowCheck}"> --%>
<!-- 													<span class="icon new_icon"> -->
<!-- 														<span class="sr-only">new</span> -->
<!-- 													</span> -->
<%-- 												</c:if> --%>
										</a>
									</td>
									<td>${task.taskProcessStatus.tpsName }</td>
									<td>${task.taskProcessStatus.tpsIng }</td>
									<td>${task.taskRegDtStr}</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${empty taskList }">
							<tr>
								<td colspan="8" class="text-center">검색조건에 맞는 일감을 찾을 수 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
			<div class="right float-end delete_content">
				<button class="btn btn-danger" data-bs-toggle="modal"
					data-bs-target="#deleteModal">삭제</button>
				<form id="deleteForm"
					action="${pageContext.request.contextPath }/admin/task">
					<div class="modal fade info" id="deleteModal" tabindex="-1"
						aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<strong class="modal-title fs-5" id="deleteModalLabel">안내</strong>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
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
		</div>
		<!--하단부 페이징 -->

		<!-- 하단부 페이징과 삭제버튼 -->
	</div>
</div>

<script src="<c:url value='/resources/js/common/paging.js'/>"></script>
<script> 
	function selectAll(selectAll)  {
		const checkboxes = document.querySelectorAll('input[type="checkbox"]');
	   	checkboxes.forEach((checkbox) => {
	    checkbox.checked = selectAll.checked
	   });
	}
</script>

<script>
$(document).ready(function(){
	function getCsrfToken(){
		return document.querySelector('meta[name="_csrf"]').getAttribute('content');
	}
	function getCsrfHeader(){
		return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
	}
	
	$(deleteForm).on("submit", function(e){
		e.preventDefault();
		const checkboxes = document.querySelectorAll('.taskCheckbox:checked');
		const taskIds = Array.from(checkboxes).map(checkbox => checkbox.value);
		console.log(taskIds)
		
		let arrayData=[];
		for(let i=0; i< taskIds.length; i++){
			let data={};
				data.taskId=taskIds[i];
				arrayData.push(data);
		}
		
		let body =JSON.stringify(arrayData);
		
		fetch(deleteForm.action,{
			method:"DELETE",
			headers:{
				"accept": "application/json",
				"content-type": "application/json",
				[getCsrfHeader()]: getCsrfToken()
			},body:body
		}).then(resp=>{
			if(resp.ok){
				return resp.json()
			}else{
				throw new Error("상태코드 "+resp.status)
			}
		}).then(jsonObj=>{		
			console.log(jsonObj)
	        if (jsonObj.msg == 'empty'){
		 		deleteResult.innerHTML = "선택된 항목이 없습니다.";
			} else if (jsonObj.msg == 'ok') {
	            deleteResult.innerHTML = "삭제가 완료되었습니다.";
	        } else {
	            deleteResult.innerHTML = "삭제에 실패했습니다.";
	        }
	        setTimeout(() => {
	            window.location.reload();
	        }, 1000);
		})
	})

})

</script>
