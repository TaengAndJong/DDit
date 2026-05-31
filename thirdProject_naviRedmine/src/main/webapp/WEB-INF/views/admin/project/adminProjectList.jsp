<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!-- 프로젝트 상세정보 MODAL -->
<c:forEach items="${projectList }" var="project">
	<div class="modal fade" id="${project.proId}modal" tabindex="-1"
		aria-labelledby="projectModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content admin-emp">
				<div class="modal-header">
					<h5 class="modal-title" id="projectModalLabel">프로젝트 정보</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">

					<div id="project-info">
						<div class="p-2">
							<div class="view_content info_box red mb-5">${project.proDesc }</div>
						</div>
					</div>

					<div class="row">

						<div class="col-md-12">
							<table class="table table-sm">
								<tbody class="admin-table">
									<tr>
										<th>프로젝트명:</th>
										<td id="projectName">${project.proName }</td>
									</tr>
									<tr>
										<th>프로젝트관리자:</th>
										<td id="projectAdmin">${project.empName }</td>
									</tr>
									<tr>
										<th>프로젝트 등록일 :</th>
										<td id="projectDateStart">${project.proRegDtStr }</td>
									</tr>
									<tr>
										<th>프로젝트 마감예정일 :</th>
										<td id="projectDateExit">${project.proDdlineExStr}</td>
									</tr>

								</tbody>
							</table>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary"
								data-bs-dismiss="modal">뒤로가기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</c:forEach>
<!-- / 프로젝트 상세정보 MODAL -->


<!-- form  -->
<form id="searchForm">
	<input type="hidden" name="page" /> <input type="hidden"
		name="projectState" value="${paging.detailCondition.projectState }" />
	<input type="hidden" name="project"
		value="${paging.detailCondition.project }" /> <input type="hidden"
		name="ing" value="${paging.detailCondition.ing }" />

</form>
<!-- form  -->

<div class="header-title select">
	<h2>
		<strong class="title-name">프로젝트 관리</strong>
	</h2>
</div>

<!-- 사원 분류별 숫자를 보여주는 container -->
<div class="container">
	<h5 class="my-4"></h5>
	<div class="row">
		<div class="col-lg-3">
			<div class="card emp">
				<div class="card-body d-flex ">
					<div>
						<p class="card-text mb-2">신규</p>
						<h4>${newTotal }</h4>
					</div>
				</div>
			</div>
		</div>

		<div class="col-lg-3">
			<div class="card pms">
				<div class="card-body d-flex ">
					<div>
						<p class="card-text mb-2">긴급</p>
						<h4>${quickTotal }</h4>
					</div>
				</div>
			</div>
		</div>

		<div class="col-lg-3">
			<div class="card pl">
				<div class="card-body d-flex ">
					<div>
						<p class="card-text mb-2">안정</p>
						<h4>${safeTotal }</h4>
					</div>
				</div>
			</div>
		</div>

		<div class="col-lg-3">
			<div class="card block">
				<div class="card-body d-flex ">
					<div>
						<p class="card-text mb-2">삭제된 프로젝트</p>
						<h4>${delTotal }</h4>
					</div>
				</div>
			</div>
		</div>

	</div>
</div>

<!-- 2차 메뉴탭 -->
<div class="nav nav-tabs" id="nav-tab" role="tablist">
	<a href="${pageContext.request.contextPath }/admin/project/?ing=ing">
		<button class="nav-link active" id="nav5" data-bs-toggle="tab"
			data-bs-target="#nav5-con" type="button" role="tab"
			aria-controls="nav5-con" aria-selected="true">프로젝트 삭제</button>
	</a> <a href="${pageContext.request.contextPath }/admin/project/?ing=end">
		<button class="nav-link" id="nav6" data-bs-toggle="tab"
			data-bs-target="#nav6-con" type="button" role="tab"
			aria-controls="nav6-con" aria-selected="false">프로젝트 복구</button>
	</a>
</div>
<!-- 2차 메뉴탭 -->

<!-- 입력 및 검색용도 UI  -->
<div data-pg-role="searchUI" data-pg-target="#searchForm"
	class="searchBox d-flex justify-content-end">
	<div class="fieldset flex">
		<!-- 분류선택 드롭박스 -->
		<select class="me-1" name="projectState"
			data-pg-init-value="${paging.detailCondition.projectState }">
			<option value>분류선택</option>
			<c:forEach items="${projectStateList }" var="prost">
				<option value="${prost.cmId }">${prost.cmName }</option>
			</c:forEach>
		</select>
		<!-- 검색어입력 텍스트박스 -->
		<input class="me-1" type="text" name="project"
			data-pg-init-value="${paging.detailCondition.project }"
			title="검색어를 입력해주세요" value="${paging.detailCondition.project }"
			placeholder="프로젝트 검색" />
		<!-- 검색 버튼 -->
		<button type="button" class="btn btn-primary" data-pg-role="searchBtn">검색</button>
	</div>
</div>
<!-- /입력 및 검색용도 UI  -->

<!--inner content-->
<div class="side_inner">
	<div class="content-box">
		<div class="content">
			<div class="inner html">
				<!-- 프로젝트 목록 조회 테이블 -->
				<table class="table task-list text-center">
					<colgroup>
						<col style="width: 5%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 45%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
					</colgroup>
					<thead class="admin-thead">
						<tr>
							<th scope="col"><input class="form-check-input"
								type="checkbox" value="" id="flexCheckDefault"
								onclick="selectAll(this)"></th>
							<th scope="col">프로젝트ID</th>
							<th scope="col">상태</th>
							<th scope="col">담당자</th>
							<th scope="col">프로젝트명</th>
							<th scope="col">등록일</th>
							<th scope="col">마감 예정일</th>
						</tr>
					</thead>

					<tbody>
						<!--프로젝트 실 유무에 따른 예외처리 및 리스트 -->
						<c:if test="${not empty projectList }">
							<c:forEach items="${projectList }" var="project">
								<tr>
									<!-- 1.체크박스 -->
									<td><input type="checkbox" class="projectCheckbox"></td>
									<!-- 2.프로젝트 ID -->
									<td>${project.proId }</td>
									<!-- 3.프로젝트 상태 -->
									<td><c:if test="${project.proStId eq 'PS0002'}">
											<span class="category cate3">안정</span>
										</c:if> <c:if test="${project.proStId eq 'PS0003'}">
											<span class="category emergency">긴급</span>
										</c:if> <c:if test="${project.proStId  eq 'PS0001'}">
											<span class="category new">신규</span>
										</c:if></td>
									<!-- 4.프로젝트 담당자 ID -->
									<td>${project.empName}</td>
									<!-- 5.프로젝트 이름 -->
									<td class="text-start elipsis"><a href="#" data-bs-toggle="modal"
										data-bs-target="#${project.proId}modal">${project.proName }</a></td>
									<!-- 6.등록일 -->
									<td>${project.proRegDtStr}</td>
									<!-- 7.마감일 -->
									<td>${project.proDdlineExStr}</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${empty projectList }">
							<tr>
								<td colspan="7" class="text-center">현재 프로젝트가 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
				<!-- // 프로젝트 목록 조회 테이블 -->
				<tfoot>
					<!-- 삭제버튼과 삭제확인 모달 -->
					<div class="right float-end delete_content">
						<button class="btn btn-danger" data-bs-toggle="modal"
							data-bs-target="#deleteModal">삭제</button>
						<form id="deleteForm"
							action="${pageContext.request.contextPath }/admin/project">
							<div class="modal fade info" id="deleteModal" tabindex="-1"
								aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<strong class="modal-title fs-5" id="deleteModalLabel">안내</strong>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body" id="deleteResult">"프로젝트를
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

					<!-- // 삭제버튼과 삭제확인 모달 -->
					<!-- 복구버튼과 복구확인 모달 -->
					<div class="right float-end restore_content">
						<button class="btn btn-primary" data-bs-toggle="modal"
							data-bs-target="#restoreModal">복구</button>
						<form id="restoreForm"
							action="${pageContext.request.contextPath }/admin/project">

							<div class="modal fade info" id="restoreModal" tabindex="-1"
								aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<strong class="modal-title fs-5" id="restoreModalLabel">안내</strong>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body" id="restoreResult">"프로젝트를
											복구하시겠습니까?"</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-bs-dismiss="modal">닫기</button>
											<button type="submit" class="btn btn-primary" id="restoreBtn">복구</button>
										</div>
									</div>
								</div>
							</div>
						</form>
					</div>
					<!-- //복구버튼과 복구확인 모달 -->
				</tfoot>
				<!-- 하단부 페이징과 삭제버튼 -->
				${pagingHTML }
			</div>
		</div>
	</div>
</div>
<!--// inner content-->

<script src="<c:url value='/resources/js/common/paging.js'/>"></script>
<script
	src="${pageContext.request.contextPath }/resources/admin/js/manageProject.js"></script>

<!-- 체크박스 전체 선택 및 해제 스크립트-->
<script> 
	function selectAll(selectAll)  {
		const checkboxes = document.querySelectorAll('input[type="checkbox"]');
	   	checkboxes.forEach((checkbox) => {
	    checkbox.checked = selectAll.checked
	   });
	}
</script>
<!-- /체크박스 전체 선택 및 해제 스크립트-->
<!-- url 뒤 3자리에 따른 button 표시여부 스크립트-->
<script>
    // 현재 페이지 URL 가져오기
    var currentPageUrl = window.location.href;

    // URL 뒤의 세 글자 확인
    var lastThreeChars = currentPageUrl.substr(-3);

    // 삭제 및 복구 버튼 영역 선택
    var deleteContent = document.querySelector('.delete_content');
    var restoreContent = document.querySelector('.restore_content');

    // URL 뒤의 세 글자에 따라 조건 분기
    if (lastThreeChars === 'ing') {
        // "ing"로 끝나는 경우, 삭제 버튼 영역 표시
        deleteContent.style.display = 'block';
        restoreContent.style.display = 'none'; // 다른 영역은 숨기기
    } else if (lastThreeChars === 'end') {
        // "end"로 끝나는 경우, 복구 버튼 영역 표시
        deleteContent.style.display = 'none'; // 다른 영역은 숨기기
        restoreContent.style.display = 'block';
    } else {
        // 그 외의 경우, 모든 영역 숨기기
        deleteContent.style.display = 'none';
        restoreContent.style.display = 'none';
    }
</script>


<!-- / url 뒤 3자리에 따른 button 표시여부 스크립트-->


<script
	src="${pageContext.request.contextPath }/resources/admin/js/adminMove.js"></script>


