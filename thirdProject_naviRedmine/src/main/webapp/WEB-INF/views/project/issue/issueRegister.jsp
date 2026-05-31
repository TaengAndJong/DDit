<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<form:form id="registerForm" method="post" modelAttribute="registerIssue"
enctype="multipart/form-data"
>
<!-- project veiw -->
<div class="view task">
	<div class="view_inner">
		<div class="view-info">
			<strong class="view-tit d-flex align-items-center">
				<div class="mx-2">
					<label for="" class="">제&nbsp;&nbsp;목</label>
				</div>
				<div class="col-sm-11">
					<input type="text" class="form-control" name="issueTitle"
						placeholder="제목을 입력해주세요" value="${issue.issueTitle }">
					<span class="errorMsg">	<form:errors path="issueTitle" element="span" cssClass="text-danger" /></span>
				</div>
			</strong>
			<ul class="ul clearfix">
				<li class="d-flex w-50  align-items-center mb-2"><input type="hidden" name="issueRegId"
					value="${realUser.empId }"> <span class="list-tit">작성자</span>
					<span> ${realUser.empName }(${realUser.deptName },
						${realUser.psName }) </span>
				<li class="d-flex w-50  align-items-center mb-2"><span class="list-tit">중요도</span> <span class=" col-sm-6"
					aria-label="Default select example"><select
						class="form-select form-control" name="imprtId">
							<c:forEach items="${issueImportStateList }" var="iip">
								<option value="${iip.cmId }">${iip.cmName }</option>
							</c:forEach>
					</select> 
					<form:errors path="imprtId" element="span" cssClass="text-danger" /></span></li>
				<li class="d-flex w-50  align-items-center mb-2">
				<span class="list-tit">분&nbsp;&nbsp;류</span>
				<span class=" col-sm-6" aria-label="Default select example">
					
					<select
						class="form-select form-control" name="clsfcId">
							<c:forEach items="${issueStateList }" var="is">
								<option value="${is.cmId }">${is.cmName }</option>
							</c:forEach>
					</select>
					<span class="errorMsg"><form:errors path="clsfcId" element="span" cssClass="text-danger" /></span>
				</span>
					
					</li>
			</ul>
		</div>
		<div class="view_content" id="viewEdit">${issue.issueCn }</div>
		<span class="errorMsg"><form:errors path="issueCn" element="span" cssClass="text-danger" /></span>
		
	</div>
	<input type="hidden" name="issueCn" id="issueCn">
	<div class="content">
			<div class="inner html">
				<div class="uploadResult">
					<div class="input-group my-2 uploadDiv">
						<input type="file" name="bpAttchFile" multiple="multiple" class="form-control" id="addFileInput" aria-describedby="addFileBtn" aria-label="Upload">
					</div>
				</div>
			</div>
		</div>
</div>
</form:form>
<!-- project veiw -->
<!-- button -->
<div class="btn-box clearfix mt-4">
	<button class="btn btn-secondary">목록</button>
	<div class="right float-end">
		<button class="btn btn-primary" id="registerBtn">등록</button>
		<span class="text-danger">${msg }</span>
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
	            	$(registerBtn).on("click",function(e){
						$(issueCn).val(editor.getData())
						console.log($(issueCn).val());
						$(registerForm).submit();
	            	})
	            });
})

</script>

