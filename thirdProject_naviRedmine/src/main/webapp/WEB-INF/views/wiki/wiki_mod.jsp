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

<form:form
	action="${pageContext.request.contextPath }/wiki/mod/${wiki.wikiId }"
	id="updateForm">
	<div class="modal fade info" id="modifyModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<strong class="modal-title fs-5" id="exampleModalLabel">안내</strong>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body" id="updateResult">"게시글을 수정하시겠습니까?"</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" id="modifyBtn">확인</button>
				</div>
			</div>
		</div>
	</div>

	<div class="content">
		<div class="inner html">
			<!-- ui : s -->
			<!-- modify veiw -->
			<div class="view edit">
				<div class="view_inner">

					<div class="view-info">
						<strong class="view-tit d-flex align-items-center">
							<div class=" col-sm-1">
								<span class="category project">${wiki.proId }</span>
							</div>
							<div class=" col-sm-11">
								<input type="text" class="form-control" name="wikiTitle"
									placeholder="제목을입력해주세요" value="${wiki.wikiTitle }">
							</div>

						</strong>
						<ul class="ul clearfix">
							<li><span class="list-tit">프로젝트명</span> <span>${wiki.proName }</span></li>
							<li><span class="list-tit">담당자</span> <span>${wiki.empName }</span></li>
							<li><span class="list-tit">등록일자</span> <span>${wiki.proRegDtStr }</span></li>
							<li><span class="list-tit">마감일자</span> <span>${wiki.proDdlineExStr }</span></li>
							<li><span class="list-tit">위키수정일자</span> <span> <c:if
										test="${empty wiki.wikiModDtStr}">수정내역 없음</c:if> <c:if
										test="${not empty wiki.wikiModDtStr}">${wiki.wikiModDtStr }</c:if>
							</span></li>
							<li><span class="list-tit">상태</span> <span>${wiki.cmName }</span></li>
						</ul>
					</div>
					<div class="view_content" id="viewEdit">${wiki.wikiCn }</div>
					<input type="hidden" name="wikiCn" id="wikiCn">
					<div class="content">
						<div class="inner html">
							<c:forEach items="${fileList }" var="f">
								<div class="addfile">
									<ul class="fileList">
										<li
											class="d-flex file-row align-items-center justify-content-between mb-2">
											<i data-id="${f.wfId}" class="icon close"><em
												class="sr-only">첨부파일삭제</em></i> <a
											href="${pageContext.request.contextPath }/wiki/download/${f.wfId}"
											class="file_item d-flex align-items-center"> <c:choose>
													<c:when test="${empty f.wkFileGbId}">
														<em class="file_name">첨부된 파일이 없습니다.</em>
													</c:when>
													<c:otherwise>
														<c:if test="${f.wkFileGbId eq 'pdf' }">
															<i class="icon pdf"><em class="sr-only">${f.wkFileGbId }</em></i>
														</c:if>
														<c:if test="${f.wkFileGbId eq 'txt' }">
															<i class="icon txt"><em class="sr-only">${f.wkFileGbId }</em></i>
														</c:if>
														<c:if test="${f.wkFileGbId eq 'jpg'}">
															<i class="icon txt"><em class="sr-only">${f.wkFileGbId }</em></i>
														</c:if>
														<c:if test="${f.wkFileGbId eq 'png' }">
															<i class="icon txt"><em class="sr-only">${f.wkFileGbId }</em></i>
														</c:if>
														<c:if test="${f.wkFileGbId eq 'word' }">
															<i class="icon word"><em class="sr-only">${f.wkFileGbId }</em></i>
														</c:if>
														<c:if test="${f.wkFileGbId eq 'xlsx' }">
															<i class="icon xlsx"><em class="sr-only">${f.wkFileGbId }</em></i>
														</c:if>
														<c:if test="${f.wkFileGbId eq 'zip' }">
															<i class="icon zip"><em class="sr-only">${f.wkFileGbId }</em></i>
														</c:if>
														<c:if test="${f.wkFileGbId eq 'hwp' }">
															<i class="icon hangle"><em class="sr-only">${f.wkFileGbId }</em></i>
														</c:if>
														<c:if test="${f.wkFileGbId eq 'ppt' }">
															<i class="icon ppt"><em class="sr-only">${f.wkFileGbId }</em></i>
														</c:if>
														<c:if test="${f.wkFileGbId eq 'pptx' }">
															<i class="icon ppt"><em class="sr-only">${f.wkFileGbId }</em></i>
														</c:if>
													</c:otherwise>
												</c:choose> <span class=""> <em class="file_name">${f.wfOrgNm }</em></span>
										</a> <span
											class="file_size p-1 border border-dark-subtle fileSize">${f.wikiFileSize }</span>
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
				</div>
			</div>
		</div>
	</div>
</form:form>
<!-- modify veiw -->
<input type="hidden" name="wikiId" value="${wiki.wikiId}">
<!-- button -->
<div class="btn-box clearfix mt-4">
	<a href="${pageContext.request.contextPath }/wiki"><button
			class="btn btn-danger">취소</button></a>
	<div class="right float-end">
		<button class="btn btn-primary" data-bs-toggle="modal"
			data-bs-target="#modifyModal">수정</button>
	</div>
</div>
<!-- button -->

<script type="text/javascript">
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
	            	editor=newEditor;
	            	$(".close").on("click",function(e){
	            		let issffId = $(this).data("id");
	            		$(this).parent().remove();
	            		fetch("${pageContext.request.contextPath}/wiki/file/del/"+issffId,{
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
	            	$(modifyBtn).on("click",function(e){
	            		console.log(e.target)
	            		$(wikiCn).val(editor.getData())
	            		console.log($(wikiCn).val())
	            		let data={};
						let formData= new FormData(updateForm);
						for(let n of formData.keys()){
							data[n]=formData.get(n)
						}
						let body=JSON.stringify(data);
	            		
	            		fetch(updateForm.action,{
							method:"POST",
							headers:{
								"Accept":"application/json",
// 								"Content-type":"application/json",
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
							if(jsonObj.msg=="ok"){
								$(updateResult).text("수정이 완료되었습니다.");
								window.location.href="${pageContext.request.contextPath}/wiki"
							}else{
								$(updateResult).text("수정에 실패했습니다.");
								window.location.reload();
							}
						}).catch(err=>{
							console.error(err);
						})
	            		
	            	})
	            	
			});
})
</script>
