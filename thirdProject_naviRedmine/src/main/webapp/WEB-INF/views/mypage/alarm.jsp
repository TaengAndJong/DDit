<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<form id="searchForm">
	<input type="hidden" name="page" />
</form>

<!--  alram -->
<div class="alramBoard board" id="alram">
	<div class="row mb-3">
		<div class="col-md-6 text-start">
			<button class="btn btn-primary btn-sm" id="readAllBtn">전체읽음</button>
			<button class="btn btn-danger btn-sm">전체삭제</button>
		</div>
		<!-- 알림설정버튼 -->
		<!-- 알림설정버튼 -->
	</div>
	<table class="table text-center">
		<caption class="sr-only">게시판별 알림설정 테이블입니다.</caption>
		<colgroup>
			<col style="width: 5%">
			<col style="width: 10%">
			<col style="width: 15%">
			<col style="width: 35%">
			<col style="width: 10%">
			<col style="width: 10%">
			<col style="width: 15%">
		</colgroup>
		<thead>
			<th><input type="checkbox"></th>
			<th>번호</th>
			<th>알림타입ID</th>
			<th>내용</th>
			<th>읽음확인</th>
			<th>발생일</th>
			<th>삭제</th>
		</thead>
		<tbody>
		<c:if test="${not empty alarmList }">
		<c:forEach items="${alarmList }" var="al">
			<tr>
				<td><input type="checkbox"></td>
				<td><span>${al.alarmId }</span></td>
				<td><span>${al.altypeName }</span></td>
				<td class="text-start"><a href="${pageContext.request.contextPath }${al.alMoveUrl}" class="text-link"><em
						class="text-elipsis">
						<c:if test="${not empty al.alCn }">
							${al.alCn }
						</c:if>
						<c:if test="${empty al.alCn }">
							${al.altypeCn }
						</c:if>
						</em></a></td>
				<td><span>${al.alRdYn }</span></td>
				<td><span>${al.alRegDtStr}</span></td>
				<td><button type="button" class="btn btn-danger btn-sm"
						data-bs-toggle="modal" data-bs-target="#deletemodal">삭제</button></td>
			</tr>
		</c:forEach>
		</c:if>
		<c:if test="${empty alarmList }">
			<tr>
				<td colspan="7" class="text-center">데이터가 없습니다.</td>
			</tr>
		</c:if>
		</tbody>
		
	</table>
	${pagingHTML }
</div>
<!--alram -->

<script>
$(document).ready(function(){
	 const cPath = document.body.dataset.contextPath;
	   function getCsrfToken(){
	      return document.querySelector('meta[name="_csrf"]').getAttribute('content');
	   }
	   function getCsrfHeader(){
	      return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
	   }
	   
	$("#readAllBtn").on("click",function(){
		fetch(cPath+"/mypage/alarm",{
			method:"POST",
			headers:{
				"Accept":"application/json",
				 [getCsrfHeader()]: getCsrfToken()
			}
		}).then(resp=>{
			if(resp.ok){
				return resp.json();
			}else{
				throw new Error(`상태코드 ${resp.status} 수신`,{cause:resp})
			}
		}).then(jsonObj=>{
			alert(jsonObj.cnt+"개의 알림이 읽음처리 되었습니다.")
			location.reload();
		}).catch(err=>{
			console.error(err);
		})
	})
	
})

</script>

<script src="<c:url value='/resources/js/common/paging.js'/>"></script>
