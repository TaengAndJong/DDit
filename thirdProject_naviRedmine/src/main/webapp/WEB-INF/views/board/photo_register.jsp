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


<form:form id="insertForm" modelAttribute="photo" enctype="multipart/form-data" method="post">
	<input type="hidden" name="brdId" value="BN0004">
	<div class="modal fade info" id="exampleModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<strong class="modal-title fs-5" id="exampleModalLabel">안내</strong>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body" id="insertResult">"포토공간에 글을 등록하시겠습니까?"</div>
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
						<input type="text" class="form-control" name="bpTitle"
							placeholder="제목을 입력해주세요" value="${photo.bpTitle }">
						<span class="errorMsg"><form:errors path="bpTitle" element="span" cssClass="text-danger" /></span>
					</div>
				</strong>
				
				<!--  -->
				
						<div class="uploadResult">
							<label for="addImgInput" class="file-label right float-end" style=" 
																				  background-color: #2E2EFE;
																				  color: #fff;
																				  text-align: center;
																				  padding: 10px 0;
																				  width: 15%;
																				  border-radius: 6px;
																				  cursor: pointer;
																				  ">메인 이미지 등록</label>
																				  <form:errors path="bpImgFile" element="span" cssClass="text-danger" />
							<input type="file" name="bpImgFile" class="form-control" id="addImgInput" aria-describedby="addFileBtn" aria-label="Upload" style="display:none">
						</div>
				<!--  -->
						
				<ul class="ul clearfix">
				</ul>
			</div>
			<div class="view_content" id="viewEdit">${photo.bpCn}</div>
		</div>
		<span class="errorMsg">
			<form:errors path="bpCn" element="span" cssClass="text-danger" />
		</span>
		<input type="hidden" name="bpCn" id="bpCn">
		</div>

			<!-- file_list -->
		<div class="content">
			<div class="inner html">
				
				<div class="uploadResult">
					<div class="input-group my-2 uploadDiv">
						<input type="file" name="bpAttchFile" multiple="multiple" class="form-control" id="addFileInput" aria-describedby="addFileBtn" aria-label="Upload">
					</div>
				</div>
			</div>
		</div>
</form:form>
	<!-- modify veiw -->
	<!-- button -->
	<div class="btn-box clearfix mt-4">
		<div class="right float-end">
		<button id="autoBtn" class="btn btn-primary"
		>자동</button>
			<a href="${pageContext.request.contextPath }/board/photo"><button class="btn btn-danger">취소</button></a>
			<input class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" id="modalBtn"	type="button" value="확인">
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
            		let formData = new FormData(insertForm);
            		formData.append(getCsrfHeader(),getCsrfToken())
            		let keys=formData.keys()
            		for(let i of keys){
            			console.log(i)
            		}
            		console.log(formData)
            		$(insertForm).submit()
	            	})
	           $(autoBtn).on("click",function(){
            		let name=$(insertForm).find("input[name]")
            		name.each((i,v)=>{
            			console.log(i,v)
            			if($(v).attr("name")=="bpCn"){
            				let cn="해골";
            				$(v).val(cn)
        					newEditor.setData(cn)
            			}
            			if($(v).attr("name")=="bpTitle"){
            				$(v).val("나랑 결혼해줄래? 흐흐")
        				}
            		})
            	})
			});
})

		
	</script>
<script type="text/javascript">
// var cloneObj = $(".uploadDiv").clone();

// $("#uploadBtn").on("click", function(e){
// 	var formData = new FormData();
// 	var inputFile = $("input[name='uploadFile']");
// })

// $.ajax({
// 	url: '/board/photo_register',
// 	processData : false,
// 	contentType : false,
// 	datea : formData,
// 	type : 'POST',
// 	dataType : 'json',
// 	success : function(result){
// 		console.log(result);
// 		showUploadedFile(result);
// 		$(".uploadDiv").html(cloneObj.html());
// 	}
// });

// var uploadResult = $(".uploadResult ul");
// 	function showUploadFile(uploadResultArr){
// 		var str = "";
// 		$(uploadResultArr).each(function(i,obj){
// 			str +="<li>" + obj.fileName + "</li>";
// 		});
// 		uploadResult.append(str);
// 	}
</script>