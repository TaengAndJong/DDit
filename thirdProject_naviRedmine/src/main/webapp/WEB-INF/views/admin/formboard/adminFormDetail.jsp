<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<form:form
	action="${pageContext.request.contextPath }/admin/form/del/${bf.bpId }"
	id="deleteForm">
	<div class="modal fade info" id="deleteModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<strong class="modal-title fs-5" id="deleteModalLabel">안내</strong>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body" id="deleteResult">"서식글을 삭제하시겠습니까?"</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-danger" id="deleteBtn">삭제</button>
				</div>
			</div>
		</div>
	</div>
</form:form>



<div class="header-title select">
	<h2>
		<strong class="title-name">서식게시판 관리</strong>
	</h2>
</div>

<div class="side_inner">
	<div class="content-box ">

		<!-- project veiw -->
		<div class="view task">
			<div class="view_inner">
				<div class="view-info">
					<strong class="view-tit"> <em> ${bf.bpTitle } </em></strong>
					<ul class="ul clearfix">

						<li><span class="list-tit">작성자</span> <span>${bf.empName }</span>
						</li>
						<li><span class="list-tit">수정일자</span> 
						<span> 
						<c:if test="${empty bf.bpModId}"> 수정내역 없음
						</c:if> 
						<c:if test="${not empty bf.bpModId}">
						${bf.bpModDtStr }
						</c:if>
						</span></li>
						<li><span class="list-tit">작성일자</span> <span>${bf.bpRegDtStr }</span>
						</li>
						<li><span class="list-tit">수정자</span> <span> <c:if
									test="${empty bf.bpModId}">
								수정내역 없음
								</c:if> <c:if test="${not empty bf.bpModId}">
								ADMIN
								</c:if>
						</span></li>
						<li><span class="list-tit">조회수</span> <span>${bf.bpCnt }</span>
						</li>

					</ul>
				</div>
				<div class="view_content form_content">${bf.bpCn}</div>
			</div>
			<!-- project veiw -->
			<!-- 첨부파일 -->
			<div class="content form_content">
				<div class="inner html">
					<strong class="d-flex align-items-center mb-3"> <i
							class=""></i>첨부파일
						</strong>
						<c:if test="${empty bpfv}">
							<em class="file_name">첨부된 파일이 없습니다.</em>
						</c:if>
						<c:forEach items="${bpfv }" var="f">
							<div class="addfile">
								<ul class="fileList">
									<li	class="d-flex file-row align-items-center justify-content-between mb-2">
										<a href="${pageContext.request.contextPath}/admin/form/download/${f.bpFileId}" class="file_item d-flex align-items-center">
											<c:choose>
											    <c:when test="${empty f.bpFileId}">
											        <em class="file_name">첨부된 파일이 없습니다.</em>
											    </c:when>
											    <c:otherwise>
											        <c:if test="${f.bpFileGbId eq 'pdf' }">
											            <i class="icon pdf"><em class="sr-only">${f.bpFileGbId }</em></i>
											        </c:if>
											        <c:if test="${f.bpFileGbId eq 'txt' }">
											            <i class="icon txt"><em class="sr-only">${f.bpFileGbId }</em></i>
											        </c:if>
											        <c:if test="${f.bpFileGbId eq 'jpg'}">
											            <i class="icon txt"><em class="sr-only">${f.bpFileGbId }</em></i>
											        </c:if>
											         <c:if test="${f.bpFileGbId eq 'png' }">
											            <i class="icon txt"><em class="sr-only">${f.bpFileGbId }</em></i>
											        </c:if>
											        <c:if test="${f.bpFileGbId eq 'word' }">
											            <i class="icon word"><em class="sr-only">${f.bpFileGbId }</em></i>
											        </c:if>
											        <c:if test="${f.bpFileGbId eq 'xlsx' }">
											            <i class="icon xlsx"><em class="sr-only">${f.bpFileGbId }</em></i>
											        </c:if>
											        <c:if test="${f.bpFileGbId eq 'zip' }">
											            <i class="icon zip"><em class="sr-only">${f.bpFileGbId }</em></i>
											        </c:if>
											        <c:if test="${f.bpFileGbId eq 'hwp' }">
											            <i class="icon hangle"><em class="sr-only">${f.bpFileGbId }</em></i>
											        </c:if>
											        <c:if test="${f.bpFileGbId eq 'ppt' }">
											            <i class="icon ppt"><em class="sr-only">${f.bpFileGbId }</em></i>
											        </c:if>
											        <c:if test="${f.bpFileGbId eq 'pptx' }">
											            <i class="icon ppt"><em class="sr-only">${f.bpFileGbId }</em></i>
											        </c:if>
											    </c:otherwise>
											</c:choose>
											<span class=""> <em class="file_name">${f.bpOrgNm }</em></span>
											
									</a><span class="file_size p-1 border border-dark-subtle fileSize">${f.bpFileSize }</span>
									</li>
								</ul>
							</div>
						</c:forEach>
				</div>
			</div>
		</div>
		<!-- 첨부파일 -->
		<!-- button -->
	</div>
		<div class="btn-box clearfix mt-4 formmod_footbtn">
			<a href="${pageContext.request.contextPath }/admin/form"><button
					class="btn btn-secondary">목록</button></a>
			<div class="right float-end">
				<button class="btn btn-danger" data-bs-toggle="modal"
					data-bs-target="#deleteModal">삭제</button>
				<a
					href="${pageContext.request.contextPath }/admin/form/mod/${bf.bpId}">
					<button class="btn btn-primary">수정</button>
				</a>
			</div>
		</div>
</div>
<script>
$(document).ready(function(){
	let editor;
	function getCsrfToken(){
		return document.querySelector('meta[name="_csrf"]').getAttribute('content');
	}
	function getCsrfHeader(){
		return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
	}


$(deleteBtn).on("click",function(e){
	console.log(e.target)	
	
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
        if (jsonObj.msg == 'ok') {
            deleteResult.innerHTML = "삭제가 완료되었습니다.";
        } else {
            deleteResult.innerHTML = "삭제에 실패했습니다.";
        }
		setTimeout(() => {
		    window.location.href = "http://localhost/navi/admin/form";
		}, 1000);
	})
})
})
</script>