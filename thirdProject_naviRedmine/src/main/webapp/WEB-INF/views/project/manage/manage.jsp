<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<form id="deleteForm" action="${pageContext.request.contextPath }/project">
<input type="hidden" name='proId' value="${project.proId }" >
<div class="modal fade info" id="deleteModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<strong class="modal-title fs-5" id="deleteModalLabel">안내</strong>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body" id="deleteResult">"프로젝트를 삭제하시겠습니까?"</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">닫기</button>
				<button type="submit" class="btn btn-danger" id="deleteBtn">삭제</button>
			</div>
		</div>
	</div>

</div>
</form>
<div class="modal fade info" id="endModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<strong class="modal-title fs-5" id="deleteModalLabel">안내</strong>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body" id="endResult">"프로젝트를 마감하시겠습니까?"</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-danger" id="endBtn">마감</button>
			</div>
		</div>
	</div>
</div>
<form:form action="${pageContext.request.contextPath }/project" method="PUT" id="modifyForm">
<div class="modal fade info" id="exampleModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<strong class="modal-title fs-5" id="exampleModalLabel">안내</strong>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body" id="updateResult">"프로젝트를 수정하시겠습니까?"</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">닫기</button>
				<button type="submit" class="btn btn-primary" id="modifyBtn">확인</button>
			</div>
		</div>
	</div>

</div>
<!-- modify veiw -->
<div class="view edit">
	<div class="view_inner">
		<div class="view-info">
			<strong class="view-tit d-flex align-items-center">
				<div class=" col-sm-1">
					<label for="" class="">프로젝트 명</label>
				</div>
				<div class=" col-sm-11">
					<input type="text" class="form-control" name="proName"
						placeholder="프로잭트 명을 입력해주세요" value="${project.proName }">
				</div>

			</strong>
			<ul class="ul clearfix">

				<li  class="d-flex w-50  align-items-center mb-2"><span class="list-tit">담당자</span>
					<span class=" col-sm-6" aria-label="Default select example">
						<div class="form-control">${project.empName }</div>
				</span></li>
				<li class="d-flex w-50  align-items-center mb-2"><span class="list-tit">진행기간</span> <span class=" col-sm-6"
					aria-label="Default select example">
						<input type="text"  class="form-control" readonly value="${project.ingProjectDT }">
				</span></li>
				<li class="d-flex w-50  align-items-center mb-2"><span class="list-tit">등록일</span> <span class=" col-sm-6"
					aria-label="Default select example"> <input
						class="form-control" type="datetime-local" name="proRegDt"
						value="${project.realProRegDtStr }">
				</span></li>
				<li class="d-flex w-50  align-items-center mb-2"><span class="list-tit">마감일</span> <span class=" col-sm-6"
					aria-label="Default select example"> <input
						class="form-control" type="datetime-local" name="proDdlineEx" 
						value="${project.realProDdlineExStr }">
				</span></li>
				<li class="d-flex w-50  align-items-center mb-2"><span class="list-tit">상태</span> <span> <select
						class="form-select form-control" name="proStId" aria-label="Default select example">
						<c:forEach items="${projectStateList}" var="ps">
									<c:choose>
						            <c:when test="${ps.cmId eq project.proStId}">
						                <option value="${ps.cmId}" selected>${ps.cmName}</option>
						            </c:when>
						            <c:otherwise>
						                <option value="${ps.cmId }">${ps.cmName}</option>
						            </c:otherwise>
						        </c:choose>
								</c:forEach>
					</select>
				</span></li>
			</ul>
		</div>
		<div class="view_content" id="viewEdit">
			${project.proDesc }
		</div>
		<!-- 첨부파일 -->
		<!-- 첨부파일 -->

	</div>
</div>
<input type="hidden" name='proId' value="${project.proId }" >
<input type="hidden" name="proDesc" id="proDesc" >
</form:form>
<!-- modify veiw -->
<!-- button -->
<div class="btn-box clearfix mt-4">
	<a href="${pageContext.request.contextPath }/project"><button class="btn btn-secondary">목록</button></a>
	<div class="right float-end">
		<button class="btn btn-danger" data-bs-toggle="modal"
				data-bs-target="#endModal">마감</button>
		<button class="btn btn-danger" data-bs-toggle="modal"
			data-bs-target="#deleteModal">삭제</button>
		<button class="btn btn-primary" data-bs-toggle="modal" 
			data-bs-target="#exampleModal">수정</button>
	</div>
</div>

<script type="text/javascript"
	src='<c:url value="/resources/js/common/ckeditor5/super/ckeditor.js"/>'></script>
<script type="text/javascript"
	src="<c:url value='/resources/js/common/datepicker/jquery-ui.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/resources/js/common/datepicker/lang/datepicker-ko.js'/>"></script>
<script>

$(document).ready(function(){
	let editor;
	function getCsrfToken(){
		return document.querySelector('meta[name="_csrf"]').getAttribute('content');
	}
	function getCsrfHeader(){
		return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
	}
	 let viewEdit = document.querySelector("#viewEdit")
   CKEDITOR.ClassicEditor.create(viewEdit, {
               
                toolbar: {
                    items: [
                        'exportPDF','exportWord', '|',
                        'findAndReplace', 'selectAll', '|',
                        'heading', '|',
                        'bold', 'italic', 'strikethrough', 'underline', 'code', 'subscript', 'superscript', 'removeFormat', '|',
                        'bulletedList', 'numberedList', 'todoList', '|',
                        'outdent', 'indent', '|',
                        'undo', 'redo',
                        '-',
                        'fontSize', 'fontFamily', 'fontColor', 'fontBackgroundColor', 'highlight', '|',
                        'alignment', '|',
                        'link', 'uploadImage', 'blockQuote', 'insertTable', 'mediaEmbed', 'codeBlock', 'htmlEmbed', '|',
                        'specialCharacters', 'horizontalLine', 'pageBreak', '|',
                        'textPartLanguage', '|',
                        'sourceEditing'
                    ],
                    shouldNotGroupWhenFull: true
                },
             
                language: 'ko',
                list: {
                    properties: {
                        styles: true,
                        startIndex: true,
                        reversed: true
                    }
                },
               
                heading: {
                    options: [
                        { model: 'paragraph', title: 'Paragraph', class: 'ck-heading_paragraph' },
                        { model: 'heading1', view: 'h1', title: 'Heading 1', class: 'ck-heading_heading1' },
                        { model: 'heading2', view: 'h2', title: 'Heading 2', class: 'ck-heading_heading2' },
                        { model: 'heading3', view: 'h3', title: 'Heading 3', class: 'ck-heading_heading3' },
                        { model: 'heading4', view: 'h4', title: 'Heading 4', class: 'ck-heading_heading4' },
                        { model: 'heading5', view: 'h5', title: 'Heading 5', class: 'ck-heading_heading5' },
                        { model: 'heading6', view: 'h6', title: 'Heading 6', class: 'ck-heading_heading6' }
                    ]
                },
                
                placeholder: 'Welcome to CKEditor 5!',
              
                fontFamily: {
                    options: [
                        'default',
                        'Arial, Helvetica, sans-serif',
                        'Courier New, Courier, monospace',
                        'Georgia, serif',
                        'Lucida Sans Unicode, Lucida Grande, sans-serif',
                        'Tahoma, Geneva, sans-serif',
                        'Times New Roman, Times, serif',
                        'Trebuchet MS, Helvetica, sans-serif',
                        'Verdana, Geneva, sans-serif'
                    ],
                    supportAllValues: true
                },
               
                fontSize: {
                    options: [ 10, 12, 14, 'default', 18, 20, 22 ],
                    supportAllValues: true
                },
             
                htmlSupport: {
                    allow: [
                        {
                            name: /.*/,
                            attributes: true,
                            classes: true,
                            styles: true
                        }
                    ]
                },
                
                htmlEmbed: {
                    showPreviews: true
                },
              
                link: {
                    decorators: {
                        addTargetToExternalLinks: true,
                        defaultProtocol: 'https://',
                        toggleDownloadable: {
                            mode: 'manual',
                            label: 'Downloadable',
                            attributes: {
                                download: 'file'
                            }
                        }
                    }
                },
             
                mention: {
                    feeds: [
                        {
                            marker: '@',
                            feed: [
                                '@apple', '@bears', '@brownie', '@cake', '@cake', '@candy', '@canes', '@chocolate', '@cookie', '@cotton', '@cream',
                                '@cupcake', '@danish', '@donut', '@dragée', '@fruitcake', '@gingerbread', '@gummi', '@ice', '@jelly-o',
                                '@liquorice', '@macaroon', '@marzipan', '@oat', '@pie', '@plum', '@pudding', '@sesame', '@snaps', '@soufflé',
                                '@sugar', '@sweet', '@topping', '@wafer'
                            ],
                            minimumCharacters: 1
                        }
                    ]
                },
            
                removePlugins: [
                 
                    'AIAssistant',
                    'CKBox',
                    'CKFinder',
                    'EasyImage',
                    'RealTimeCollaborativeComments',
                    'RealTimeCollaborativeTrackChanges',
                    'RealTimeCollaborativeRevisionHistory',
                    'PresenceList',
                    'Comments',
                    'TrackChanges',
                    'TrackChangesData',
                    'RevisionHistory',
                    'Pagination',
                    'WProofreader',
                    'MathType',
                    'SlashCommand',
                    'Template',
                    'DocumentOutline',
                    'FormatPainter',
                    'TableOfContents',
                    'PasteFromOfficeEnhanced',
                    'CaseChange'
                ]
            }).then(newEditor=>{
	            	editor=newEditor
					$(modifyForm).on("submit",function(e){
					e.preventDefault();
					$(proDesc).val(editor.getData())
					console.log($(proDesc).val())
					let data={};
					let formData= new FormData(modifyForm);
					for(let n of formData.keys()){
						data[n]=formData.get(n)
					}
					let body=JSON.stringify(data);
					console.log(getCsrfToken())
					console.log(getCsrfHeader())
					fetch(modifyForm.action,{
						method:"PUT",
						headers:{
							"accept":"application/json",
							"content-type":"application/json",
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
						if(jsonObj.msg=='ok'){
							updateResult.innerHTML="수정이 완료되었습니다."
							location.reload();
						}else{
							updateResult.innerHTML="수정에 실패했습니다.."
						}
					})
				})
				
				$(deleteForm).on("submit", function(e){
					e.preventDefault();
					let data={};
					let formData= new FormData(deleteForm);
					for(let n of formData.keys()){
						data[n]=formData.get(n)
					}
					let body=JSON.stringify(data);
					fetch(deleteForm.action,{
						method:"DELETE",
						headers:{
							"accept":"application/json",
							"content-type":"application/json",
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
						if(jsonObj.msg=='ok'){
							deleteResult.innerHTML="삭제가 완료되었습니다."
							window.location.pathname='${pageContext.request.contextPath}/project'
						}else{
							deleteResult.innerHTML="삭제에 실패했습니다."
						}
					})
				})
			});
	 $(endBtn).on("click",function(){
		 fetch("${pageContext.request.contextPath}/project/end/${project.proId}",{
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
			console.log(jsonObj)
			if(jsonObj=='ok'){
				endResult·innerHTML="마감이 완료되었습니다."
				window.location.pathname='${pageContext.request.contextPath}/project'
			}else{
				endResult·innerHTML="마감에 실패했습니다."
			}
		}).catch(err=>{
			console.error(err);
		})
	 })
})

</script>
