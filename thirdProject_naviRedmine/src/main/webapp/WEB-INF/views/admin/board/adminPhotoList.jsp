<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!-- 게시글 상세정보 MODAL -->
<c:forEach items="${photoList }" var="board">
	<div class="modal fade" id="${board.bpId}modal" tabindex="-1"
		aria-labelledby="photoModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-scrollable">
			<div class="modal-content admin-board">
				<div class="modal-header">
					<h5 class="modal-title" id="photoModalLabel">게시글 정보</h5>
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
										<td id="photoName">${board.bpTitle}</td>
									</tr>

									<tr>
										<th>작성자 :</th>
										<td id="photoEmp">${board.empName }</td>
									</tr>
									<tr>
										<th>작성일 :</th>
										<td id="photoDateStart">${board.bpRegDtStr }</td>
									</tr>
									<tr>
										<th>내용 :</th>
										<td></td>
									</tr>
								</tbody>
							</table>
							<div class="content" id="photoDetail">
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
	<input type="hidden" name="page" /> 
	<input type="hidden" name="simpleCondition.searchType" value="${paging.simpleCondition.searchType}" /> 
	<input type="hidden" name="simpleCondition.searchWord" value="${paging.simpleCondition.searchWord}" />
</form>
<!-- form  -->

<div class="header-title select">
	<h2>
		<strong class="title-name">커뮤니티 관리 - 포토게시판</strong>
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
<div data-pg-role="searchUI" data-pg-target="searchForm"
	class="searchBox d-flex justify-content-end">
	<!-- 입력용도 UI  -->
	<select class="me-1" name="simpleCondition.searchType">
		<!-- 프롬프트 옵션  value는 공백(whitespace) -->
		<option value="" label="전체" />
		<option value="name" label="제목" />
		<option value="address" label="작성자" />
	</select>

	<div class="fieldset flex">
		<input class="me-1" type="text" name="simpleCondition.searchWord"
			data-pg-init-value="${paging.simpleCondition.searchWord }"
			title="검색어를 입력해주세요" placeholder="검색어 입력"
			value="${paging.simpleCondition.searchWord }">
		<button type="button" class="btn btn-primary" data-pg-role="searchBtn">검색</button>
	</div>
</div>
<!-- 입력 및 검색용도 UI  -->

<div class="side_inner">
	<div class="content-box">
		<div class="content">
			<div class="inner html">

				<div class ="check-form">
				<strong>게시글 전체선택 </strong>
					<input class="form-check-input" type="checkbox" value=""
						id="flexCheckDefault" onclick="selectAll(this)">
						
				
				</div>
				<!-- ui : 포토공간목록 s -->
				<div class="row row-cols-1 row-cols-md-5 g-5 photo_list">


					<c:forEach items="${photoList}" var="board">
						<!-- col -->
						<div class="col">
								<div class="card">
									<div class="card-top"
										style="background-color: lavender; padding: 10px;">
										<input type="checkbox" class="photoCheckbox" id="photoCheck" value="${board.bpId}">
									</div>
									<div>
										<div class="photo-sizing text-center">
											<a href="#"  data-bs-toggle="modal" data-bs-target="#${board.bpId}modal">
												<img width="240px" height="250px" class="photomain" src="data:image/*;base64,${board.base64Img }" 
													class="photo-board photo-img " alt="">
											</a>
										</div>
									</div>
									<div class="card-body">
										<strong class="card-title"> <em class="text-elipsis">${board.bpTitle }</em>
										</strong>
										<c:set var="a" value="" />
										<c:forEach items="${bkList}" var="bk">
											<c:if test="${bk.bpId eq board.bpId}">
												<c:set var="a" value="active" />
											</c:if>
										</c:forEach>
									</div>
									<ul
										class="card-footer d-flex justify-content-between border-0 py-2 px-2">
										<li><span><i class="icon writer"><em
													class="sr-only">작성자</em></i>${board.empName }</span></li>
										<li><span><i class="icon date"><em
													class="sr-only">날짜</em></i>${board.bpRegDtStr} </span></li>
									</ul>
								</div>
						</div>
						<!-- col -->
					</c:forEach>

				</div>
			</div>

			<div class="bottom-set">
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
				<!-- pagenation -->
				${pagingHTML }
			</div>
		</div>
	</div>
</div>


<!-- pagenation -->

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
		const checkboxes = document.querySelectorAll('.photoCheckbox:checked');
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

<script src="${pageContext.request.contextPath }/resources/admin/js/adminMove.js"></script>
<script src="<c:url value='/resources/js/common/paging.js'/>"></script>