<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script type="text/javascript"
	src='/navi/resources/js/common/ckeditor5/super/ckeditor.js'></script>
<script type="text/javascript"
	src="/navi/resources/js/common/datepicker/jquery-ui.js"></script>
<script type="text/javascript"
	src="/navi/resources/js/common/datepicker/lang/datepicker-ko.js"></script>
<style>
.myprofil{
    width: 37px;
    height: 37px;
    background-size: cover;
    border-radius: 70%;
}
</style>
<form id="deleteForm"
	action="${pageContext.request.contextPath }/board/photo/del/${photo.bpId }">
	<div class="modal fade info" id="deleteModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<strong class="modal-title fs-5" id="deleteModalLabel">안내</strong>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body" id="deleteResult">"게시글을 삭제하시겠습니까?"</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-danger" id="deleteBtn">삭제</button>
				</div>
			</div>
		</div>
	</div>
</form>
<!-- ui : 포토공간목록 s -->

<!-- project veiw -->
<div class="view">
	<div class="view_inner">
		<div class="view-info">
			<strong class="view-tit icon-tit"><span class="icon photo"></span>
				<em>${photo.bpTitle}</em></strong>  
			<ul class="ul clearfix">

				<li><span class="list-tit">작성자</span><span>
				${photo.empName }
				</span></li>
				<li><span class="list-tit">등록일</span>
				<span>
					${photo.bpRegDtStr }
				
				</span></li>

			</ul>
		</div>
		<div class="view_content">
			${photo.bpCn }
			
		</div>
			<div class="content file">
					<div class="inner html">
						<strong class="d-flex align-items-cente mb-3"> <i
							class=""></i>첨부파일
						</strong>
						<c:if test="${empty bpfv}">
							<em class="file_name">첨부된 파일이 없습니다.</em>
						</c:if>
						<c:forEach items="${bpfv }" var="f">
							<div class="addfile">
								<ul class="fileList">
									<li
										class="d-flex file-row align-items-center justify-content-between mb-2">
										<a href="${pageContext.request.contextPath}/board/photo/download/${f.bpFileId}" class="file_item d-flex align-items-center">
											<c:choose>
											    <c:when test="${empty f.bpFileGbId}">
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
	<!-- commentForm -->
	<form class="comment mb-5" id="commentForm">
		<legend class="comment-tit">댓글쓰기</legend>
		<div class="card bg-light">
			<div class="card-body comment-body">
				<!-- comment list -->
				<div class="comment-list">
					<c:forEach items="${commentList }" var="cm">
						<ul class="ul depth1 clearfix">
							<li class="li"><c:if test="${not empty cm.bcTopId}">
									<div class="depth-row" style="margin-left: 50px; border-bottom: 1px solid #e5e5e5;">
										<div class="comment-content" style="background-color: #ededed; border-radius: 5px;">
											<div class="imgbox">
												<div class="img-in no-img">
													<c:if test="${empty cm.emp.base64Img}">
														<img class="myprofil ml-2" src="${pageContext.request.contextPath}/resources/images/prog/navi.jpg" 
														style="width:80%; height:auto;"  alt="작성자프로필이미지">
														</c:if>
														<c:if test="${not empty  cm.emp.base64Img}">
															<img class="myprofil" src="data:image/*;base64,${cm.emp.base64Img }"
															 style="width:80%; height:auto;"  alt="작성자프로필이미지">
														</c:if>
												</div>
											</div>

											<c:if test="${cm.bcDelYn == 'Y'}">
												<div class="writebox">삭제된 글입니다.</div>
											</c:if>
											<c:if test="${cm.bcDelYn == 'N'}">
												<div class="writebox">
													<span>${cm.bcCn }</span>
												</div>
											</c:if>
										</div>
										<div class="comment-info d-flex justify-content-between">
											<div class="left  d-flex ">
												<span class="comment-writer"> <i class="icon writer"></i>
													<em>${cm.empName }(${cm.deptName })</em></span> <span
													class="comment-date  ms-4"> <i class="icon date"></i>${cm.bcRegDtStr }
												</span>
											</div>
											<button type="button"
												class="btn btn-light ms-1 delete-comment"
												data-bs-toggle="modal" data-bs-target="#exampleModal"
												data-id="${cm.bcId }">삭제</button>
										</div>

									</div>
								</c:if> <c:if test="${empty cm.bcTopId}">
									<div class="depth-row" style="border-bottom: 1px solid #e5e5e5;">
										<div class="comment-content" style="background-color: #E3E4FA; border-radius: 5px;">
											<div class="imgbox">
												<div class="img-in no-img">
													<c:if test="${empty cm.emp.base64Img}">
														<img class="myprofil ml-2" src="${pageContext.request.contextPath}/resources/images/prog/navi.jpg" 
														style="width:80%; height:auto;"  alt="작성자프로필이미지">
														</c:if>
														<c:if test="${not empty  cm.emp.base64Img}">
															<img class="myprofil" src="data:image/*;base64,${cm.emp.base64Img }"
															 style="width:80%; height:auto;"  alt="작성자프로필이미지">
														</c:if>
												</div>
											</div>

											<c:if test="${cm.bcDelYn == 'Y'}">
												<div class="writebox">삭제된 글입니다.</div>
											</c:if>
											<c:if test="${cm.bcDelYn == 'N'}">
												<div class="writebox">
													<span>${cm.bcCn }</span>
												</div>
											</c:if>

										</div>
										<div class="comment-info d-flex justify-content-between">
											<div class="left  d-flex ">
												<span class="comment-writer"> <i class="icon writer"></i>
													<em>${cm.empName }(${cm.deptName })</em>
												</span> 
												<span class="comment-date  ms-4"> <i class="icon date"></i>${cm.bcRegDtStr }
												</span>
												<button type="button" class="btn btn-light ms-1 top-comment"
													data-bs-toggle="modal" data-bs-target="#bcInsertModal"
													data-id="${cm.bcId }" data-name="${cm.empName}"
													data-dept="${cm.deptName }">답글쓰기</button>
											</div>

											<button type="button" class="btn btn-light ms-1 delete-comment" data-bs-toggle="modal" data-bs-target="#exampleModal" data-id="${cm.bcId }">삭제</button>
										</div>
									</div>
								</c:if></li>
						</ul>
					</c:forEach>
				</div>
				<!-- comment list -->
				<!-- comment-input -->
				<span id="bctopid"></span>
				<div class="d-flex mb-4 comment-input">
					<label for="textarea"><span class="sr-only">댓글입력창</span></label>
					<textarea class="form-control" rows="5" placeholder="댓글을 입력해주세요"
						id="bcCn" name="boardCn"></textarea>
					<input class="btn btn-secondary register commentRegBtn"
						type="button" value="등록">
				</div>
				<!-- comment-input -->

			</div>
		</div>
	</form>
</div>
	<!-- commentForm -->
	<!-- Modal -->
		<div class="modal info fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<strong class="modal-title fs-5" id="exampleModalLabel">안내</strong>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body" id="commentDelModal">"댓글을 삭제하시겠습니까?"</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">닫기</button>
						<button type="button" class="btn btn-primary" id="delcomment">확인</button>
					</div>
				</div>
			</div>
		</div>
		<!-- modal -->
		
				<!-- Modal -->
		<div class="modal info fade" id="bcInsertModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<strong class="modal-title fs-5" id="nameLabel"></strong>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<span id="bctopid"></span>
					<div class="d-flex mb-8 comment-input">
						<label for="textarea"><span class="sr-only">댓글입력창</span></label>
						<textarea class="form-control" rows="5" placeholder="댓글을 입력해주세요" id="bcCn" name="boardCn"></textarea>
						<input class="btn btn-secondary register commentRegBtn1" type="button" value="등록" >
					</div>
				</div>
			</div>
		</div>
		<!-- modal -->
	<!-- commentForm -->

<!-- button -->
<div class="btn-box clearfix mt-4">
	<a href="${pageContext.request.contextPath }/board/photo"><button class="btn btn-secondary">목록</button></a>
	<div class="right float-end">
		<button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal">삭제</button>
		<a href="${pageContext.request.contextPath }/board/photo/mod/${photo.bpId}"><button class="btn btn-primary">수정</button></a>
	</div>
</div>
<!-- button -->

<script type="text/javascript">
$(document).ready(function(){
	const cPath = document.body.dataset.contextPath;
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
		if(jsonObj.msg=="ok"){
		$(deleteResult).text("삭제가 완료되었습니다.");
		window.location.href="${pageContext.request.contextPath}/board/photo"
	}else{
		$(deleteResult).text("삭제에 실패했습니다.");
		window.location.reload();
	}
	}).catch(err=>{
		console.error(err);
	})
})

$(".top-comment").on("click", function(e) {
    let btn = $(e.target);
    let bcId = btn.data("id");
    let empName = btn.data("name"); // 클릭한 댓글의 사원명 데이터를 가져옴
    let deptName = btn. data("dept");
    let bcTopIdInput = $("#bctopid");
    bcTopIdInput.val(bcId);
    $("#nameLabel").text(empName +"(" + deptName +")"+"님에게 답글 쓰기"); // 모달 창 제목에 사원명 표시
});

$(".commentRegBtn1").on("click",function(e){
  	let bpId = '${photo.bpId}';
    e.preventDefault();
    let BoardBcCn = $(this.previousElementSibling).val();
    let bcTopId = $("#bctopid").val();
    let data = {
        "bpId": bpId,
        "bcCn": BoardBcCn,
        "bcTopId": bcTopId
    };
	let body=JSON.stringify(data);
	fetch(cPath+"/board/photo/comment/reg",{
		method:"POST",
		headers:{
			"Accept":"application/json",
			"Content-Type":"application/json",
			[getCsrfHeader()]: getCsrfToken()
		},body:body
	}).then(resp=>{
		if(resp.ok){
			return resp.json();
		}else{
			throw new Error(`상태코드 ${resp.status} 수신`,{cause:resp})
		}
	}).then(jsonObj=>{
		console.log(jsonObj)
		if(jsonObj.msg='ok'){
			 window.location.reload();
		}else{
//				 window.location.reload();
		}
	}).catch(err=>{
		console.error(err);
	})
})
$(".commentRegBtn").on("click",function(e){
  	let bpId = '${photo.bpId}';
    e.preventDefault();
    let BoardBcCn = $(this.previousElementSibling).val();
    let data = {
        "bpId": bpId,
        "bcCn": BoardBcCn,
    };
	let body=JSON.stringify(data);
	fetch(cPath+"/board/photo/comment/reg",{
		method:"POST",
		headers:{
			"Accept":"application/json",
			"Content-Type":"application/json",
			[getCsrfHeader()]: getCsrfToken()
		},body:body
	}).then(resp=>{
		if(resp.ok){
			return resp.json();
		}else{
			throw new Error(`상태코드 ${resp.status} 수신`,{cause:resp})
		}
	}).then(jsonObj=>{
		console.log(jsonObj)
		if(jsonObj.msg='ok'){
			 window.location.reload();
		}else{
//				 window.location.reload();
		}
	}).catch(err=>{
		console.error(err);
	})
})

$(".delete-comment").on("click",function(e){
	
	console.log(e.target);
	let bcId = $(e.target).data("id");
	console.log(bcId);
	
	console.log($("#delcomment")[0]);
	$("#delcomment").on("click",function(e){
		
		fetch(cPath+"/board/photo/delcomment?bcId="+bcId,{
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
				commentDelModal.innerHTML='댓글 삭제에 성공했습니다.'
				
			}else{
				commentDelModal.innerHTML='댓굴 삭제에 실패했습니다.'
			}
			
			   setTimeout(() => {
		            window.location.reload();
		        }, 1000);
			
			
		}).catch(err=>{
			console.error(err);
		})
	})
	
	
})

})
</script>

