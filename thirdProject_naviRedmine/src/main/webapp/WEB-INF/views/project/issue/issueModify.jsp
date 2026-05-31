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

<form:form action="${pageContext.request.contextPath}/project/issue/modfiy/${issue.issueId }" id="updateForm">
<div class="modal fade info" id="updateModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<strong class="modal-title fs-5" id="exampleModalLabel">안내</strong>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body" id="updateResult">"이슈를 수정하시겠습니까?"</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">닫기</button>
				<input type="submit" class="btn btn-primary" value="수정">
			</div>
		</div>
	</div>
</div>
<!-- project veiw -->
<div class="view task">
	<div class="view_inner">
		<div class="view-info">
			<strong class="view-tit d-flex align-items-center"><div class="mx-2"> <span class="category project ">${issue.issueId }</span></div>
				<div class="col-sm-11"><input type="text" class="form-control" name="issueTitle"
						placeholder="프로잭트 명을 입력해주세요" value="${issue.issueTitle }"></div>
				</strong>
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
				<li class="d-flex w-50  align-items-center mb-2"><span class="list-tit">등록일</span> <span class=" col-sm-6"
					aria-label="Default select example"><span>${issue.issueRegDtStr }</span></span></li>
				<li class="d-flex w-50  align-items-center mb-2"><span class="list-tit">중요도</span><span class=" col-sm-6"
					aria-label="Default select example"><select class="form-select form-control" name="imprtId">
							<c:forEach items="${issueImportStateList }" var="iip">
								<c:choose>
									<c:when test="${iip.cmId eq issue.imprtId}">
										<option value="${iip.cmId }">${iip.cmName }</option>
									</c:when>
									<c:otherwise>
										<option value="${iip.cmId }">${iip.cmName }</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
					</select></span></li>
				<li class="d-flex w-50  align-items-center mb-2"><span class="list-tit">분류</span><span class=" col-sm-6"
					aria-label="Default select example"><select class="form-select  form-control" name="clsfcId" >
							<c:forEach items="${issueStateList }" var="is">
								<c:choose>
									<c:when test="${is.cmId eq issue.clsfcId}">
										<option value="${is.cmId }" selected>${is.cmName }</option>
									</c:when>
									<c:otherwise>
										<option value="${is.cmId }">${is.cmName }</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
					</select></span></li>
				<li class="d-flex w-50  align-items-center mb-2">
				<span class="list-tit">수정일</span>
				<span>
					<c:if test="${empty issue.issueModDt }">수정내역 없음</c:if>
					<c:if test="${not empty issue.issueModDt }">${issue.issueModDtStr }</c:if>
				</span>
				</li>

			</ul>
		</div>
	<div class="view_content" id="viewEdit">	
		${issue.issueCn }	
		</div>
	</div>
	<input type="hidden" name="issueCn" id="issueCn">
	<input type="hidden" name="proId" value="${issue.proId }">
</div>
<!-- project veiw -->
<div class="content">
		<div class="inner html">
			<c:forEach items="${fileList }" var="f">
				<div class="addfile">
					<ul class="fileList">
						<li
							class="d-flex file-row align-items-center justify-content-between mb-2">
							<i data-id="${f.issffId}" class="icon close"><em class="sr-only">첨부파일삭제</em></i>
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
											<i class="icon ppt"><em class="sr-only">${f.issfGbId }</em></i>
										</c:if>
									</c:otherwise>
								</c:choose> <span class=""> <em class="file_name">${f.issfOrgNm }</em></span>
						</a> <span class="file_size p-1 border border-dark-subtle fileSize">${f.issfFileSize }</span>
						</li>
					</ul>

				</div>
			</c:forEach>
			<div class="input-group my-2">
				<input type="file" name="bpAttchFile" multiple="multiple"
					class="form-control" id="addFileInput"
					aria-describedby="addFileBtn" aria-label="Upload">
			</div>
		</div>
	</div>
</form:form>
<!-- button -->
<div class="btn-box clearfix mt-4">
	<button class="btn btn-secondary">목록</button>
	<div class="right float-end">
		<!-- <button class="btn btn-danger">취소</button> -->
		<button class="btn btn-primary" data-bs-toggle="modal"
			data-bs-target="#updateModal">수정</button>
	</div>
</div>
<!-- button -->

<script type="text/javascript"
	src='<c:url value="/resources/js/common/ckeditor5/super/ckeditor.js"/>'></script>
<script type="text/javascript"
	src="<c:url value='/resources/js/common/datepicker/jquery-ui.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/resources/js/common/datepicker/lang/datepicker-ko.js'/>"></script>

<script>
$(document).ready(function(){
	function getCsrfToken(){
		return document.querySelector('meta[name="_csrf"]').getAttribute('content');
	}
	function getCsrfHeader(){
		return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
	}
	 let viewEdit = document.querySelector("#viewEdit")
	 let editor;
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
	            	console.log(editor.getData());
	            	$(".close").on("click",function(e){
	            		let issffId = $(this).data("id");
	            		$(this).parent().remove();
	            		fetch("${pageContext.request.contextPath}/project/issue/file/del/"+issffId,{
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
						}).catch(err=>{
							console.error(err);
						})
	            		
	            	})
// 	            	$("#deleteForm").on("submit",function(e){
// 	        			e.preventDefault();
// 	        			console.log(deleteForm)
// 	        			fetch(deleteForm.action,{
// 	        				method:"DELETE",
// 	        				headers:{
// 	        					"Accept":"application/json",
// 	        					[getCsrfHeader()]: getCsrfToken()
// 	        				}
// 	        			}).then(resp=>{
// 	        				if(resp.ok){
// 	        					return resp.json();
// 	        				}else{
// 	        					throw new Error(`상태코드 ${resp.status} 수신`,{cause:resp})
// 	        				}
// 	        			}).then(jsonObj=>{
// 	        				console.log(jsonObj)
// 	        				if(jsonObj.msg='ok'){
// 	        					deleteResult.innerHTML='이슈 삭제에 성공했습니다.'
// 	        					window.location.pathname='${pageContext.request.contextPath}/project/issue/${project.proId}'
// 	        				}else{
// 	        					deleteResult.innerHTML='이슈 삭제에 실패했습니다.'
// 	        				}
// 	        			}).catch(err=>{
// 	        				console.error(err);
// 	        			});
// 	        		});
	        		$("#updateForm").on("submit",function(e){
	        			e.preventDefault();
	        			console.log(updateForm)
	        			$(issueCn).val(editor.getData());
	        			let data={};
	        			let formData= new FormData(updateForm);
	        			fetch(updateForm.action,{
	        				method:"POST",
	        				headers:{
	        					"Accept":"application/json",
	        					[getCsrfHeader()]: getCsrfToken()
	        				},body:formData
	        			}).then(resp=>{
	        				if(resp.ok){
	        					return resp.json();
	        				}else{
	        					throw new Error(`상태코드 ${resp.status} 수신`,{cause:resp})
	        				}
	        			}).then(jsonObj=>{
	        				console.log(jsonObj)
	        				if(jsonObj.msg='ok'){
	        					updateResult.innerHTML='이슈 수정에 성공했습니다.'
	        						window.location.pathname='${pageContext.request.contextPath}/project/issue/detail/${project.proId}/${issue.issueId}'
	        				}else{
	        					updateResult.innerHTML='이슈 수정에 실패했습니다.'
	        				}
	        			}).catch(err=>{
	        				console.error(err);
	        			})
	        		})
	            });
})

</script>

