<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
.topBox {
	justify-content: space-between;
	width: 100%
}
.formBox{padding:20px 0;justify-content: flex-end; width: 100%;}
</style>

<!-- ui 02 table-->
<div class="ui">

	<!-- 타이틀  -->
	<div class="topBox  mb-3 pb-2 border-bottom mt-1 flex">
		<strong class="title fs-5 text "> 수강신청 목록 조회</strong> <span
			class="loginUser">학번 : ${stdNo}</span>
	</div>
	<!-- 타이틀  -->


		<div class="inner html">
			<!-- 검색  -->
			<form id="searchForm"
				action="<c:url value='/student/enrollment.do'/>">
				<input type="hidden" name="stdNo" value='${stdNo}'>  
				<input type="hidden" name="page" /> <input type="hidden"
					name="searchType" value="${condition.searchType}" /> <input
					type="hidden" name="searchWord" value="${condition.searchWord}" />
			</form>

			<!-- 검색 -->	
			<table class="table table table-bordered">

				<colgroup>
					<col style="width: 15%;">
					<col style="width: 10%;">
					<col style="width: auto;">
					<col style="width: 10%;">
				</colgroup>
				<thead>
					<tr class="table-primary text-center">
						<th>강의코드</th>
						<th>강의구분</th>
						<th>강의명</th>
						<th>학점</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty subjcetList}">
							<c:forEach items="${subjcetList}" var="subject">
								<tr class="text-center">
									<td class="subCd">${subject.subCd}</td>
									<td class="subGubun">${subject.subGubun}</td>
									<td class="text-start"><a href="javascript:;" data-val="${subject.subCd}" onclick="enrollSubject('<%=request.getParameter("stdNo")%>', '${subject.subCd}', 0,this)">${subject.subName}</a></td>
									<td class="subCredit">${subject.subCredit}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="4">조건에 맞는 과목이 없음.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</div>

${pagingHTML}
<form id="insertForm">
<input type="hidden" name="subCd" value="<%=request.getParameter("stdNo")%>">
</form>

<form id="subjectForm" action='<c:url value="/student/enrollment.do"/>'>
	<input type="hidden" name="subCd">
</form>
<script>
const cPath = document.body.dataset.contextPath;
function enrollSubject(stdNo,subCd,clsScore,ts){
	console.log(stdNo)
	console.log(subCd)
	console.log(clsScore)
	let rowdata={
		stdNo:stdNo,
		subCd:subCd,
		clsScore:clsScore
	}
	let body=JSON.stringify(rowdata);
	fetch(cPath+"/student/enrollment.do",{
		method:"post",
		headers:{
			"Accept":"application/json",
			"Content-Type":"application/json"
		},body:body
	}).then(resp=>{
		if(resp.ok){
			return resp.json();
		}else{
			throw new Error(`상태코드 ${resp.status} 수신`,{cause:resp})
		}
	}).then(jsonObj=>{
		console.log(ts)
		ts.innerHTML+=" "+jsonObj.success;
	}).catch(err=>{
		console.error(err);
	})
}
</script>
<script src='<c:url value="/resorces/js/app/common/paging.js"/>'></script>
