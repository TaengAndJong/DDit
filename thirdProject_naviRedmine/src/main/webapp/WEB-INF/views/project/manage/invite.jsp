<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<form id="searchForm">
	<input type="hidden" name="page" /> <input type="hidden" name="word"
		value="${paging.detailCondition.word }" /> <input type="hidden"
		name="state" value="${paging.detailCondition.state }" />
</form>

<div data-pg-role="searchUI" data-pg-target="#searchForm"
	class="searchBox d-flex justify-content-start">

	<form id="registerForm" class="me-auto"
		action="${pageContext.request.contextPath}/project/register.do"
		method="get"></form>
	<div class="fieldset flex">
		<input class="me-1" type="text" name="word"
			data-pg-init-value="${paging.detailCondition.word }"
			title="검색어를 입력해주세요" value="${paging.detailCondition.word }"
			placeholder="프로젝트 검색" />
		<button type="button" class="btn btn-primary" data-pg-role="searchBtn">검색</button>
	</div>
</div>

<table class="table text-center">
	<caption class="sr-only">사원 권한관리 테이블입니다.</caption>

	<colgroup>
		<col style="width: 10%;">
		<col style="width: 10%;">
		<col style="width: 5%;">
		<col style="width: auto;">
		<col style="width: 10%;">
		<col style="width: auto;">
		<col style="width: 10%;">
		<col style="width: 10%;">
	</colgroup>

	<thead>
		<tr>

			<th scope="col">사원ID</th>
			<th scope="col">이름</th>
			<th scope="col">직급</th>
			<th scope="col">주소</th>
			<th scope="col">휴대번호</th>
			<th scope="col">이메일</th>
			<th scope="col">입사년도</th>
			<th scope="col">초대</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${outEmp}" var="oe">

			<!-- 일반 -->
			<tr>
				<th scope="row">${oe.empId }</th>
				<td>${oe.empName }(${oe.deptName})</td>
				<td>${oe.psName}</td>
				<td class="text-start"><em class="text-elipsis">${oe.empAddr }
						${oe.empAddr2}</em></td>
				<td>${oe.empPhone}</td>
				<td>${oe.empMail }</td>
				<td>${oe.empCmpYmdStr}</td>
				<td><button class="btn btn-primary" data-bs-toggle="modal"
						data-bs-target="#${oe.empId }">초대</button></td>
			</tr>
			<!-- 일반 -->
			<div class="modal fade" id="${oe.empId }" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<strong class="modal-title fs-5" id="exampleModalLabel">안내</strong>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body" id="${oe.empId }Btn">
							<form class="commonForm" action="${pageContext.request.contextPath }/project/invite/${project.proId }/${oe.empId }" data-emp-Id="${oe.empId }">
							<input type="hidden" name="empId" value="${oe.empId }">
								<fieldset>
									<legend>
										<span class="sr-only">개인정보 조회</span>
									</legend>

									<!-- 프로필 -->
									<div class="row profil">
										<div class="label col-sm-3">
											<label for="profilFile" class="form-label">프로필</label>
										</div>
										<div class="form_content col-sm-6">
											<div class="profil_img block">
												<div class="img-in">
												<c:if test="${empty oe.base64Img}">
													<img src="${pageContext.request.contextPath}/resources/images/prog/navi.jpg"
														alt="프로필이미지">
												</c:if>
												<c:if test="${not empty vo.base64Img}">
													<img src="data:image/*;base64,${oe.base64Img }" alt="프로필이미지">
												</c:if>
												</div>
											</div>
										</div>
									</div>
									<!-- 프로필 -->
									<!-- 이름 -->
									<div class="row text">
										<div class="label col-sm-3">
											<label for="disabledTextInput" class="form-label">성명</label>
										</div>
										<div class="form_content col-sm-6">
											<span>${oe.empName}</span>
										</div>
									</div>
									<!-- 이름 -->
									<!-- 비밀번호 -->
									<div class="row text">
										<div class="label col-sm-3">
											<label for="disabledTextInput" class="form-label">비밀번호</label>
										</div>
										<div class="form_content col-sm-6">
											<span>${oe.empPass}</span>
										</div>
									</div>
									<!-- 비밀번호 -->
									<!-- 나이 -->
									<div class="row text">
										<div class="label col-sm-3">
											<label for="disabledTextInput" class="form-label">나이</label>
										</div>
										<div class="form_content col-sm-6">
											<span>${oe.empAge} 살</span>
										</div>
									</div>
									<!-- 나이 -->
									<!-- 성별 -->
									<div class="row text">
										<div class="label col-sm-3">
											<label for="disabledTextInput" class="form-label">성별</label>
										</div>
										<div class="form_content col-sm-6">
											<span>${oe.empGenStr}</span>
										</div>
									</div>
									<!-- 성별 -->
									<!-- 부서 -->
									<div class="row text">
										<div class="label col-sm-3">
											<label for="disabledTextInput" class="form-label">부서</label>
										</div>
										<div class="form_content col-sm-9">
											<span>${oe.deptName}</span>
										</div>
									</div>
									<!-- 부서 -->
									<!-- 직급 -->
									<div class="row text">
										<div class="label col-sm-3">
											<label for="disabledTextInput" class="form-label">직급</label>
										</div>
										<div class="form_content col-sm-9">
											<span>${oe.psName}</span>
										</div>
									</div>
									<!-- 직급 -->
									<!-- 핸드폰 -->
									<div class="row tel">
										<div class="label col-sm-3">
											<label for="disabledTextInput" class="form-label">휴대폰번호</label>
										</div>
										<div class="form_content col-sm-9 d-flex">
											<span>${oe.empPhone}</span>
										</div>
									</div>
									<!-- 핸드폰 -->
									<!-- 주민번호 -->
									<div class="row identifyNum">
										<div class="label col-sm-3">
											<label for="disabledTextInput" class="form-label">주민등록번호</label>
										</div>
										<div class="form_content col-sm-6 d-flex">
											<span>${oe.empRrno}</span>
										</div>
									</div>
									<!-- 주민번호 -->
									<!-- 이메일 -->
									<div class="row email">
										<div class="label col-sm-3">
											<label for="disabledTextInput" class="form-label">이메일</label>
										</div>
										<div class="form_content col-sm-9 d-flex">
											<span>${oe.empMail}</span>
										</div>
									</div>
									<!-- 이메일 -->
									<!-- 주소 -->
									<div class="row address">
										<div class="label col-sm-3">
											<label for="disabledTextInput" class="form-label">주소</label>
										</div>
										<div class="form_content col-sm-9">
											<span>${oe.empZip} ${oe.empAddr} ${oe.empAddr2}</span>
										</div>
									</div>
									<!-- 주소 -->
									<!-- 입사일 -->
									<div class="row address">
										<div class="label col-sm-3">
											<label for="disabledTextInput" class="form-label">입사일</label>
										</div>
										<div class="form_content col-sm-9">
											<span>${oe.empCmpYmdStr}</span>
										</div>
									</div>
									<!-- 입사일 -->
									<!-- 경력 -->
									<div class="row address">
										<div class="label col-sm-3">
											<label for="disabledTextInput" class="form-label">경력</label>
										</div>
										<div class="form_content col-sm-9">
											<span>${oe.empCareer} 년</span>
										</div>
									</div>
									<!-- 경력 -->
									<div class="row select">
										<div class="label col-sm-3">
											<label for="disabledTextInput" class="form-label">역할선택</label>
										</div>
										<div class="form_content col-sm-9 d-flex">
											<div class="input col-sm-3 mx-1">
												<select class="form-select" name="roleId"
													aria-label="Default select example" title="관심분야를 선택해주세요"
													>
														<option value="">선택</option>
													<c:forEach items="${roleList }" var="role">
														<option value="${role.roleId}">${role.roleName}</option>
													</c:forEach>
												</select>
												<div class="${oe.empId }Result"></div>
											</div>
										</div>
									</div>
								</fieldset>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">닫기</button>
							<button type="button" class="btn btn-primary role modifyBtn"
								data-emp-id="${oe.empId }">확인</button>
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
	$(".modifyBtn").on("click",function(){
		let modalId=$(this).data("empId");
		$("#"+modalId+" .commonForm").submit()
	})
	$(".commonForm").on("submit",function(e){
		e.preventDefault();
		let form=e.target;
		let empId=$(form).data("empId")
		console.log("."+empId+"Result")
		let data={}
		let formData = new FormData(form);
		for(let e of formData.entries()){
			data[e[0]]=e[1];
		}
		let body = JSON.stringify(data);
		for(let e of formData.entries()){
			console.log(e)
			if(e[0]=="roleId"){
				if(e[1]==""){
					$("."+empId+"Result").html("역할을 설정해 주세요")
				}else{
					$("."+empId+"Result").html("")
					fetch(form.action,{
						method:"POST",
						headers:{
							"Accept":"application/json",
							[getCsrfHeader()]: getCsrfToken(),
							"Content-Type":"application/json"
						},body:body
					}).then(resp=>{
						if(resp.ok){
							return resp.json();
						}else{
							throw new Error(`상태코드 ${resp.status} 수신`,{cause:resp})
						}
					}).then(jsonObj=>{
						console.log(jsonObj)
						if(jsonObj=="ok"){
							alert("초대가 완료되었습니다.")
							location.reload();
						}else{
							alert("초대에 실패했습니다.")
						}
					}).catch(err=>{
						console.error(err);
					})
				}
			}
		}
	})
})
</script>


<script src="<c:url value='/resources/js/common/paging.js'/>"></script>