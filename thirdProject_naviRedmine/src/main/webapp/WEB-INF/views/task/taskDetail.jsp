<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
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



<!-- project veiw -->
<div class="view task">
	<div class="view_inner">
		<div class="view-info">
			<strong class="view-tit"> <span class="category project">T00001</span>
				<em>${task.taskTitle}</em></strong>
			<ul class="ul clearfix">

				<li><span class="list-tit">담당자</span> <span>${task.taskManEmp.empName }(${task.taskManEmp.deptName },${task.taskManEmp.psName })</span> <!-- <select class="select-box" aria-label="Default select example">
                                    <option selected>우민규(디자인1팀, 사원)</option>
                                    <option value="1">유길상(디자인1팀, 사원)</option>
                                    <option value="2">정민지(디자인1팀, 사원)</option>
                                    <option value="4">이상철(디자인1팀, 사원)</option>
                                    <option value="5">김태은(디자인1팀, 사원)</option>
                                </select> --></li>
				<!-- <li><span class="list-tit">진행기간</span><span>2024.04.05</span></li> -->
				<li><span class="list-tit">진행율</span>
					<div class="progress">
						<div class="progress-bar" role="progressbar"
							aria-label="Example with label" style="width: ${task.taskProcessStatus.tpsIng };"
							aria-valuenow="30" aria-valuemin="0" aria-valuemax="100">${task.taskProcessStatus.tpsIng }</div>
					</div> <!-- <select class="select-box" aria-label="Default select example">
                                    <option selected>10%</option>
                                    <option value="1">30%</option>
                                    <option value="2">50%</option>
                                    <option value="3">70%</option>
                                    <option value="4">90%</option>
                                    <option value="5">99%</option>
                                </select> --></li>
				<li><span class="list-tit">처리기한</span> <span>${task.taskCompDtStr }</span>

				</li>
				<li>
					<span class="list-tit">수정일</span>
					<c:if test="${not empty task.taskModDt }">
					 	<span>${task.taskModDtStr }</span>
					</c:if>
					<c:if test="${empty task.taskModDt }">
						<span>수정내역 없음</span>
					</c:if>
				</li>
				<li><span class="list-tit">등록일</span><span>${task.taskRegDtStr }</span></li>
				<!-- 프로젝트 상태값:
                                        <li><span class="">상태</span><span>신규</span></li>
                                        <li><span class="">상태</span><span>안정</span></li>
                                        <li><span class="">상태</span><span>긴급</span></li>
                                -->
				<li><span class="list-tit">등록자</span><span>${task.regEmp.empName }</span></li>
			</ul>
		</div>
		<div class="view_content">
			${task.taskCn }
		</div>
	</div>

</div>
<!-- project veiw -->
<!-- button -->
<div class="btn-box clearfix mt-4">
	<a href="${pageContext.request.contextPath }/task"><button
			class="btn btn-secondary">목록</button></a>
	<div class="right float-end">
		<!-- <button class="btn btn-danger">취소</button> -->
		<button class="btn btn-danger"data-bs-toggle="modal"
			data-bs-target="#deleteModal">삭제</button>
		<a href="${pageContext.request.contextPath }/task/mod/${task.taskId}">
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
				window.location.pathname='${pageContext.request.contextPath}/task'
			}else{
				deleteResult.innerHTML="삭제에 실패했습니다."
			}
		})
	})
	
	
})
</script>


