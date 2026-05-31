<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<c:forEach items="${empList }" var="emp">
<div class="modal fade info" id="${emp.empId}modal" tabindex="-1"
	aria-labelledby="employeeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
			<div class="modal-content admin-emp">
			<div class="modal-header adminmodal-header">
				<h5 class="modal-title" id="employeeModalLabel">사원 정보</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-4 border-right">
						<div class="text-center mb-3">
							<img src="https://www.ibric.org/upload/board/files/hbs_author/author_8/0040998_1.jpg?65524" class="rounded-circle img-thumbnail" alt="사원 사진">
						</div>
						<ul class="list-unstyled">
							<li><strong>이름:</strong> <span id="employeeName">${emp.empName }</span></li>
							<li><strong>이메일:</strong> <span id="employeeEmail">${emp.empMail }</span></li>
							<li><strong>핸드폰번호:</strong> <span id="employeePhone">${emp.empPhone }</span></li>
							<li><strong>나이:</strong> <span id="employeeAge">${emp.empAge }</span></li>
						</ul>
					</div>
					<div class="col-md-8">
						<table class="table table-sm">
							<tbody class="admin-table">
								<tr>
									<th>직급</th>
									<td id="employeePosition">${emp.psName }</td>
								</tr>
								<tr>
									<th>부서</th>
									<td id="employeeDeptName">${emp.deptName }</td>
								</tr>
								<tr>
									<th>주민번호</th>
									<td id="employeeResidentNumber">${emp.empRrno }</td>
								</tr>
								<tr>
									<th>주소</th>
									<td id="employeeAddress">${emp.empAddr } ${emp.empAddr2 }</td>
								</tr>
								<tr>
									<th>전화번호</th>
									<td id="employeeTel">${emp.empTel }</td>
								</tr>
								<tr>
									<th>입사일</th>
									<td id="employeeHireDate">${emp.empCmpYmdStr }</td>
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

<form id="searchForm">
	<input type="hidden" name="page"/>
	<input type="hidden" name="postion" value="${paging.detailCondition.postion }"/>
	<input type="hidden" name="dept"  value="${paging.detailCondition.dept }"/>
	<input type="hidden" name="word"  value="${paging.detailCondition.word }"/>
	<input type="hidden" name="pms" value="emp"/>
</form>


<div data-pg-role="searchUI" data-pg-target="#searchForm"
	class="searchBox d-flex justify-content-end mt-2">
	
	<select class="me-1" name="postion" data-pg-init-value="${paging.detailCondition.postion }">
			<option value>분류선택</option>
			<c:forEach items="${positionList }" var="ps">
				<option value="${ps.psId }">${ps.psName }</option>
			</c:forEach>
	</select>
	<select class="me-1" name="dept" data-pg-init-value="${paging.detailCondition.dept }">
			<option value>분류선택</option>
			<c:forEach items="${deptList }" var="dp">
				<option value="${dp.deptId }">${dp.deptName }</option>
			</c:forEach>
	</select>
	<div class="fieldset flex">
		<input class="me-1" type="text" name="word"
			data-pg-init-value="${paging.detailCondition.word }" title="검색어를 입력해주세요"
			value="${paging.detailCondition.word }"
			placeholder="사원 검색" />
		<button type="button" class="btn btn-primary"
			data-pg-role="searchBtn">검색</button>
	</div>
</div>

<!--inner-->
<div class="side_inner">
	<div class="content-box">
		<div class="content">
			<div class="inner html">
				<table class="table task-list text-center">
					<colgroup>
						<col style="width: 5%;">
						<col style="width: 5%;">
						<col style="width: 10%;">
						<col style="width: 5%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
					</colgroup>
					<thead class="admin-thead">
						<tr>
							<th scope="col">권한상태</th>
							<th scope="col">사원번호</th>
							<th scope="col">이름</th>
							<th scope="col">직급</th>
							<th scope="col">휴대번호</th>
							<th scope="col">이메일</th>
							<th scope="col">상세보기</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${empList }" var="emp">
							<tr>
								<th class="text-start">
								<c:if test="${emp.roleId ne null and 'ROLE_PRO_CREATE'.contains(emp.roleId)}">
									<div class="wk_con form-check form-switch">
										<label class="form-check-label" for="flexSwitchCheckChecked">팀장</label>
										<input class="form-check-input role" data-emp-id="${emp.empId}" data-role-id="${emp.roleId}"  type="checkbox" role="switch" checked />
									</div>
								</c:if>
								<c:if test="${emp.roleId == null or not 'ROLE_PRO_CREATE'.contains(emp.roleId)}">
									<div class="wk_con form-check form-switch">
										<label class="form-check-label" for="flexSwitchCheckChecked">팀장</label>
										<input class="form-check-input role" data-emp-id="${emp.empId}" data-role-id="${emp.roleId}" type="checkbox" role="switch"/>
									</div>
								</c:if>
								</th>
								<th scope="row">${emp.empId }</th>
								<td>${emp.empName}(${emp.deptName})</td>
								<td>${emp.psName }</td>
								<td>${emp.empPhone }</td>
								<td>${emp.empMail }</td>
								<td><button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#${emp.empId}modal">사원 상세정보</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
		<!--하단부 페이징 -->
		${pagingHTML}
		</div>
			</div>
	</div>
	<!-- 하단부 페이징과 삭제버튼 -->
</div>
<!--inner-->


<div class="modal" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" style="max-height: 250px;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header" style="background-color:#c5bfff;">
				<h1 class="modal-title fs-5" id="exampleModalLabel">권한 변경</h1>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>1
			<div class="modal-body">
				<div class="mb-3">
					<p id="modalMessage"></p>
				</div>
			</div>
			<div class="modal-footer">
				<button id="confirmBtn">확인</button>
			</div>
		</div>
	</div>
</div>


<script src="<c:url value='/resources/js/common/paging.js'/>"></script>
<script>
$(document).ready(function(){
    function getCsrfToken(){
        return document.querySelector('meta[name="_csrf"]').getAttribute('content');
    }
    function getCsrfHeader(){
        return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
    }

    function openModal(message) {
        $("#modalMessage").text(message);
        $("#myModal").show();
    }

    function closeModal() {
        $("#myModal").hide();
    }

    $(".role").on("change",function(e) {
        console.log(e.target);
        let checkBox=e.target;
        let empId=$(checkBox).data("empId");
        let roleId=$(checkBox).data("roleId");
        console.log(empId)
        fetch("${pageContext.request.contextPath}/admin/emp/empo?empId="+empId+"&roleId="+roleId,{
            method:"POST",
            headers:{
                "Accept":"application/json",
                [getCsrfHeader()]: getCsrfToken()
            }
        }).then(resp=>{
            if(resp.ok){
                return resp.json();
            } else {
                throw new Error(`상태코드 ${resp.status} 수신`,{cause:resp})
            }
        }).then(jsonObj=>{
            console.log(jsonObj);
            if (jsonObj.msg === "ok") {
                openModal("권한이 변경되었습니다.");
            }else if (jsonObj.msg === "fail") {
                openModal("이 사원은 프로젝트를 관리중입니다.");
            }
               setTimeout(() => {
   	            window.location.reload();
   	        }, 1000);
        }).catch(err=>{
            console.error(err);
        })
    });
    // 확인 버튼 클릭 시
    $("#confirmBtn").on("click", function() {
        window.location.reload();
    });
});
</script>
