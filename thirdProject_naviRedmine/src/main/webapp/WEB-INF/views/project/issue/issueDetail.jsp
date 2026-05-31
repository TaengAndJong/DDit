<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<style>
.myprofil{
    width: 37px;
    height: 37px;
    background-size: cover;
    border-radius: 70%;
}
</style>
<div class="modal fade info" id="deleteModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<strong class="modal-title fs-5" id="exampleModalLabel">안내</strong>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body" id="deleteResult">"이슈를 삭제하시겠습니까?"</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">닫기</button>
				<form id="deleteForm" action="${pageContext.request.contextPath}/project/issue/${issue.issueId }">
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
			<strong class="view-tit"> <span class="category project">${issue.issueId }</span>
				<em>${issue.issueTitle}</em></strong>
			<ul class="ul clearfix">

				<li class="d-flex w-50  align-items-center mb-2"><span class="list-tit">담당자</span> <span>${issue.empName }(${issue.deptName },
						${issue.psName })</span> <!-- <select class="select-box" aria-label="Default select example">
                                    <option selected>우민규(디자인1팀, 사원)</option>
                                    <option value="1">유길상(디자인1팀, 사원)</option>
                                    <option value="2">정민지(디자인1팀, 사원)</option>
                                    <option value="4">이상철(디자인1팀, 사원)</option>
                                    <option value="5">김태은(디자인1팀, 사원)</option>
                                </select> --></li>
				<!-- <li><span class="list-tit">진행기간</span><span>2024.04.05</span></li> -->
				<li class="d-flex w-50  align-items-center mb-2"><span class="list-tit">등록일</span> <span>${issue.issueRegDtStr }</span></li>
				<li class="d-flex w-50  align-items-center mb-2"><span class="list-tit">중요도</span> <span>${issue.impName }</span></li>
				<li class="d-flex w-50  align-items-center mb-2"><span class="list-tit">상태</span> <span>${issue.stateName }</span></li>
				<li class="d-flex w-50  align-items-center mb-2"><span class="list-tit">수정일</span> <span> <c:if
							test="${empty issue.issueModDt }">수정내역 없음</c:if> <c:if
							test="${not empty issue.issueModDt }">${issue.issueModDt }</c:if>
				</span></li>
				<!-- 프로젝트 상태값:
                                        <li><span class="">상태</span><span>신규</span></li>
                                        <li><span class="">상태</span><span>안정</span></li>
                                        <li><span class="">상태</span><span>긴급</span></li>
                                -->

			</ul>
		</div>
		<div class="view_content">${issue.issueCn }</div>
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
							<a href="${pageContext.request.contextPath }/project/issue/download/${f.issffId}" class="file_item d-flex align-items-center"> 
							 <c:choose>
									<c:when test="${empty f.issfGbId}">
										<em class="file_name">첨부된 파일이 없습니다.</em>
									</c:when>
									<c:otherwise>
										<c:if test="${f.issfGbId eq 'pdf' }">
											<i class="icon pdf"><em class="sr-only">${f.issfGbId }</em></i>
										</c:if>
										<c:if test="${f.issfGbId eq 'txt' }">
											<i class="icon txt"><em class="sr-only">${f.issfGbId }</em></i>
										</c:if>
										<c:if test="${f.issfGbId eq 'jpg'}">
											<i class="icon txt"><em class="sr-only">${f.issfGbId }</em></i>
										</c:if>
										<c:if test="${f.issfGbId eq 'png' }">
											<i class="icon txt"><em class="sr-only">${f.issfGbId }</em></i>
										</c:if>
										<c:if test="${f.issfGbId eq 'word' }">
											<i class="icon word"><em class="sr-only">${f.issfGbId }</em></i>
										</c:if>
										<c:if test="${f.issfGbId eq 'xlsx' }">
											<i class="icon xlsx"><em class="sr-only">${f.issfGbId }</em></i>
										</c:if>
										<c:if test="${f.issfGbId eq 'zip' }">
											<i class="icon zip"><em class="sr-only">${f.issfGbId }</em></i>
										</c:if>
										<c:if test="${f.issfGbId eq 'hwp' }">
											<i class="icon hangle"><em class="sr-only">${f.issfGbId }</em></i>
										</c:if>
										<c:if test="${f.issfGbId eq 'ppt' }">
											<i class="icon ppt"><em class="sr-only">${f.issfGbId }</em></i>
										</c:if>
										<c:if test="${f.issfGbId eq 'pptx' }">
											<i class="icon ppt"><em class="sr-only">${f.bpFileGbId }</em></i>
										</c:if>
									</c:otherwise>
								</c:choose> <span class=""> <em class="file_name">${f.issfOrgNm }</em></span>
						</a> <span class="file_size p-1 border border-dark-subtle fileSize">${f.issfFileSize }</span>
						</li>
					</ul>

				</div>
			</c:forEach>
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
								<li class="li">
									<c:if test="${not empty cm.icTopId}">
										<div class="depth-row" style="margin-left:50px; border-bottom: 1px solid #e5e5e5;">
											<div class="comment-content" style=" background-color: #ededed; border-radius: 5px;">
												<div class="imgbox">
													<div class="img-in no-img">
<%-- <img src="${pageContext.request.contextPath}/${cm.empImg}" alt="작성자프로필이미지"> --%>

														<c:if test="${empty cm.emp.base64Img}">
														<img class="myprofil" src="${pageContext.request.contextPath}/resources/images/prog/navi.jpg" 
														style="width:80%; height:auto;"  alt="작성자프로필이미지">
														</c:if>
														<c:if test="${not empty  cm.emp.base64Img}">
															<img class="myprofil" src="data:image/*;base64,${cm.emp.base64Img }"
															 style="width:80%; height:auto;"  alt="작성자프로필이미지">
														</c:if>
													</div>
												</div>

												<c:if test="${cm.icDelYn == 'Y'}">
													<div class="writebox">삭제된 글입니다.</div>
												</c:if>
												<c:if test="${cm.icDelYn == 'N'}">
													<div class="writebox">
														<span>${cm.icCn }</span>
													</div>
												</c:if>
											</div>
											<div class="comment-info d-flex justify-content-between">
												<div class="left  d-flex ">
													<span class="comment-writer"> <i class="icon writer"></i>
													<em>${cm.empName }(${cm.deptName })</em></span>
													<span class="comment-date  ms-4"> <i
														class="icon date"></i>${cm.icRegDtStr }
													</span>
												</div>
												<button type="button" class="btn btn-light ms-1 delete-comment" data-bs-toggle="modal" data-bs-target="#exampleModal" data-id="${cm.icId }">삭제</button>
											</div>

										</div>
									</c:if> 
									<c:if test="${empty cm.icTopId}">
										<div class="depth-row" style=" border-bottom: 1px solid #e5e5e5;">
											<div class="comment-content" style=" background-color: #E3E4FA; border-radius: 5px;">
												<div class="imgbox">
													<div class="img-in no-img">
<%-- <img src="${pageContext.request.contextPath}/${cm.empImg}" alt="작성자프로필이미지"> --%>
														<c:if test="${empty cm.emp.base64Img}">
														<img class="myprofil" src="${pageContext.request.contextPath}/resources/images/prog/navi.jpg" 
														style="width:80%; height:auto;"  alt="작성자프로필이미지">
														</c:if>
														<c:if test="${not empty  cm.emp.base64Img}">
															<img class="myprofil" src="data:image/*;base64,${cm.emp.base64Img }"
															 style="width:80%; height:auto;"  alt="작성자프로필이미지">
														</c:if>
													</div>
												</div>

												<c:if test="${cm.icDelYn == 'Y'}">
													<div class="writebox">삭제된 글입니다.</div>
											    </c:if>
												<c:if test="${cm.icDelYn == 'N'}">
													<div class="writebox">
														<span>${cm.icCn }</span>
													</div>
												</c:if>

											</div>
											<div class="comment-info d-flex justify-content-between">
												<div class="left  d-flex ">
													<span class="comment-writer"> <i class="icon writer"></i>
													<em>${cm.empName }(${cm.deptName })</em></span>
													<span class="comment-date  ms-4"> 
													<i class="icon date"></i>${cm.icRegDtStr }
													</span>
													<button type="button" class="btn btn-light ms-1 top-comment"  data-bs-toggle="modal" data-bs-target="#icInsertModal"  data-id="${cm.icId }" data-name="${cm.empName}" data-dept="${cm.deptName }">답글쓰기</button>
												</div>
												
												<button type="button" class="btn btn-light ms-1 delete-comment" data-bs-toggle="modal" data-bs-target="#exampleModal" data-id="${cm.icId }">삭제</button>
											</div>
										</div>
									</c:if>								
								</li>
							</ul>
					</c:forEach>
					</div>
					<!-- comment list -->
					<!-- comment-input -->
					<span id="ictopid"></span>
					<div class="d-flex mb-4 comment-input">
						<label for="textarea"><span class="sr-only">댓글입력창</span></label>
						<textarea class="form-control" rows="5" placeholder="댓글을 입력해주세요" id="icCn" name="isssueCn"></textarea>
						<input class="btn btn-secondary register commentRegBtn" type="button" value="등록" >
					</div>
					<!-- comment-input -->

				</div>
			</div>
		</form>
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
		<!-- commentForm -->
		
		<!-- Modal -->
		<div class="modal info fade" id="icInsertModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<strong class="modal-title fs-5" id="nameLabel"></strong>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<span id="ictopid"></span>
					<div class="d-flex mb-8 comment-input">
						<label for="textarea"><span class="sr-only">댓글입력창</span></label>
						<textarea class="form-control" rows="5" placeholder="댓글을 입력해주세요" id="icCn" name="isssueCn"></textarea>
						<input class="btn btn-secondary register commentRegBtn1" type="button" value="등록" >
					</div>
				</div>
			</div>
		</div>
		<!-- modal -->
	</div>
</div>
<!-- project veiw -->
<!-- button -->
<div class="btn-box clearfix mt-4">
	<button class="btn btn-secondary">목록</button>
	<div class="right float-end">
		<button class="btn btn-danger" data-bs-toggle="modal"
			data-bs-target="#deleteModal">삭제</button>
		<a
			href="${pageContext.request.contextPath}/project/issue/modify/${project.proId }/${issue.issueId}"><button
				class="btn btn-primary">수정</button></a>
	</div>
</div>

<!-- button -->
<script>
	$(document).ready(function(){
		
		const cPath = document.body.dataset.contextPath;
		function getCsrfToken(){
			return document.querySelector('meta[name="_csrf"]').getAttribute('content');
		}
		function getCsrfHeader(){
			return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
		}
		$(deleteForm).on("submit",function(e){
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
					deleteResult.innerHTML='이슈 삭제에 성공했습니다.'
					window.location.pathname='${pageContext.request.contextPath}/project/issue/${project.proId}'
				}else{
					deleteResult.innerHTML='이슈 삭제에 실패했습니다.'
				}
			}).catch(err=>{
				console.error(err);
			})
		})
		
		// ISSUE ID
		// PROJECT ID
// 		ISSUECOMMENTID => ISSUE TOP ID
		// ISSUE IC CN
	 	$(".top-comment").on("click", function(e) {
            let btn = $(e.target);
            let icId = btn.data("id");
            let empName = btn.data("name"); // 클릭한 댓글의 사원명 데이터를 가져옴
            let deptName = btn. data("dept");
            let icTopIdInput = $("#ictopid");
            icTopIdInput.val(icId);
            $("#nameLabel").text(empName +"(" + deptName +")"+"님에게 답글 쓰기"); // 모달 창 제목에 사원명 표시
        });
        
		$(".commentRegBtn1").on("click",function(e){
		  let issueId = '${issue.issueId}';
            let proId = '${project.proId}';
            e.preventDefault();
            let issueIcCn = $(this.previousElementSibling).val();
            let icTopId = $("#ictopid").val();
            let data = {
                "issueId": issueId,
                "proId": proId,
                "icCn": issueIcCn,
                "icTopId": icTopId 
            };
			let body=JSON.stringify(data);
			fetch(cPath+"/project/issue/comment/reg",{
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
// 					 window.location.reload();
				}
			}).catch(err=>{
				console.error(err);
			})
		})
		$(".commentRegBtn").on("click",function(e){
		  let issueId = '${issue.issueId}';
            let proId = '${project.proId}';
            e.preventDefault();
            let issueIcCn = $(this.previousElementSibling).val();
            let data = {
                "issueId": issueId,
                "proId": proId,
                "icCn": issueIcCn,
            };
			let body=JSON.stringify(data);
			fetch(cPath+"/project/issue/comment/reg",{
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
// 					 window.location.reload();
				}
			}).catch(err=>{
				console.error(err);
			})
		})
		
		$(".delete-comment").on("click",function(e){
			
			console.log(e.target);
			let icId = $(e.target).data("id");
			console.log(icId);
			
			console.log($("#delcomment")[0]);
			$("#delcomment").on("click",function(e){
				
				fetch(cPath+"/project/issue/delcomment?icId="+icId,{
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
		
		
	});
</script>


