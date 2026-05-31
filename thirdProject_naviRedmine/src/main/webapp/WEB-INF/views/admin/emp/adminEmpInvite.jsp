<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!-- 회원상세정보 MODAL -->
<c:forEach items="${empList }" var="emp">
<div class="modal fade" id="${emp.empId}modal" tabindex="-1" aria-labelledby="employeeModalLabel" aria-hidden="true">
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
							<a href="${pageContext.request.contextPath}/admin/facelogin">AI얼굴인식 등록하기</a>
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
<!-- / 회원상세정보 MODAL -->
<!-- paging 비교 조건부 -->
<form id="searchForm">
	<input type="hidden" name="page"/>
	<input type="hidden" name="postion" value="${paging.detailCondition.postion }"/>
	<input type="hidden" name="dept"  value="${paging.detailCondition.dept }"/>
	<input type="hidden" name="word"  value="${paging.detailCondition.word }"/>
	<input type="hidden" name="notpms" value="${paging.detailCondition.notpms }"/>
</form>
<!-- / paging 비교 조건부 -->
<!-- 분류 및 검색바 -->
 <div data-pg-role="searchUI" data-pg-target="#searchForm" class="searchBox d-flex justify-content-end mt-2">
	
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
		<button type="button" class="btn btn-primary" data-pg-role="searchBtn">검색</button>
	</div>
</div> 
<!-- / 분류 및 검색바 --> 
<!-- INNER CONTENT -->
<div class="side_inner">
	<div class="content-box">
		<div class="content">
			<div class="inner html">
				<table class="table task-list text-center">
					<colgroup>
						<col style="width: 5%;">
						<col style="width: 8%;">
						<col style="width: 8%;">
						<col style="width: 7%;">
						<col style="width: 10%;">
						<col style="width: 15%;">
						<col style="width: 15%;">
						<col style="width: 10%;">
					</colgroup>
					<thead class="admin-thead">
						<tr>
							<th scope="col"><input class="form-check-input"
								type="checkbox" value="" id="flexCheckDefault"
								onclick="selectAll(this)"></th>
							<th scope="col">사원번호</th>
							<th scope="col">이름</th>
							<th scope="col">직급</th>
							<th scope="col">휴대번호</th>
							<th scope="col">이메일</th>
							<th scope="col">주소</th>
							<th scope="col">상세보기</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${empList }" var="emp">
							<tr>
								<td><input type="checkbox" class="empCheckbox"></td>
								<td scope="row">${emp.empId }</td>
								<td>${emp.empName}(${emp.deptName})</td>
								<td>${emp.psName }</td>
								<td>${emp.empPhone }</td>
								<td>${emp.empMail }</td>
								<td class="">${emp.empAddr } ${emp.empAddr2}</td>
								<td><button type="button" class="btn btn-primary"
										data-bs-toggle="modal" data-bs-target="#${emp.empId}modal">사원
										상세정보</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				
				
				
				<!-- 삭제버튼과 삭제확인 모달 -->
				<div class="right float-end invite-content">
					<button class="btn btn-secondary invite-btn" data-bs-toggle="modal" data-bs-target="#inviteModal">초대</button>
					<form id="inviteForm" action="${pageContext.request.contextPath }/admin/emp/invite">
						<div class="modal fade" id="inviteModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content invite-content">
									<div class="modal-header">
										<strong class="modal-title fs-5" id="inviteModalLabel">안내</strong>
										<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body" id="inviteResult">"해당 사원을 초대하시겠습니까?"
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
										<button type="submit" class="btn btn-primary" id="inviteBtn">확인</button>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
		${pagingHTML}
			</div>
		</div>
		<!--하단부 페이징 -->
	</div>
</div>
<!-- / INNER CONTENT -->
<!-- SCRIPT IMPPORT -->
<script> 
	function selectAll(selectAll)  {
		const checkboxes = document.querySelectorAll('input[type="checkbox"]');
	   	checkboxes.forEach((checkbox) => {
	    checkbox.checked = selectAll.checked
	   });
	}
</script>
<script src="<c:url value='/resources/js/common/paging.js'/>"></script> 
<script src="${pageContext.request.contextPath}/resources/admin/js/manageEmpInvite.js"></script> 
<!-- / SCRIPT IMPPORT -->