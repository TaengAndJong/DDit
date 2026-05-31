<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<style>
.pagination li {
  display:inline-block;
padding: 0 10px;
}
.table-responsive{max-height:260px}

</style>
<script src="//cdnjs.cloudflare.com/ajax/libs/list.js/1.5.0/list.min.js"></script>
<div class="modal fade" id="insertModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true"
	data-pro-id="${task.proId }">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header bg-primary text-white">
				<strong class="modal-title fs-5" id="exampleModalLabel">안내</strong>
				<button type="button" class="btn-close w me-1" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body" id="updateResult">
				<div id="cstmrList" data-list>
					<div class="row justify-content-end g-0">
						<div class="searchBox">
							<form id="submitForm"
								action="${pageContext.request.contextPath }/project/emp/list"
								method="post">
								<div class="input-group d-flex">
									<input class="form-control form-control-sm shadow-none search"
										type="search" placeholder="Search..." aria-label="search" />
									<div class="input-group-text btn btn-secondary col-2">
										<span class="fa fa-search fs-10 text-600">검색</span>
									</div>
								</div>
							</form>
						</div>
					</div>
					<div class="table-responsive scrollbar scrollY mt-4">
						<table class="table table-bordered table-striped fs-10 mb-0 mt-4">
							<caption class="sr-only">
							게시판별 알림설정 테이블입니다.
						</caption>
						<colgroup>
							<col style="width:15%">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:25%">
							<col style="width:20%">
							
						</colgroup>
						
							<thead class="bg-200">
								<tr>
									<th class="text-900 sort text-center" data-sort="empId">사원번호</th>
									<th class="text-900 sort text-center" data-sort="empName">이름</th>
									<th class="text-900 sort text-center" data-sort="deptName">부서명</th>
									<th class="text-900 sort text-center" data-sort="ROLE">권한설정</th>
									<th class="text-900 sort text-center" data-sort="select">선택</th>
								</tr>
							</thead>
							<tbody class="list" id="listBody">
								<tr>
									<td class="empId text-center"></td>
									<td class="empName text-center"></td>
									<td class="deptName text-center"></td>
									<td class="ROLE text-center"></td>
									<td class="select text-center"></td>
								</tr>
							</tbody>
						</table>
					</div>
				 <ul class="pagination justify-content-center mt-3"></ul>
				</div>
			</div>
			<div class="modal-footer text-center">
				<button type="button" class="btn btn-primary"
					onClick="closeModal();" data-bs-dismiss="modal">확인</button>
			</div>
		</div>
	</div>
</div>
<!-- modal e -->
<form:form modelAttribute="registerProject" id="rgForm"
	action="${pageContext.request.contextPath }/project/register.do">
	<!-- Modal s -->

	<!-- register veiw -->
	<div class="view edit">
		<div class="view_inner">
			<div class="view-info">
				<strong class="view-tit d-flex align-items-center">
					<div class="me-4">
						<label for="" class="">프로젝트명</label>
					</div>
					<div class=" col-sm-11">
						<input type="text" class="form-control" name="proName"
							placeholder="프로젝트 명을 입력해주세요" value="${project.proName }">
						<form:errors path="proName" element="span" cssClass="text-danger" />
					</div>

				</strong>
				<ul class="ul clearfix">

					<li class="d-flex w-50  align-items-center mb-2">
						<span class="list-tit">담당자</span> 
						<span> 
							<input type="text"  class="form-control hasDatepicker" value="${realUser.empName }">
						</span>
					</li>
					<li class="d-flex w-50  align-items-center mb-2">
						<span class="list-tit">상태</span> 
						<span> 
							<select
							class="form-select form-control" name="proStId"
							aria-label="Default select example">
								<c:forEach items="${projectStateList}" var="ps">
									<option value="${ps.cmId }">${ps.cmName}</option>
								</c:forEach>
							</select>
							<span class="errorMsg"><form:errors path="proStId" element="span" cssClass="text-danger" /></span>
							
						</span>
					</li>
					
					<li class="d-flex w-50  align-items-center mb-2">
						<span class="list-tit">마감일</span> 
						<span class=" "
						aria-label="Default select example">
						<input
							class="form-control" type="datetime-local" name="proDdlineEx" />
						<span class="errorMsg">
							<form:errors path="proDdlineEx" element="span"
								cssClass="text-danger" />
						</span>
						</span>
					</li>
					
				</ul>
			</div>
			<div class="view_content" id="viewEdit">${project.proDesc }</div>
			<!-- 첨부파일 -->
			<!-- 첨부파일 -->

		</div>
		<input type="hidden" name="proDesc" id="proDesc"> <input
			type="hidden" name="empIds" id="empIds" value="${realUser.empId }">
		<input type="hidden" name="roleIds" id="roleIds">
	</div>
	<!-- modify veiw -->
</form:form>
<!-- button -->
<div class="btn-box clearfix mt-4">
	<a href="${pageContext.request.contextPath}/project"><button class="btn btn-secondary">목록</button></a>
	<div class="right float-end">
		<button id="autoBtn" class="btn btn-primary"
		>자동</button>
		<button class="btn btn-primary" data-bs-toggle="modal"
			data-bs-target="#insertModal">팀원 등록</button>
		<!-- <button class="btn btn-danger">취소</button> -->
		<input type="button" class="btn btn-primary" value="등록" id="regBtn">
	</div>
	${msg}
</div>

<!-- button -->
<script type="text/javascript">
	
</script>
<script type="text/javascript"
	src='<c:url value="/resources/js/common/ckeditor5/super/ckeditor.js"/>'></script>
<script type="text/javascript"
	src="<c:url value='/resources/js/common/datepicker/jquery-ui.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/resources/js/common/datepicker/lang/datepicker-ko.js'/>"></script>

<script>
$(document).ready(function(){
   let viewEdit = document.querySelector("#viewEdit");
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
            	$(regBtn).data("editor",newEditor)
            	$(autoBtn).on("click",function(){
            		let name=$(rgForm).find("input[name]")
            		name.each((i,v)=>{
            			console.log(i,v)
            			if($(v).attr("name")=="proName"){
            				$(v).val("미래를 위한 취업 준비 프로젝트")
            			}
            			if($(v).attr("name")=="proDesc"){
            				$(v).val(`<p style="text-align:center;"><span style="font-family:Georgia, serif;font-size:22px;"><strong>미래를 위한 취업 준비 프로젝트&nbsp;</strong></span></p><ul><li><p style="text-align:right;"><strong>진행기간 </strong>: 2024.04.02 ~ 2026.04.02</p></li><li><strong>담당자</strong> <strong>:</strong> 김태은</li><li><strong>분야 : </strong>자기개발&nbsp;</li><li><strong>목적 : </strong>미래 혁신적인 개발자가 되기 위한 프로젝트&nbsp;</li><li><strong>대상 : </strong>대덕인재개발원 학생</li></ul>`)
            				newEditor.setData(`<p style="text-align:center;"><span style="font-family:Georgia, serif;font-size:22px;"><strong>미래를 위한 취업 준비 프로젝트&nbsp;</strong></span></p><ul><li><p style="text-align:right;"><strong>진행기간 </strong>: 2024.04.02 ~ 2026.04.02</p></li><li><strong>담당자</strong> <strong>:</strong> 김태은</li><li><strong>분야 : </strong>자기개발&nbsp;</li><li><strong>목적 : </strong>미래 혁신적인 개발자가 되기 위한 프로젝트&nbsp;</li><li><strong>대상 : </strong>대덕인재개발원 학생</li></ul>`)
            			}
            		})
            	})
            });
});
</script>
<script
	src="${pageContext.request.contextPath }/resources/js/listjs/cstmrList.js"></script>