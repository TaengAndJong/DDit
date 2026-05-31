<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

  <style>

    .modal-body{width:100%}
    .modal-body [class*=tit]{min-width: 13%;}
    .modal-body:after{content:''; display:block; clear:both;}
    
    
    .modal-body{padding-left:0}
    .modal-body li{margin-right:20px; width:calc(50% - 20px);float:left}
    .modal-body li:nth-child(2n-1){margin-right:20px;}

    .modal-footer{justify-content:center}
    .modal-footer .btn{margin: 5px 3px}
    
        

    
  </style>

  <div class="topBox  mb-3 pb-2 border-bottom mt-1">
    <strong class="title fs-5 text ">학생정보수정</strong>
  </div>

 <div class="modifyContent border-bottom">
  <form id="updateForm"  class="p-3" method="post" action="${pageContext.request.contextPath}/student/studentList.do"
    enctype="application/x-www-form-urlencoded">
    <ul class="modal-body customUl">
      <!-- 1 -->
     <li class="flex">
      	<label for="stdName" class="tit fs-6">이름</label>
      	<span>${info.stdName}</span>
       </li> 
      <!-- 1 -->
      <!-- 1 -->
     <li class="flex">
     	 	<label for="stdNo" class="tit fs-6">학번</label>
     	 	<span>${info.stdNo}</span>
      </li>
      <!-- 1 -->
      <li class="flex">
	      	<label for="stdTelno" class="tit fs-6">전화번호</label> 
	      	<input type="text" id="stdTelno" class="form-control"  name="stdTelno" value="${info.stdTelno}" />
	   </li>
      <!-- 1 -->
       <li class="flex">
	      <label for="stdAddress" class="tit fs-6">주소</label> 
	      <input type="text" id="stdAddress" class="form-control" name="stdAddress" value="${info.stdAddress}" />
	   </li>
	   <!-- 1 -->
    </div>

    <div class="modal-footer mt-3">
      <button type="button" class="btn btn-secondary" id="cancelBtn">취소</button>
      <button type="submit" class="btn btn-primary">저장</button>
    </div>
    <!-- 1 -->
  </form>
</div>
<script type="text/javascript">


	let cPath = document.body.dataset;
	let cancelBtn = document.querySelector("#cancelBtn");
	
	cancelBtn.addEventListener("click", function() {
		console.log(cPath,cancelBtn)
		location.href='studentList.do';
	});


</script>

