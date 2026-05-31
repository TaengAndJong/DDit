<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div class="modal fade info" id="deleteModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<strong class="modal-title fs-5" id="exampleModalLabel">안내</strong>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body" id="deleteResult">"파일글을 삭제하시겠습니까?"</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">닫기</button>
				<form id="deleteForm" action="${pageContext.request.contextPath}/project/filesave/${fs.fsnId }">
					<input type="submit" class="btn btn-primary" value="삭제">
				</form>
			</div>
		</div>
	</div>
</div>

<!-- project veiw -->
<div class="view task">
	<div class="view_inner">
		<div class="view-info">
			<strong class="view-tit"> <span class="category project">${fs.fsnId }</span>
				<em>${fs.fsnTitle}</em></strong>
			<ul class="ul clearfix">

				<li><span class="list-tit">담당자</span> <span>${fs.empName }(${fs.deptName },
						${fs.psName })</span> <!-- <select class="select-box" aria-label="Default select example">
                                    <option selected>우민규(디자인1팀, 사원)</option>
                                    <option value="1">유길상(디자인1팀, 사원)</option>
                                    <option value="2">정민지(디자인1팀, 사원)</option>
                                    <option value="4">이상철(디자인1팀, 사원)</option>
                                    <option value="5">김태은(디자인1팀, 사원)</option>
                                </select> --></li>
				<!-- <li><span class="list-tit">진행기간</span><span>2024.04.05</span></li> -->
				<li><span class="list-tit">등록일</span> <span>${fs.fsnRegDtStr }</span></li>
				<li><span class="list-tit">수정일</span> <span> <c:if
							test="${empty fs.fsnModDtStr }">수정내역 없음</c:if> <c:if
							test="${not empty fs.fsnModDtStr }">${fs.fsnModDtStr }</c:if>
				</span></li>
				<!-- 프로젝트 상태값:
                                        <li><span class="">상태</span><span>신규</span></li>
                                        <li><span class="">상태</span><span>안정</span></li>
                                        <li><span class="">상태</span><span>긴급</span></li>
                                -->

			</ul>
		</div>
		<div class="view_content">${fs.fsnCn }</div>
		<div class="content">
		<div class="inner html">
		<strong class="d-flex align-items-cente mb-3"> <i
							class=""></i>첨부파일
						</strong>
						<c:if test="${empty fileList}">
							<em class="file_name">첨부된 파일이 없습니다.</em>
						</c:if>
			<c:forEach items="${fileList }" var="f">
				<div class="addfile">
					<ul class="fileList">
						<li
							class="d-flex file-row align-items-center justify-content-between mb-2">
							<a href="${pageContext.request.contextPath }/project/filesave/download/${f.fsfId}" class="file_item d-flex align-items-center"> <i
								class="icon close"><em class="sr-only">첨부파일삭제</em></i> <c:choose>
									<c:when test="${empty f.fsfGbId}">
										<em class="file_name">첨부된 파일이 없습니다.</em>
									</c:when>
									<c:otherwise>
										<c:if test="${f.fsfGbId eq 'pdf' }">
											<i class="icon pdf"><em class="sr-only">${f.fsfGbId }</em></i>
										</c:if>
										<c:if test="${f.fsfGbId eq 'txt' }">
											<i class="icon txt"><em class="sr-only">${f.fsfGbId }</em></i>
										</c:if>
										<c:if test="${f.fsfGbId eq 'jpg'}">
											<i class="icon txt"><em class="sr-only">${f.fsfGbId }</em></i>
										</c:if>
										<c:if test="${f.fsfGbId eq 'png' }">
											<i class="icon txt"><em class="sr-only">${f.fsfGbId }</em></i>
										</c:if>
										<c:if test="${f.fsfGbId eq 'word' }">
											<i class="icon word"><em class="sr-only">${f.fsfGbId }</em></i>
										</c:if>
										<c:if test="${f.fsfGbId eq 'xlsx' }">
											<i class="icon xlsx"><em class="sr-only">${f.fsfGbId }</em></i>
										</c:if>
										<c:if test="${f.fsfGbId eq 'zip' }">
											<i class="icon zip"><em class="sr-only">${f.fsfGbId }</em></i>
										</c:if>
										<c:if test="${f.fsfGbId eq 'hwp' }">
											<i class="icon hangle"><em class="sr-only">${f.fsfGbId }</em></i>
										</c:if>
										<c:if test="${f.fsfGbId eq 'ppt' }">
											<i class="icon ppt"><em class="sr-only">${f.fsfGbId }</em></i>
										</c:if>
										<c:if test="${f.fsfGbId eq 'pptx' }">
											<i class="icon ppt"><em class="sr-only">${f.fsfGbId }</em></i>
										</c:if>
									</c:otherwise>
								</c:choose> <span class=""> <em class="file_name">${f.fsfOrgNm }</em></span>
						</a> <span class="file_size p-1 border border-dark-subtle fileSize">${f.fsFileSize }</span>
						</li>
					</ul>

				</div>
			</c:forEach>
		</div>
	</div>
	</div>

</div>
<!-- project veiw -->
<!-- button -->
<div class="btn-box clearfix mt-4">
	<a href="${pageContext.request.contextPath}/project/filesave/${project.proId}"class="btn btn-secondary">목록</a>
	<div class="right float-end">
	<button class="btn btn-danger" data-bs-toggle="modal"
			data-bs-target="#deleteModal">삭제</button>
		<a
			href="${pageContext.request.contextPath}/project/filesave/modify/${project.proId }/${fs.fsnId}"><button
				class="btn btn-primary">수정</button></a>
	</div>
</div>
<!-- button -->
<script>
$(document).ready(function(){
	function getCsrfToken(){
		return document.querySelector('meta[name="_csrf"]').getAttribute('content');
	}
	function getCsrfHeader(){
		return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
	}
	$("#deleteForm").on("submit",function(e){
		e.preventDefault();
		console.log(deleteForm)
		fetch(deleteForm.action,{
			method:"DELETE",
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
			console.log(jsonObj)
			if(jsonObj.msg='ok'){
				deleteResult.innerHTML='파일글 삭제에 성공했습니다.'
				window.location.pathname='${pageContext.request.contextPath}/project/filesave/${project.proId}'
			}else{
				deleteResult.innerHTML='파일글 삭제에 실패했습니다.'
			}
		}).catch(err=>{
			console.error(err);
		});
	});
})
</script>
