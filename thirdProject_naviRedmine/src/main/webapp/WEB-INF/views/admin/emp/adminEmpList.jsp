<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<style>
.myprofil{
	  width: 250px;
    height: 280px;
    background-size: cover;
    border-radius: 70%;
}
</style>
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
						<c:if test="${empty emp.base64Img}">
								<img src="${pageContext.request.contextPath}/resources/images/prog/navi.jpg" class="rounded-circle img-thumbnail myprofil"alt="프로필이미지">
							</c:if>
							<c:if test="${not empty emp.base64Img}">
								<img src="data:image/*;base64,${emp.base64Img }" class="rounded-circle img-thumbnail myprofil" alt="프로필이미지">
							</c:if>
<!-- 							<img src="" class="rounded-circle img-thumbnail" alt="사원 사진"> -->
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
<!-- / 회원상세정보 MODAL -->
<!-- paging 비교 조건부 -->
<form id="searchForm">
	<input type="hidden" name="page"/>
	<input type="hidden" name="postion" value="${paging.detailCondition.postion }"/>
	<input type="hidden" name="dept"  value="${paging.detailCondition.dept }"/>
	<input type="hidden" name="word"  value="${paging.detailCondition.word }"/>
	<input type="hidden" name="pms" value="${paging.detailCondition.pms }"/>
</form>
<!-- / paging 비교 조건부 -->
<!-- INNER HEADER -->

<!-- / INNER HEADER -->



<!-- LIST전환 BUTTON -->
<div class="nav nav-tabs" id="nav-tab" role="tablist">
	<a href="${pageContext.request.contextPath }/admin/emp">
		<button class="nav-link active" id="nav1" data-bs-toggle="tab" data-bs-target="#nav1-con" type="button" role="tab" aria-controls="nav1-con" aria-selected="true">전체 사원 조회</button>
	</a>
	<a href="${pageContext.request.contextPath }/admin/emp?pms=pms">
		<button class="nav-link" id="nav2" data-bs-toggle="tab" data-bs-target="#nav2-con" type="button" role="tab" aria-controls="nav2-con" aria-selected="false">PMS 사원 조회</button>
	</a>
</div>
<!-- / LIST전환 BUTTON -->
<!-- 분류 및 검색바 -->
<div data-pg-role="searchUI" data-pg-target="#searchForm" class="searchBox d-flex justify-content-end">
	
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
<div class="side_inner" >
	<div class="content-box">
		<div class="content">
			<div class="inner html">
				<table class="table task-list text-center">
					<colgroup>
						<col style="width: 8%;">
						<col style="width: 6%;">
						<col style="width: 7%;">
						<col style="width: 7%;">
						<col style="width: 13%;">
						<col style="width: 15%;">
						<col style="width: 10%;">
					</colgroup>
					<thead class="admin-thead">
						<tr>
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
						<c:if test="${not empty empList }">
						<c:forEach items="${empList }" var="emp" >
							<tr>
								<td scope="row">${emp.empId }</td>
								<td>${emp.empName}(${emp.deptName})</td>
								<td>${emp.psName }</td>
								<td>${emp.empPhone }</td>
								<td>${emp.empMail }</td>
								<td class="text-start">${emp.empAddr } ${emp.empAddr2}</td>
								<td><button type="button" class="btn btn-primary"
								data-bs-toggle="modal" data-bs-target="#${emp.empId}modal">사원
								상세정보</button></td>
							</tr>
						</c:forEach>
							</c:if>
						<c:if test="${empty empList }">
							<tr>
								<td colspan="8" class="text-center">검색조건에 맞는 사원이 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		<!--하단부 페이징 -->
		${pagingHTML }
		</div>
	</div>
</div>
<!-- / INNER CONTENT -->
<!-- SCRIPT IMPPORT -->
<script src="${pageContext.request.contextPath }/resources/admin/js/adminMove.js"></script>
<script src="<c:url value='/resources/js/common/paging.js'/>"></script>
<!-- / SCRIPT IMPPORT -->