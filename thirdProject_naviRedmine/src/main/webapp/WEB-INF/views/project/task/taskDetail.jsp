<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div class="modal fade" id="taskModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true"
	data-pro-id="${project.proId }">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<strong class="modal-title fs-5" id="exampleModalLabel">안내</strong>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body" id="in">
				<div id="taskList" data-list>
					<div class="row justify-content-end g-0">
						<div class="col-auto col-sm-5 mb-3">
							<form id="submitForm1"
								action="${pageContext.request.contextPath }/task/child/${task.taskId }"
								method="post">
								<div class="input-group">
									<input class="form-control form-control-sm shadow-none search"
										type="search" placeholder="Search..." aria-label="search" />
									<div class="input-group-text bg-transparent">
										<span class="fa fa-search fs-10 text-600"></span>
									</div>
								</div>
							</form>
						</div>
					</div>
					<div class="table-responsive scrollbar">

						<table class="table table-bordered table-striped fs-10 mb-0">
							<thead class="bg-200">
								<tr>
									<th class="text-900 sort" data-sort="taskId">일감번호</th>
									<th class="text-900 sort" data-sort="taskName">제목</th>
									<th class="text-900 sort" data-sort="taskManName">담당자</th>
									<th class="text-900 sort" data-sort="btn">선택</th>
								</tr>
							</thead>
							<tbody class="list" id="listBody1">
								<tr>
									<td class="taskId"></td>
									<td class="taskName"></td>
									<td class="taskManName"></td>
									<td class="btn"></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="d-flex justify-content-center mt-3">
						<button class="btn btn-sm btn-falcon-default me-1" type="button"
							title="Previous" data-list-pagination="prev">
							<span class="fas fa-chevron-left"></span>
						</button>
						<ul class="pagination mb-0"></ul>
						<button class="btn btn-sm btn-falcon-default ms-1" type="button"
							title="Next" data-list-pagination="next">
							<span class="fas fa-chevron-right"> </span>
						</button>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="submit" class="btn btn-secondary"
					data-bs-dismiss="modal">확인</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade info" id="deleteModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<strong class="modal-title fs-5" id="deleteModalLabel">안내</strong>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body" id="deleteResult">"일감을 삭제하시겠습니까?"</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-danger" id="deleteBtn">삭제</button>
			</div>
		</div>
	</div>

</div>

<div class="btn-box clearfix mt-4">
	<div class="right float-end">
		<button class="btn btn-primary" data-bs-toggle="modal"
			data-bs-target="#taskModal" id="childTaskBtn">하위 일감 조회</button>
	</div>
</div>
<!-- project veiw -->
<div class="view task">
	<div class="view_inner">
		<div class="view-info">
			<strong class="view-tit"> <span class="category project">${task.taskId }</span>
				<em>${task.taskTitle }</em></strong>
			<ul class="ul clearfix">

				<li><span class="list-tit">담당자</span> <span>${task.taskManEmp.empName }(${task.taskManEmp.deptName },${task.taskManEmp.psName })</span>
				<li><span class="list-tit">진행율</span>
					<div class="progress">
						<div class="progress-bar" role="progressbar"
							aria-label="Example with label"
							style="width: ${task.taskProcessStatus.tpsIng };"
							aria-valuenow="30" aria-valuemin="0" aria-valuemax="100">${task.taskProcessStatus.tpsIng }</div>
					</div>
				<li><span class="list-tit">처리기한</span> <span>${task.taskCompDtStr }</span>

				</li>
				<li><span class="list-tit">예상처리시간</span> <span>${task.taskEstTime }
						시간</span></li>

				<li><span class="list-tit">상태</span>
				<c:if test="${task.taskStatus.tsName eq '일반'}">
						<span>${task.taskStatus.tsName }</span>
					</c:if> <c:if test="${task.taskStatus.tsName eq '긴급'}">
						<span>${task.taskStatus.tsName }</span>
					</c:if> <c:if test="${task.taskStatus.tsName eq '신규'}">
						<span>${task.taskStatus.tsName }</span>
					</c:if></li>
				<li><span class="list-tit">수정일</span> <c:if
						test="${not empty task.taskModDt }">
						<span>${task.taskModDtStr }</span>
					</c:if> <c:if test="${empty task.taskModDt }">
						<span>수정내역 없음</span>
					</c:if></li>
				<li><span class="list-tit">등록일</span><span>${task.taskRegDtStr }</span></li>
				<li><span class="list-tit">등록자</span><span>${task.regEmp.empName }</span></li>
				<c:if test="${not empty task.taskTopId}">
					<li><span class="list-tit">상위일감</span><span>${task.taskTopId }</span></li>
				</c:if>
			</ul>
		</div>
		<div class="view_content">${task.taskCn }</div>
		<div class="content">
			<div class="inner html">
				<strong class="d-flex align-items-center mb-3"> 첨부파일 </strong>
				<c:choose>
					<c:when test="${empty fileList}">
						<div class="addfile">
							<ul class="fileList">
								<li
									class="d-flex file-row align-items-center justify-content-between mb-2">
									 <em
										class="file_name">첨부된 파일이 없습니다.</em>
								</li>
							</ul>
						</div>
					</c:when>
					<c:otherwise>
						<c:forEach items="${fileList }" var="f">
							<div class="addfile">
								<ul class="fileList">
									<li
										class="d-flex file-row align-items-center justify-content-between mb-2">
										<a
										href="${pageContext.request.contextPath }/task/download/${f.tfId}"
										class="file_item d-flex align-items-center"> <c:choose>
												<c:when test="${empty f.tfGbId}">
													<em class="file_name">첨부된 파일이 없습니다.</em>
												</c:when>
												<c:otherwise>
													<c:if test="${f.tfGbId eq 'pdf' }">
														<i class="icon pdf"><em class="sr-only">${f.tfGbId }</em></i>
													</c:if>
													<c:if test="${f.tfGbId eq 'txt' }">
														<i class="icon txt"><em class="sr-only">${f.tfGbId }</em></i>
													</c:if>
													<c:if test="${f.tfGbId eq 'jpg'}">
														<i class="icon txt"><em class="sr-only">${f.tfGbId }</em></i>
													</c:if>
													<c:if test="${f.tfGbId eq 'png' }">
														<i class="icon txt"><em class="sr-only">${f.tfGbId }</em></i>
													</c:if>
													<c:if test="${f.tfGbId eq 'word' }">
														<i class="icon word"><em class="sr-only">${f.tfGbId }</em></i>
													</c:if>
													<c:if test="${f.tfGbId eq 'xlsx' }">
														<i class="icon xlsx"><em class="sr-only">${f.tfGbId }</em></i>
													</c:if>
													<c:if test="${f.tfGbId eq 'zip' }">
														<i class="icon zip"><em class="sr-only">${f.tfGbId }</em></i>
													</c:if>
													<c:if test="${f.tfGbId eq 'hwp' }">
														<i class="icon hangle"><em class="sr-only">${f.tfGbId }</em></i>
													</c:if>
													<c:if test="${f.tfGbId eq 'ppt' }">
														<i class="icon ppt"><em class="sr-only">${f.tfGbId }</em></i>
													</c:if>
													<c:if test="${f.tfGbId eq 'pptx' }">
														<i class="icon ppt"><em class="sr-only">${f.tfGbId }</em></i>
													</c:if>
												</c:otherwise>
											</c:choose> <span class=""> <em class="file_name">${f.tfOrgNm }</em></span>
									</a> <span class="file_size p-1 border border-dark-subtle fileSize">${f.taskFileSize }</span>
									</li>
								</ul>

							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>

</div>
<!-- project veiw -->
<!-- button -->
<div class="btn-box clearfix mt-4">
	<a href="${pageContext.request.contextPath }/project/task/${task.proId}"><button
<%-- 	<a href="${pageContext.request.contextPath }/project/task/${task.proId}/taskRegister"><button --%>
			class="btn btn-secondary">목록</button></a>
	<div class="right float-end">
		<!-- <button class="btn btn-danger">취소</button> -->
		<button class="btn btn-danger" data-bs-toggle="modal"
			data-bs-target="#deleteModal">삭제</button>
		<a
			href="${pageContext.request.contextPath }/project/task/${project.proId }/mod/${task.taskId}">
			<button class="btn btn-primary">수정</button>
		</a>
	</div>
</div>
<!-- button -->
<script>
$(document).ready(function(){
	const cPath = document.body.dataset.contextPath;
	   function getCsrfToken(){
	      return document.querySelector('meta[name="_csrf"]').getAttribute('content');
	   }
	   function getCsrfHeader(){
	      return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
	   }
	   
	$(deleteBtn).on("click", function(e){
		
		fetch(cPath+"/task/${task.taskId}",{
			method:"DELETE",
			headers:{
				"accept":"application/json",
				[getCsrfHeader()]: getCsrfToken()
			}
		}).then(resp=>{
			if(resp.ok){
				return resp.json()
			}else{
				throw new Error("상태코드 "+resp.status)
			}
		}).then(jsonObj=>{
			console.log(jsonObj)
			if(jsonObj.msg=='ok'){
				deleteResult.innerHTML="삭제가 완료되었습니다."
				window.location.pathname='${pageContext.request.contextPath}/project/task/${project.proId}'
			}else{
				deleteResult.innerHTML="삭제에 실패했습니다."
			}
		})
	})
	
	
})
</script>

<script
	src="${pageContext.request.contextPath }/resources/js/listjs/taskDet.js"></script>

