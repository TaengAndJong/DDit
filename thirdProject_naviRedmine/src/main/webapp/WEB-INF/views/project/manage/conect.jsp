<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<form id="searchForm">
	<input type="hidden" name="page" />
	<input type="hidden" name="role" value="${paging.detailCondition.role }" />
	<input type="hidden" name="word" value="${paging.detailCondition.word }" /> 
	<input type="hidden" name="state" value="${paging.detailCondition.state }" /> 
</form>
<%-- 				<form id="registerForm" action="${pageContext.request.contextPath}/project/register.do" method="get"></form> --%>
<div data-pg-role="searchUI" data-pg-target="#searchForm"
	class="searchBox d-flex justify-content-start">

	<form id="registerForm" class="me-auto"
		action="${pageContext.request.contextPath}/project/register.do"
		method="get">
	</form>
	<select class="me-1" name="role"
		data-pg-init-value="${paging.detailCondition.role }">
		<option value>역할선택</option>
		<c:forEach items="${roleList }" var="role">
			<option value="${role.roleId }">${role.roleName }</option>
		</c:forEach>
	</select>
	<select class="me-1" name="state"
		data-pg-init-value="${paging.detailCondition.state }">
		<option value>승인여부</option>
			<option value="Y">승인</option>
			<option value="N">해제</option>
	</select>
	<div class="fieldset flex">
		<input class="me-1" type="text" name="word"
			data-pg-init-value="${paging.detailCondition.word }"
			title="검색어를 입력해주세요" value="${paging.detailCondition.word }"
			placeholder="프로젝트 검색" />
		<button type="button" class="btn btn-primary" data-pg-role="searchBtn">검색</button>
	</div>

</div>


<!-- ui : table s -->
<table class="table text-center">
	<caption class="sr-only">사원 권한관리 테이블입니다.</caption>

	<colgroup>
		<col style="width: 15%;">
		<col style="width: 8%;">
		<col style="width: 8%;">
		<col style="width: 8%;">
		<col style="width: auto;">
		<col style="width: 10%;">
		<col style="width: 10%;">
		<col style="width: 10%;">
	</colgroup>

	<thead>
		<tr>

			<th scope="col">사원ID</th>
			<th scope="col">이름</th>
			<th scope="col">직급</th>
			<th scope="col">ROLE</th>
			<th scope="col">주소</th>
			<th scope="col">입사일</th>
			<th scope="col">일감진행현황</th>
			<th scope="col">권한</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${teamList }" var="tl">

			<!-- 일반 -->
			<tr>
				<th scope="row">${tl.empId }</th>
				<td>${tl.emp.empName }(${tl.emp.deptName})</td>
				<td>${tl.emp.psName}</td>
				<td>${tl.roleId }
					</td>
				<td class="text-start"><em class="text-elipsis">${tl.emp.empAddr } ${tl.emp.empAddr2}</em></td>
				<td>${tl.emp.empCmpYmdStr}</td>
				<td>${tl.taskIng}</td>
				<c:if test="${tl.teamYn eq 'Y'}">
					<td><button class="btn btn-danger" data-bs-toggle="modal" 
			data-bs-target="#${tl.empId }">권한해제</button></td>
				</c:if>
				<c:if test="${tl.teamYn eq 'N' }">
					<td><button class="btn btn-primary" data-bs-toggle="modal" 
			data-bs-target="#${tl.empId }">권한부여</button></td>
				</c:if>
			</tr>
			<!-- 일반 -->
			<div class="modal fade info" id="${tl.empId }" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<strong class="modal-title fs-5" id="exampleModalLabel">안내</strong>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body" id="${tl.empId }Btn">"권한을 변경하시겠습니까?"</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">닫기</button>
							<button type="submit" class="btn btn-primary role"data-emp-id="${tl.empId }" id="modifyBtn">확인</button>
						</div>
					</div>
				</div>
			
			</div>
		</c:forEach>
	</tbody>

</table>
${pagingHTML }
<script>
$(document).ready(function (e){
	function getCsrfToken(){
		return document.querySelector('meta[name="_csrf"]').getAttribute('content');
	}
	function getCsrfHeader(){
		return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
	}
	$(".role").on("click",function(e){
		let btn=e.target;
		let empId = $(btn).data("empId");
		console.log(empId)
		fetch("${pageContext.request.contextPath }/project/conect/${project.proId}/"+empId,{
			method:"POST",
			headers:{
				"Accept":"application/json",
				[getCsrfHeader()]: getCsrfToken()
			}
		}).then(resp=>{
			if(resp.ok){
				return resp.json();
			}else{
				throw new Error(`상태코드 ${resp.status} 수신`,{cause:resp})
			}
		}).then(jsonObj=>{
			let result=empId+'Btn';
			if(jsonObj.msg == 'ok'){
				$('#'+result).text("변경이 완료되었습니다.")
				location.reload()
			}else{
				$('#'+result).text("변경에 실패했습니다.")
				location.reload()
			}
		}).catch(err=>{
			console.error(err);
		})
	})
})
</script>


<script src="<c:url value='/resources/js/common/paging.js'/>"></script>