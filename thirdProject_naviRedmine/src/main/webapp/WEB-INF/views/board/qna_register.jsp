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


<form:form id="insertForm" modelAttribute="qna">
	<input type="hidden" name="brdId" value="BN0005">
	<div class="modal fade info" id="exampleModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<strong class="modal-title fs-5" id="exampleModalLabel">안내</strong>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body" id="insertResult">"칭찬글을 등록하시겠습니까?"</div>
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
						<input type="text" name="bpTitle" class="form-control" placeholder="관리자에게 질문해주세요!" value="${qna.bpTitle }">
						<span class="errorMsg"><form:errors path="bpTitle" element="span" cssClass="text-danger" /></span>
						
					</div>

				</strong>
				<ul class="ul clearfix">
<%-- 					<li><span class="list-tit">작성자</span> <span>${qna.empName}</span></li> --%>
<!-- 					<li><span class="list-tit">답변상태</span> -->
<!-- 					<span><select class="form-select" name="bpQnaYn" -->
<!-- 								  aria-label="Default select example"> -->
<%-- 							<c:forEach items="${qnaState}" var="ps"> --%>
<%-- 								<option value="${ps.bpQnaYn }">${ps.qnaName}</option>		 --%>
<%-- 							</c:forEach> --%>
<!-- 							</select> -->
<!-- 				     </span> -->
<!-- 					</li> -->
<%-- 					<li><span class="list-tit">등록일자</span> <span>${qna.bpRegDtStr}</span> --%>
<!-- 					</li> -->
<!-- 					<li><span class="list-tit">수정자</span> -->
<%-- 					<span><c:if test="${empty qna.bpModId}">수정내역 없음</c:if> --%>
<%-- 					<c:if test="${not empty qna.bpModId}">ADMIN</c:if> --%>
<!-- 					</span> -->
<!-- 					</li> -->
<%-- 					<li><span class="list-tit">수정일자</span><span><c:if  --%>
<%-- 								test="${empty qna.bpModDt }">수정내역 없음</c:if> <c:if --%>
<%-- 								test="${not empty qna.bpModDt }">${qna.bpModDtStr }</c:if> --%>
<!-- 					</span></li> -->
				</ul>
			</div>
			<div class="view_content" id="viewEdit">${qna.bpCn }</div>
			</div>
				<span class="errorMsg"><form:errors path="bpCn" element="span" cssClass="text-danger" /></span>
				<input type="hidden" name="bpCn" id="bpCn">

			</div>
</form:form>

	<!-- modify veiw -->
	<!-- button -->
	<div class="btn-box clearfix mt-4">
		<div class="right float-end">
		<button id="autoBtn" class="btn btn-primary"
		>자동</button>
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
	            	$(autoBtn).on("click",function(){
            		let name=$(insertForm).find("input[name]")
            		name.each((i,v)=>{
            			console.log(i,v)
            			if($(v).attr("name")=="bpCn"){
            				let cn="채팅 비밀번호를 왜 꼭 입력해야 하나요?"
            				$(v).val(cn)
        					newEditor.setData(cn)
            			}
            			if($(v).attr("name")=="bpTitle"){
            				$(v).val("채팅 들어갈 때 비밀번호 치기 귀찮다고요!")
        				}
            		})
            	})
			});
})


</script>