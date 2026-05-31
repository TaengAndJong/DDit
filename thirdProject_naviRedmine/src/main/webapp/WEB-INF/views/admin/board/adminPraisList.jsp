<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<!-- 게시글 상세정보 MODAL -->
<c:forEach items="${praisList }" var="board">
	<div class="modal fade" id="${board.bpId}modal" tabindex="-1"
		aria-labelledby="praisModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-scrollable">
			<div class="modal-content admin-board">
				<div class="modal-header">
					<h5 class="modal-title" id="praisModalLabels">게시글 정보</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-12">
							<table class="table table-sm">
								<tbody class="admin-table">
									<tr>
										<th>제목 :</th>
										<td id="praisName">${board.bpTitle}</td>
									</tr>

									<tr>
										<th>작성자 :</th>
										<td id="praisEmp">${board.empName }</td>
									</tr>
									<tr>
										<th>작성일 :</th>
										<td id="praisDateStart">${board.bpRegDtStr }</td>
									</tr>
									<tr>
										<th>내용 :</th>
										<td></td>
									</tr>
								</tbody>
							</table>
							<div class="content" id="praisDetail">
								<p>${board.bpCn}</p>
							</div>
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
<!-- / 게시글 상세정보 MODAL -->

<!-- form  -->
<form id="searchForm">
	<input type="hidden" name="page"> <input type="hidden"
		name="simpleCondition.searchType"
		value="${paging.simpleCondition.searchType }"> <input
		type="hidden" name="simpleCondition.searchWord"
		value="${paging.simpleCondition.searchWord }">
</form>
<!-- form  -->

<div class="header-title select">
	<h2>
		<strong class="title-name">커뮤니티 관리 - 칭찬게시판</strong>
	</h2>
</div>


<!-- 2차 메뉴탭 -->
<div class="nav nav-tabs" id="nav-tab" role="tablist">
	<a href="${pageContext.request.contextPath }/admin/board/photo">
		<button class="nav-link active" id="nav7" data-bs-toggle="tab"
			data-bs-target="#nav7-con" type="button" role="tab"
			aria-controls="nav7-con" aria-selected="true">포토게시판</button>
	</a> <a href="${pageContext.request.contextPath }/admin/board/prais">
		<button class="nav-link" id="nav8" data-bs-toggle="tab"
			data-bs-target="#nav8-con" type="button" role="tab"
			aria-controls="nav8-con" aria-selected="false">칭찬게시판</button>
	</a> <a href="${pageContext.request.contextPath }/admin/board/share">
		<button class="nav-link" id="nav9" data-bs-toggle="tab"
			data-bs-target="#nav9-con" type="button" role="tab"
			aria-controls="nav9-con" aria-selected="false">나눔게시판</button>
	</a>
</div>
<!-- 2차 메뉴탭 -->






<!-- 입력 및 검색용도 UI  -->
<!-- searchBar -->
<div data-pg-role="searchUI" data-pg-target="#searchForm"
	class="searchBox d-flex justify-content-end">

	<select class="me-1" name="simpleCondition.searchType">
		<option value="" label="전체" />
		<option value="title" label="제목" />
		<option value="name" label="작성자" />
	</select>

	<div class="fieldset flex">
		<input class="me-1" type="text" name="simpleCondition.searchWord"
			data-pg-init-value="${paging.simpleCondition.searchWord }"
			title="검색어를 입력해주세요" value="${paging.simpleCondition.searchWord }"
			placeholder="검색어 입력" />
		<button type="button" class="btn btn-primary" data-pg-role="searchBtn">검색</button>
	</div>
</div>
<!-- searchBar -->
<!-- 입력 및 검색용도 UI  -->

<!-- ui : table s -->
<div class="side_inner">
	<div class="content-box">
		<div class="content">
			<div class="inner html">
				<!-- ui : table s -->
				<table class="table text-center">
					<caption class="sr-only">칭찬 목록 테이블입니다.</caption>

					<colgroup>
						<col style="width: 12%;">
						<col style="width: auto;">
						<col style="width: 15%">
						<col style="width: 15%">
						<col style="width: 10%;">

					</colgroup>

					<thead class="admin-thead">
						<tr>
							<%-- 	<strong style="display:block;">최고의 우수사원 : ${ }</strong> --%>
							<%-- 	<em style="display:block;">칭찬순위 : 2등 ${ } 3등 ${ }</em> --%>
						</tr>
						<tr>
							<th scope="col"><input class="form-check-input"
								type="checkbox" value="" id="flexCheckDefault"
								onclick="selectAll(this)"></th>
							<th scope="col">제목</th>
							<th scope="col">작성자</th>
							<th scope="col">등록일자</th>
							<th scope="col">조회수</th>
						</tr>
					</thead>

					<c:forEach items="${praisList }" var="pl">
						<tbody>
							<!-- 일반 -->
							<tr>
								<td><input type="checkbox" class="praisCheckbox" id="praisCheck" value="${pl.bpId}"></td>
								<td class="text-start">
									<!-- 새글일 때 new 클래스 추가 --> 
									<a style="display:ruby" href="#"  data-bs-toggle="modal" data-bs-target="#${pl.bpId}modal">
									<c:if test="${empty pl.nowCheck}">
										<em class="icon new_icon ">
											<span class="sr-only">new</span>
										</em>
									</c:if>
									<em class="text-elipsis">${pl.bpTitle }</em>
								</a>
								</td>
								<td>${pl.empName }</td>
								<td>${pl.bpRegDtStr }</td>
								<td>${pl.bpCnt }</td>
							</tr>
							<!-- 일반 -->

						</tbody>
					</c:forEach>
				</table>

				<div class="right float-end delete_content">
					<button class="btn btn-danger" data-bs-toggle="modal"
						data-bs-target="#deleteModal">삭제</button>
					<form id="deleteForm"
						action="${pageContext.request.contextPath }/admin/board/photo">
						<div class="modal fade info" id="deleteModal" tabindex="-1"
							aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<strong class="modal-title fs-5" id="deleteModalLabel">안내</strong>
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body" id="deleteResult">"해당 글을 삭제하시겠습니까?"</div>
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
				<!-- 버튼 알아서 퍼가셈 -->
				<!-- ui : table e -->
			</div>
		</div>
	</div>
</div>
<!-- 체크박스 전체 선택 및 해제 스크립트-->
<script> 
	function selectAll(selectAll)  {
		const checkboxes = document.querySelectorAll('input[type="checkbox"]');
	   	checkboxes.forEach((checkbox) => {
	    checkbox.checked = selectAll.checked
	   });
	}
</script>
<script src="${pageContext.request.contextPath }/resources/admin/js/adminMove.js"></script>
<!-- /체크박스 전체 선택 및 해제 스크립트-->
<script src="<c:url value='/resources/admin/js/manageShare.js'/>"></script>
<script src="<c:url value='/resources/js/common/paging.js'/>"></script>
<script>
$(document).ready(function(){
	function getCsrfToken(){
		return document.querySelector('meta[name="_csrf"]').getAttribute('content');
	}
	function getCsrfHeader(){
		return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
	}
	
//복구 FUNCTION -> CHECKED항목을 PROID타입의 배열로 전송하여 처리
	$(deleteForm).on("submit", function(e){
		e.preventDefault();
		const checkboxes = document.querySelectorAll('.praisCheckbox:checked');
		const bpIds = Array.from(checkboxes).map(checkbox => checkbox.value);
		console.log(bpIds)
		
		let arrayData=[];
		for(let i=0; i< bpIds.length; i++){
			let data={};
				data.bpId=bpIds[i];
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