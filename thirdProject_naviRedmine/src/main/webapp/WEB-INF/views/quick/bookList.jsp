<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%-- 추천모달버튼 --%>
<div class="d-flex justify-content-end">
	<button type="button" class="btn btn-primary mb-3 "
		data-bs-toggle="modal" data-bs-target="#recomModal">도서추천</button>
</div>

<%-- 추천모달버튼 --%>


<%-- 추천모달 --%>
<div class="modal fade recomModal modal-center" id="recomModal"	tabindex="-1" aria-labelledby="recomModal" aria-hidden="true">
	<div class="modal-dialog modal-center">
		<div class="modal-content">
			<div class="modal-header text-black">
				<strong class="modal-title" id="recomModal">도서추천 Top3</strong>
			</div>
			<div class="modal-body">

				<!-- modal bottom -->
				<div class="row row-cols-3 g-4 list  common_list recomList" id="resultBookRecom">
					<c:forEach items="${recomList }" var="book">
						<!-- col -->
						<div class="col">
							<div class="card">
								<div class="photo_img">
									<div class="img-in">
										<img src="${book.bkUrl }" class="card-img-top" alt="${book.bkTtl }${book.bkAthr }">
									</div>
								</div>
								<div class="card-body">
									<strong class="text-elipsis"> ${book.bkTtl }</strong> 
									<span class=""> ${book.bkAthr }</span>
								</div>
							</div>
						</div>
						<!-- col -->
					</c:forEach>
				</div>
				<!-- modal bottom -->
			</div>
			<div class="modal-footer justify-content-center">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<%-- 추천모달 --%>

<form method="post" id="clickForm">
	<input type="hidden" name="bkListId">
</form>

<!-- ui : 포토공간목록 s -->
<div class="row row-cols-2 row-cols-md-4 g-4 list mb-4 common_list recomList" id="boodRecomList">
	<c:forEach items="${bookList }" var="book">
		<!-- col -->
		<div class="col">
			<div class="card">
				<div class="photo_img">
					<div class="img-in">
						<img src="${book.bkUrl }" class="card-img-top" alt="${book.bkTtl } ${book.bkAthr }">
					</div>
				</div>
				<div class="card-body clearfix">
					<strong class="text-elipsis"> ${book.bkTtl }</strong> <span
						class="card-title float-end clearfix"> ${book.bkAthr }</span>
					<button class="kinBtn border-0 recomBook"
						data-book-id="${book.bkListId}">
						<i class="icon kin"></i> <i class="sr-only">즐겨찾기버튼</i>
					</button>
					<div class="card-footer d-flex">
						<span class="text-elipsis">${book.bkCn}</span>
					</div>
				</div>
				
			</div>
		</div>
		<!-- col -->
	</c:forEach>
</div>
<!-- 스크립트 넣기  -->
<script>
const cPath = document.body.dataset.contextPath;
function getCsrfToken(){
	return document.querySelector('meta[name="_csrf"]').getAttribute('content');
}
function getCsrfHeader(){
	return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
}

	$(".recomBook").on("click",function(e){
		e.preventDefault;
		fetch(cPath+"/quick/book?bkListId="+$(this).data("book-id"),{
			method:"POST",
			headers:{
				"Accept":"application/json",
				"Content-Type":clickForm.enctype,
				[getCsrfHeader()]: getCsrfToken()
			}
		}).then(resp=>{
			if(resp.ok){
				 $(this).toggleClass("active");
				return resp.text();
			}else{
				throw new Error(`상태코드 ${resp.status} 수신`,{cause:resp})
			}
		}).then(text=>{
			console.log(text)
		}).catch(err=>{
			console.error(err);
		})
	})
</script>
<!-- 스크립트 넣기  -->
<!-- ui : 포토공간목록 e -->