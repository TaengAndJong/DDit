<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<style>

#recomModal .modal-dialog { max-height:520px}
</style>


<%-- 추천모달버튼 --%>
<div class="d-flex justify-content-end">
	<button type="button" class="btn btn-primary mb-3 " id="newsRecomBtn"
		data-bs-toggle="modal" data-bs-target="#recomModal">뉴스추천</button>
</div>

<%-- 추천모달버튼 --%>



<%-- 추천모달 --%>
<div class="modal fade recomModal" id="recomModal" tabindex="-1"
	aria-labelledby="recomModal" aria-hidden="true">

	<div class="modal-dialog modal-fullsize">
		<div class="modal-content" >
			<div class="modal-header bg-primary text-white">
				<strong class="modal-title" id="recomModal">뉴스추천</strong>
			</div>
			<div class="modal-body" id="modalRecom">

				<!-- modal bottom -->
				<div class="row row-cols-3 common_list recomList">
				<c:forEach items="${recomList}" var="news">
						<div class="col recomNews" data-news-id="${news.newsCgId}">
					<a href="${news.newsUrl }"> <!-- col -->
							<div class="card">
								<div class="photo_img">
									<div class="img-in">
										<img src="${news.newsImgUrl}" class="card-img-top" alt="${news.newsCgName }">
									</div>
								</div>
							
								<div class="card-body">
									<strong class="card-title"> <em class="text-elipsis">${news.newsCgName }</em>
									</strong>
										<ul
											class="card-footer d-flex justify-content-between border-0 py-0">
											<li><span><i class="icon writer"><em
														class="sr-only">작성자</em></i> ${news.newsRepot } </span></li>
											<li><span><i class="icon date"><em
														class="sr-only">날짜</em></i>${news.newsRegDt } </span></li>
										</ul>
								</div>
							
							</div>
					</a>
						</div> <!-- col -->
				</c:forEach>
				</div>
				<!-- modal bottom -->
			</div>
			<div class="modal-footer justify-content-center">
				<button type="button" class="btn btn-light btn-outline-secondary"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<%-- 추천모달 --%>
<form method="post" id="clickForm">
	<input type="hidden" name="newsId">
</form>
<!-- ui : 포토공간목록 s -->
<div class="row row-cols-1 row-cols-md-4 g-4 common_list recomList mb-4" id="newsRecomList">
	<c:forEach items="${newsList }" var="news">
		<a href="${news.newsUrl }"> <!-- col -->
			<div class="col recomNews" data-news-id="${news.newsCgId}">
				<div class="card">
					<div class="photo_img">
						<div class="img-in">
							<img src="${news.newsImgUrl }" class="card-img-top" alt="${news.newsCgName }">
						</div>
					</div>
					<div class="card-body">
						<strong class="card-title">
							<em class="text-elipsis">${news.newsCgName }</em>
						</strong>
						<ul class="card-footer d-flex justify-content-between border-0 py-0">
							<li><span><i class="icon writer"><em
										class="sr-only">작성자</em></i> ${news.newsRepot } </span></li>
							<li><span><i class="icon date"><em class="sr-only">날짜</em></i>${news.newsRegDt }
							</span></li>
						</ul>
					</div>
					
				</div>
			</div> <!-- col -->
		</a>
	</c:forEach>
</div>
<script type="text/javascript">
const cPath = document.body.dataset.contextPath;
function getCsrfToken(){
	return document.querySelector('meta[name="_csrf"]').getAttribute('content');
}
function getCsrfHeader(){
	return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
}
	$(".recomNews").on("click",function(e){
		e.preventDefault;
		fetch(cPath+"/quick/news?newsId="+$(this).data("newsId"),{
			method:"POST",
			headers:{
				"Accept":"application/json",
				"Content-Type":clickForm.enctype,
				[getCsrfHeader()]: getCsrfToken()
			}
		}).then(resp=>{
			if(resp.ok){
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