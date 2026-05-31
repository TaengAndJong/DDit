<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<link rel="stylesheet" href='<c:url value="/resources/css/quick/vacList.css"/>'>
<%-- 추천 모달버튼 s--%>
<div class="d-flex justify-content-end">
   <button type="button" class="btn btn-primary mb-3 " id="vacRecomBtn"
      data-bs-toggle="modal" data-bs-target="#recomModal">여행지추천</button>
</div>
<%-- 추천 모달버튼 e--%>
<%-- 추천 모달 s--%>
<div class="modal fade recomModal modal-center" id="recomModal"
   tabindex="-1" aria-labelledby="recomModal" aria-hidden="true">
   <div class="modal-dialog modal-center">
      <div class="modal-content">
         <div class="modal-header text-white bg-primary">
            <strong class="modal-title" id="recomModal">추천 Top3</strong>
         </div>
         <div class="modal-body">

            <!-- modal bottom -->
            <div class="rowlist  common_list recomList scrollY"
               id="resultVacRecom">
               <c:forEach items="${recomList }" var="vacrecom">
                  <!-- col -->
                  <div class="col row  view">
                     <div class="photo_img">
                        <div class="img-in">
                           <img src="${vacrecom.vacImg }" class="card-img-top"
                              alt="${vacrecom.vacName }">
                        </div>
                     </div>
                     <div class="card-body">
                        <ul class="ul">
                           <li><strong class="list-tit">여행지명</strong> <span>${vacrecom.vacName }</span>
                           </li>
                           <li><strong class="list-tit">순위</strong> <span>${vacrecom.vacRank }위</span>
                           </li>
                           <li class="desc"><strong class="list-tit">안내</strong>
                              <p class="desc_text">${vacrecom.vacEx }</p></li>
                        </ul>
                     </div>
                  </div>
                  <!-- col -->
               </c:forEach>
                 
            </div>
            <!-- modal bottom -->
             <div class="modal-footer justify-content-center">
                  		<button type="button" class="btn btn btn-secondary"
               			data-bs-dismiss="modal">닫기</button>
            </div>
         </div>
      </div>
   </div>
</div>
<%-- 추천 모달 e--%>


<%-- 휴양지 목록 s--%>
<form method="post" id="clickForm">
   <input type="hidden" name="vacId">
</form>

<!-- 휴양지 목록 -->
<div
   class="mt-4 row row-cols-2 row-cols-md-4 g-4 list  common_list recomList clearfix"
   id="vacRecomList">
   <c:forEach items="${vacList}" var="vac">
      <!--  col -->
      <button type="button" class="vacListBtn col" data-bs-toggle="modal"
         data-bs-target="#modal${vac.vacId }" data-vac-id="${vac.vacId}">
         <div class="">
            <div class="card">
               <div class="photo_img">
                  <div class="img-in">
                     <img src="${vac.vacImg}" class="card-img-top"
                        alt="${vac.vacName }의 이미지">
                  </div>
               </div>
               <div class="card-body">
                  <ul
                     class="card-footer d-flex justify-content-between border-0 py-0">
                     <li><span> <i class="icon tourplace_b"><em
                              class="sr-only">여행지</em></i> <em class="text-elipsis">${vac.vacName }</em>
                     </span></li>
                     <li><span> <i class="icon see_b"><em
                              class="sr-only">조회수</em></i> <em class="seenum">${vac.viewCnt}</em>
                     </span></li>
                  </ul>
               </div>
            </div>
         </div>
      </button>
      <!-- col-->

      <!-- 휴양지 목록 모달 -->
      <div class="modal fade recomModal modal-center" id="modal${vac.vacId}"
         tabindex="-1" aria-labelledby="vacModal${vac.vacId}"
         aria-hidden="true">
         <div class="modal-dialog modal-center">
            <div class="modal-content">
	            <div class="modal-header text-white bg-primary">
	           		<strong class="modal-title">${vac.vacName }</strong>
	         	</div>
               <div class="modal-body">
                  <!-- modal bottom -->
                  <div class="rowlist common_list h100">
                        <div class="col h100">
                           <div class="card h100">
                              <div class="img-in">
                                 <div class="card-img-top">
                                    <img src="${vac.vacImg }" class="card-img-top"
                                       alt="${vac.vacName }의 이미지">
                                 </div>
                              </div>
                              <div class="card-body">
                                 <ul class="card-footer d-flex justify-content-between border-0 py-0">
                                    <li>${vac.vacEx }</li>
                                 </ul>
                              </div>
                           </div>
                        </div>
                  </div>
                  <!-- modal bottom -->
               </div>
               <div class="modal-footer justify-content-center">
                  <button id="closeBtn" type="button" class="btn btn btn-secondary"
               			data-bs-dismiss="modal">닫기</button>
            </div>
            </div>
         </div>
         
      </div>
      <!-- 휴양지 목록 모달 -->

   </c:forEach>
</div>



<form id="searchForm">
   <input type="hidden" name="page" />
</form>
${pagingHTML }
<script src="<c:url value='/resources/js/common/paging.js'/>"></script>



<!-- 스크립트 넣기  -->
<script type="text/javascript">

const cPath = document.body.dataset.contextPath;
function getCsrfToken(){
   return document.querySelector('meta[name="_csrf"]').getAttribute('content');
}
function getCsrfHeader(){
   return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
}


$(".vacListBtn").each(function(i,v){
   console.log(v,i)
   $(v).on("click",function(e){
	   
	   console.log($(e.currentTarget).find(".seenum").html())
	   let numcnt=$(e.currentTarget).find(".seenum").html()
	   $(e.currentTarget).find(".seenum").html(parseInt(numcnt) + 1) // 조회수 증가
	   
      e.currentTarget;
      console.log(e.currentTarget)
      
      fetch(cPath+"/quick/vac?vacId="+$(e.currentTarget).data("vacId"),{
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
})

$(document).ready(function() {
    $('#modal${vac.vacId}').on('hidden.bs.modal', function() {
        window.location.reload(); // 모달이 닫힐 때 페이지 새로 고침
    });
});

</script>
<!-- 스크립트 넣기  -->