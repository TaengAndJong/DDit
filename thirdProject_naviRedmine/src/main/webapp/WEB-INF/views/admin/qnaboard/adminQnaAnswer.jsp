<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<div class="header-title select">
	<h2>
		<strong class="title-name">QNA 관리</strong>
	</h2>
</div>

<!--inner-->
<div id="layoutSidenav_content" class="side_content">
	<div class="side_inner">
		<div class="content-box">
			<!-- ui : 포토공간목록 s -->
			<!-- project veiw -->
			<div class="view">
				<div class="view_inner">
					<div class="view-info">
						<span class="category project">${qna.qnaName}</span> <strong
							class="view-tit icon-tit"> <span class="icon photo"></span>
							<em>${qna.bpTitle }</em></strong>
						<ul class="ul clearfix">

							<li><span class="list-tit">작성자</span><span>${qna.empName }</span></li>
							<li><span class="list-tit">등록일자</span><span>${qna.bpRegDtStr }</span></li>
							<li><span class="list-tit">수정자</span> 
								<span> 
									<c:if test="${empty qna.bpModId}">수정내역 없음</c:if> 
									<c:if test="${not empty qna.bpModId}">ADMIN</c:if>
								</span>
							</li>
							<li><span class="list-tit">수정일자</span> <span><c:if
										test="${empty qna.bpModDt}">수정내역 없음</c:if> <c:if
										test="${not empty qna.bpModDt}">${qna.bpModDtStr }</c:if> </span></li>
							<li><span class="list-tit">조회수</span><span>${qna.bpCnt }</span></li>
						</ul>
					</div>
					<div class="view_content">${qna.bpCn }</div>

					<div class="view_content">
						<form id="updateForm"
							action="${pageContext.request.contextPath }/admin/qna/answer/${qna.bpId}">
							<textarea class="form-control" name="bpQnaAs" id="bpQnaAs" rows="30"><c:if test="${empty qna.bpQnaAs}"></c:if><c:if test="${not empty qna.bpQnaAs}">${qna.bpQnaAs}</c:if></textarea>
						</form>
						<div class="btn-box clearfix mt-4">
							<div class="right float-end update_content">
								<button class="btn btn-danger" onclick="window.location.href='${pageContext.request.contextPath}/admin/qna'">뒤로가기</button>
								<button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#updateModal">답변하기</button>
									<div class="modal fade info" id="updateModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-header">
													<strong class="modal-title fs-5" id="updateModalLabel">안내</strong>
													<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
												</div>
												<div class="modal-body" id="updateResult">"답변을 등록할까요?"</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
													<button type="button" class="btn btn-danger" id="updateBtn">확인</button>
												</div>
											</div>
										</div>
									</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!--inner-->


<script>
$(document).ready(function(){
	function getCsrfToken(){
		return document.querySelector('meta[name="_csrf"]').getAttribute('content');
	}
	function getCsrfHeader(){
		return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
	}
	
//복구 FUNCTION -> CHECKED항목을 PROID타입의 배열로 전송하여 처리
	$(updateBtn).on("click", function(e){
		e.preventDefault();
// 		let bpQnaAs = $("#bpQnaAs").val();
// 		console.log(bpQnaAs)
		let data={};
		let formData= new FormData(updateForm);
		for(let n of formData.keys()){
			data[n]=formData.get(n)
		}
		let body=JSON.stringify(data);
		console.log(body);
		fetch(updateForm.action,{
			method:"PUT",
			headers:{
				"Accept":"application/json",
		        "Content-Type": "application/json",
				[getCsrfHeader()]: getCsrfToken()
			},body:body
		}).then(resp=>{
			if(resp.ok){
				return resp.json()
			}else{
				throw new Error("상태코드 "+resp.status)
			}
		}).then(jsonObj=>{		
			console.log(jsonObj)
	        if (jsonObj.msg == 'empty'){
	        	updateResult.innerHTML = "답변 내용이 없습니다.";
			} else if (jsonObj.msg == 'ok') {
				updateResult.innerHTML = "답변등록이 완료되었습니다.";
	        } else {
	        	updateResult.innerHTML = "답변등록에 실패했습니다.";
	        }
	        setTimeout(() => {
	            window.location.reload();
	        }, 1000);
		})
	})

})


</script>