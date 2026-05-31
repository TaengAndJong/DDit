<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form"  prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags"  prefix="spring"%>
<%-- 추천모달버튼 --%>
<div class ="d-flex justify-content-end">
	<button type="button" class="btn btn-primary mb-3 " id="certRecomBtn"data-bs-toggle="modal" data-bs-target="#certRecomModal">
	   자격증추천
	</button>
</div>

<%-- 추천모달버튼 --%>

<%-- 자격증추천 모달 --%>
<div class="modal fade flexibleModal certRecomModal" id="certRecomModal" tabindex="-1" aria-labelledby="certRecomModal" aria-hidden="true">

	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header bg-primary">
				<strong class="modal-title text-white" id="certRecomModal">자격증추천</strong>
			</div>
			<div class="modal-body" id="modalRecom">
				<div class="rowlist  common_list recomList scrollY" id="resultcertRecom">
				<!-- modal bottom -->
					<c:forEach items="${recomList}" var="cert">
						<div class=" col row  view" data-cert-id="${cert.certId}">
								<div class="photo_img">
									<div class="img-in">
										<img src="${pageContext.request.contextPath}${cert.certImgUrl}" class="card-img-top" alt="">
									</div>
								</div>
						
								<div class="card-body">
									<ul class="ul">
										<li>
											<strong class="list-tit">자격증 명 :</strong> 
											<span id="bookTitle">${cert.certName }</span>
										</li>
									
										<li>
											<strong class="list-tit">자격 구분 :</strong> 
											<span>${cert.certRange }</span>
										</li>
										<li class="desc"><strong class="list-tit">자격증설명 :</strong>
											<p>${cert.certInfo } </p>
										</li>
									
									</ul>
								</div>
						</div>
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
<%-- 자격증추천 모달 --%>
<!-- ui :  s -->
<div class="row row-cols-1 row-cols-md-4 g-4 common_list recomList mb-4" id="CertRecomList">
<c:forEach items="${certList }" var="cert">
<a href="${cert.certUrl }">
	<!-- col -->
			<div class="col">
				<div class="card">
					<div class="photo_img">
						<div class="img-in">
							<img src="<c:url value='${cert.certImgUrl}'/>" class="card-img-top" alt="${cert.certName }${cert.certRange }">
						</div>
					</div>
					<div class="card-body">
						<strong class="card-title"> <em class="text-elipsis">${cert.certName }</em>
						</strong> <span class="d-flex"><i class="icon writer"><em class="sr-only">자격구분</em></i>
							${cert.certRange } </span>
						<button class="kinBtn border-0"></button>
					</div>
				</div>
			</div> <!-- col -->
	</a>
</c:forEach>
</div>
<!-- 스크립트 넣기  -->
<!-- 스크립트 넣기  -->
<!-- ui : 포토공간목록 e -->