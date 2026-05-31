<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<form id="deleteForm"
	action="${pageContext.request.contextPath }/board/qna/del/${qna.bpId }">
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
			<span class="category project m0 my-2">${qna.qnaName}</span> <strong
				class="view-tit icon-tit"> <span class="icon qna_b"></span>
				<em>${qna.bpTitle }</em></strong>
			<ul class="ul clearfix">

				<li><span class="list-tit">작성자</span><span>${qna.empName }</span></li>
				<li><span class="list-tit">등록일자</span><span>${qna.bpRegDtStr }</span></li>
				<li><span class="list-tit">조회수</span><span>${qna.bpCnt }</span></li>
				<li><span class="list-tit">수정일자</span> <span><c:if
							test="${empty qna.bpModDt}">수정내역 없음</c:if> <c:if
							test="${not empty qna.bpModDt}">${qna.bpModDtStr }</c:if> </span></li>
			</ul>
		</div>
		<div class="view_content">
			${qna.bpCn }

		</div>
			<!-- 관리자 답글 -->
			<div class="card bg-light">
				<div class="view_inner">
						<strong class="view-tit">관리자 답글</strong>
						<div class="view_content">${qna.bpQnaAs }</div>
				</div>
			</div>
			<!-- 관리자 답글 -->
		
	</div>
	<!-- modal -->

</div>


<!-- button -->
<div class="btn-box clearfix mt-4">
	<a href="${pageContext.request.contextPath }/board/qna"><button
			class="btn btn-secondary">목록</button></a>
	<div class="right float-end">
		<button class="btn btn-danger" data-bs-toggle="modal"
			data-bs-target="#deleteModal">삭제</button>
		<a
			href="${pageContext.request.contextPath }/board/qna/mod/${qna.bpId}"><button
				class="btn btn-primary">수정</button></a>
	</div>
</div>
<!-- button -->

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
			if(jsonObj.msg=="ok"){
			$(deleteResult).text("삭제가 완료되었습니다.");
			window.location.href="${pageContext.request.contextPath}/board/qna"
		}else{
			$(deleteResult).text("삭제에 실패했습니다.");
			window.location.reload();
		}
		}).catch(err=>{
			console.error(err);
		})
	})
	})
	</script>