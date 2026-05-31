<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<form:form id="insertForm" modelAttribute="bf" enctype="multipart/form-data">
	<input type="hidden" name="brdId" value="BN0002">
	
	<div class="modal fade info" id="exampleModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<strong class="modal-title fs-5" id="exampleModalLabel">안내</strong>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body" id="insertResult">"서식글을 등록하시겠습니까?"</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
					<input type="button" class="btn btn-primary" id="insertBtn" value="확인">
				</div>
			</div>
		</div>
	</div>
	
	<!-- project veiw -->
	<div class="header-title select">
		<h2>
			<strong class="title-name">서식게시판 관리</strong>
		</h2>
	</div>
	<div class="side_inner">
		<div class="content-box">
			<div class="view task">
				<div class="view_inner">
					<div class="view-info">
						<strong class="view-tit d-flex align-items-center">
							<div class=" me-2">
								<label for="" class="">제&nbsp;&nbsp;목</label>
							</div>
							<div class=" col-sm-11">
								<input type="text" class="form-control" name="bpTitle"
									placeholder="제목을 입력해주세요" value="${bf.bpTitle }">
								<form:errors path="bpTitle" element="span"
									cssClass="text-danger" />
							</div>
						</strong>
					</div>
					<div class="view_content" id="viewEdit">${bf.bpCn}</div>
				</div>
				<span class="errorMsg">
				<form:errors path="bpCn" element="span" cssClass="text-danger" />
				</span>
				<input type="hidden" name="bpCn" id="bpCn">
			</div>
			<!-- project veiw -->

			<!-- 첨부파일 -->
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
	</div>
</form:form>
<!-- 첨부파일 -->

<!-- button -->
<div class="btn-box clearfix mt-4 formmod_footbtn">
	<div class="right float-end">
		<a href="${pageContext.request.contextPath }/admin/form"><button class="btn btn-danger">취소</button>	</a>
		<input class="btn btn-primary" data-bs-toggle="modal" id="modalBtn" type="button" data-bs-target="#exampleModal" value="등록">
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
	            	
	            	$(insertBtn).on("click",function(e){
	            		console.log(e.target);
	            		$(bpCn).val(editor.getData());
	            		let formData = new FormData(insertForm);
	            		formData.append(getCsrfHeader(),getCsrfToken())
	            		let keys=formData.keys()
	            		for(let i of keys){
	            			console.log(i)
	            		}
	            		console.log(formData)
	            		$(insertForm).submit()
	            	})
			});
})

</script>
