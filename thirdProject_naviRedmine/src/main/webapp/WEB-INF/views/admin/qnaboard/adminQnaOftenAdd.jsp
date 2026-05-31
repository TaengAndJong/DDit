<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script type="text/javascript" src='/navi/resources/js/common/ckeditor5/super/ckeditor.js'></script>
<script type="text/javascript" src="/navi/resources/js/common/datepicker/jquery-ui.js"></script>
<script type="text/javascript" src="/navi/resources/js/common/datepicker/lang/datepicker-ko.js"></script>


<form:form id="insertForm" modelAttribute="qna">
	<input type="hidden" name="brdId" value="BN0005">
	<div class="modal fade info" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<strong class="modal-title fs-5" id="exampleModalLabel">안내</strong>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body" id="insertResult">"FAQ를 등록하시겠습니까?"</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" id="insertBtn">확인</button>
				</div>
			</div>
		</div>
	</div>
	<!-- register veiw -->
	<div class="view edit">
		<div class="view_inner">
			<div class="view-info">
				<strong class="view-tit d-flex align-items-center">
					<div class="me-2">
						<label for="" class="">제&nbsp;&nbsp;목</label>
					</div>
					<div class=" col-sm-11">
						<input type="text" name="bpTitle" class="form-control" placeholder="제목을입력해주세요" value="${qna.bpTitle }"/> 
						<span class="errorMsg">
							<form:errors path="bpTitle" element="span" cssClass="text-danger" />
						</span>
					</div>
				</strong>
				<ul class="ul clearfix">
				</ul>
			</div>
			<div class="view_content" id="viewEdit">${qna.bpCn }</div>
			<div class="view_content" id="viewEdit">${qna.bpQnaAs }</div>
		</div>
		<span class="errorMsg"><form:errors path="bpCn" element="span"
				cssClass="text-danger" /></span> <input type="hidden" name="bpCn"
			id="bpCn">

	</div>
</form:form>

		<!-- ui : s -->
		<!-- ui : file list & upload  s -->
		<div class="addfile">
			<!-- file_list -->
			<ul class="fileList">
				<!-- pdf -->
				<li class="d-flex file-row align-items-center justify-content-between">
					<a href="" class="file_item d-flex align-items-center"> <i
						class="icon close"><em class="sr-only">첨부파일삭제</em></i> <i
						class="icon pdf"><em class="sr-only">pdf파일</em></i> <span class="">
							<em class="file_name">대덕인재개발원 리뉴얼.pdf</em> <span
							class="tm d-flex align-items-center mt-2"><i class="icon time_b"></i>2분 전</span>
					</span>
				</a> <span class="file_size p-1 border border-dark-subtle fileSize">604KB</span>
				</li>
			</ul>
			<!-- file_list -->
			<div class="input-group my-2">
				<input type="file" class="form-control" id="addFileInput"
					aria-describedby="addFileBtn" aria-label="Upload">
				<button class="btn btn-primary" type="button" id="addFileBtn">첨부</button>
			</div>
			<!-- ui : addfile e -->
		</div>
		<!-- ui : file list & upload :  e -->
	</div>
	<!-- modify veiw -->
	<!-- button -->
	<div class="btn-box clearfix mt-4">
		<div class="right float-end">
			<a href="${pageContext.request.contextPath }/board/qna"><button class="btn btn-danger">취소</button></a>
			<input class="btn btn-primary" id="insertBtn"	type="button" value="확인">
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
	            		$(insertForm).submit()
	            	})
			});
})


</script>