<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div class="header-title select">
	<h2>
		<strong class="title-name">공지사항 관리</strong>
	</h2>
</div>
<!--inner-->
<form:form modelAttribute="addAno" id="insertForm"
	enctype="multipart/form-data">
	<input type="hidden" name="brdId" value="BN0001">
	<div class="side_inner">
		<div class="content-box">
			<div class="content">
				<div class="inner html">
					<!-- ui : s -->
					<!-- project veiw -->
					<strong class="ui-tit">공지사항등록</strong>
					<div class="view">
						<div class="view_inner">
							<div class="view-info">
								<strong class="view-tit d-flex align-items-center">
									<div class="mx-2">제&nbsp;&nbsp;목</div>
									<div class="col-sm-11">
										<input type="text" name="bpTitle" value="${addAno.bpTitle }"
											class="form-control" placeholder="제목을입력해주세요">
										<form:errors path="bpTitle" element="span"
											cssClass="text-danger" />
									</div>
								</strong>
								<ul class="ul clearfix">
									<li class="d-flex w-50  align-items-center mb-2"><span
										class="list-tit">게시판선택</span> <span class="col-sm-6"> <select
											class="form-select" name="bpNtcId"
											aria-label="Default select example">
												<c:forEach items="${boardTypeList}" var="ps">
													<option value="${ps.cmId }">${ps.cmName}</option>
												</c:forEach>
										</select> <form:errors path="bpNtcId" element="span"
												cssClass="text-danger" />
									</span></li>
								</ul>
							</div>
							<div class="view_content" id="viewEdit">${addAno.bpCn }</div>
						</div>
						<form:errors path="bpCn" element="span" cssClass="text-danger" />
						<input type="hidden" name="bpCn" id="bpCn">
					</div>
				</div>

				<div class="content">
					<div class="inner html">
						<!-- ui : s -->
						<!-- ui : table s -->
						<div class="addfile">
							<div class="input-group my-2">
								<input type="file" name="bpAttchFile" multiple="multiple"
									class="form-control" id="addFileInput"
									aria-describedby="addFileBtn" aria-label="Upload">
							</div>
						</div>
					</div>
				</div>
				<!-- button -->
				<!-- ui : e -->

				<div class="btn-box clearfix mt-4">
					<div class="right float-end">
						<input class="btn btn-primary" type="button" id="insertBtn"
							value="완료"> <a
							href="${pageContext.request.contextPath }/admin/ano"><button
								class="btn btn-danger">취소</button></a>
					</div>
				</div>
			</div>
		</div>
	</div>
</form:form>

<script type="text/javascript"
	src='/navi/resources/js/common/ckeditor5/super/ckeditor.js'></script>
<script type="text/javascript"
	src="/navi/resources/js/common/datepicker/jquery-ui.js"></script>
<script type="text/javascript"
	src="/navi/resources/js/common/datepicker/lang/datepicker-ko.js"></script>


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
            	
            })
            
})

</script>