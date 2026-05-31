<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
   
  .modal-body{max-width:400px;width:100%}
  .modal-footer{justify-content:center}
  .modal-footer .btn{margin: 5px 3px}
</style>
  <div class="topBox  mb-3 pb-2 border-bottom mt-1">
    <strong class="title fs-5 text ">학생정보 목록</strong>
  </div>

<ul class="ul customUl pl-6 pb-3 border-bottom">
  <li><span class="tit">이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름 :</span>${info.stdName}</li>
  <li><span class="tit">학&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;번 :</span>${info.stdNo}</li>
  <li><span class="tit">전화번호 :</span>${info.stdTelno}</li>
  <li><span class="tit">주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소 :</span>${info.stdAddress}</li>
  <li><span class="tit">담당교수 :</span>${info.proName}</li>
  <%-- <li><span class="tit">주민번호 :</span>${info.stdId}</li>--%>
</ul>
<div class="btnBox text-end">
  <button type="button" id="listBtn" class="btn btn-primary">수강신청</button>
  <a href="<c:url value='/student/studentEdit.do' />" id="modifyBtn" class="btn btn-primary">수정</a>
</div>
<form action='<c:url value="/student/enrollment.do"/>' id="listForm">
  <input type="hidden" name="stdNo" value="${info.stdNo}">
</form>
  <script>

    listBtn.addEventListener("click",function(){
    	$(listForm).submit();
    })
  </script>