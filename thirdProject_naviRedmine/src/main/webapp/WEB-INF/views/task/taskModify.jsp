<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div class="modal fade info" id="insertModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true"
	data-pro-id="${task.proId }">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<strong class="modal-title fs-5" id="exampleModalLabel">안내</strong>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body" id="updateResult">
				<div id="cstmrList" data-list>
					<div class="row justify-content-end g-0">
						<div class="col-auto col-sm-5 mb-3">
							<form id="submitForm" action="${pageContext.request.contextPath }/task/mod/${task.taskId }" method="post">
								<div class="input-group">
									<input class="form-control form-control-sm shadow-none search"
										type="search" placeholder="Search..." aria-label="search" />
									<div class="input-group-text bg-transparent">
										<span class="fa fa-search fs-10 text-600"></span>
									</div>
								</div>
							</form>
						</div>
					</div>
					<div class="table-responsive scrollbar">

						<table class="table table-bordered table-striped fs-10 mb-0">
							<thead class="bg-200">
								<tr>
									<th class="text-900 sort" data-sort="check">체크박스</th>
									<th class="text-900 sort" data-sort="empId">사원번호</th>
									<th class="text-900 sort" data-sort="empName">이름</th>
									<th class="text-900 sort" data-sort="deptName">부서명</th>
									<th class="text-900 sort" data-sort="roleName">권한</th>
								</tr>
							</thead>
							<tbody class="list" id="listBody">
								<tr>
									<td onclick="select(this);" class="empId"></td>
									<td class="empName"></td>
									<td class="deptName"></td>
									<td class="roleName"></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="d-flex justify-content-center mt-3">
						<button class="btn btn-sm btn-falcon-default me-1" type="button"
							title="Previous" data-list-pagination="prev">
							<span class="fas fa-chevron-left"></span>
						</button>
						<ul class="pagination mb-0"></ul>
						<button class="btn btn-sm btn-falcon-default ms-1" type="button"
							title="Next" data-list-pagination="next">
							<span class="fas fa-chevron-right"> </span>
						</button>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">닫기</button>
				<button type="submit" class="btn btn-primary" id="">확인</button>
			</div>
		</div>
	</div>
</div>
<form id="modifyForm" action="${pageContext.request.contextPath }/task/mod">
	<input type="hidden"name="taskId" value="${task.taskId }">		
	<input type="hidden"name="taskTitle" value="${task.taskTitle }">		
	<input type="hidden"name="taskManId" value="${task.taskManEmp.empId }">
</form>
<div class="modal fade info" id="exampleModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<strong class="modal-title fs-5" id="exampleModalLabel">안내</strong>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body" id="updateResult">"일감을를 수정하시겠습니까?"</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" id="modifyBtn">확인</button>
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
						<label for="" class="">일감명</label>
					</div>
					<div class=" col-sm-11">
						<input type="text" class="form-control" name="taskTitle"
							placeholder="프로잭트 명을 입력해주세요" value="${task.taskTitle }">
					</div>

				</strong>
				<ul class="ul clearfix">

					<li><span
						class="list-tit d-flex w-50  align-items-center mb-2">담당자</span> <span
						class=" col-sm-6" aria-label="Default select example">
							<div class="form-control" id="empName">${task.taskManEmp.empName }</div>
					</span>
						<button class="btn btn-primary" data-bs-toggle="modal"
							data-bs-target="#insertModal">사원조회</button></li>
					<li><span class="list-tit">예상처리시간</span> <span
						class=" col-sm-6" aria-label="Default select example">
							<input type="number" name="taskEstTime" class="form-control" value="${task.taskEstTime }">
					</span></li>
					<li><span class="list-tit">등록일</span> <span class=" col-sm-6"
						aria-label="Default select example"> <span
							class="form-control">${task.taskRegDtStr }</span>
					</span></li>
					<li><span class="list-tit">마감예정일</span> <span
						class=" col-sm-6" aria-label="Default select example"> <input
							class="form-control" type="datetime-local" name="taskCompDt"
							value="${task.taskCompDt }">
					</span></li>
					<li><span class="list-tit">진행률</span> <span> <select
							class="form-select" name="tpsId"
							aria-label="Default select example">
								<c:forEach items="${taskProcessStatusList}" var="tps">
								<c:choose>
						            <c:when test="${tps.tpsId eq task.tpsId}">
						                <option value="${tps.tpsId}" selected>${tps.tpsIng}</option>
						            </c:when>
						            <c:otherwise>
						                <option value="${tps.tpsId }">${tps.tpsIng}</option>
						            </c:otherwise>
						        </c:choose>
								</c:forEach>
						</select>
					</span></li>
					<li><span class="list-tit">일감상태</span> <span> <select
							class="form-select" name="tsId"
							aria-label="Default select example">
								<c:forEach items="${taskStatusList}" var="ts">
									<c:choose>
						            <c:when test="${ts.tsId eq task.tsId}">
						                <option value="${ts.tsId}" selected>${ts.tsName}</option>
						            </c:when>
						            <c:otherwise>
						                <option value="${ts.tsId }">${ts.tsName}</option>
						            </c:otherwise>
						        </c:choose>
								</c:forEach>
						</select>
					</span></li>

					<li><span class="list-tit">현재진행률</span><span>${task.taskProcessStatus.tpsIng }</span></li>
				</ul>
			</div>
			<div class="view_content" id="viewEdit">${task.taskCn }</div>
			<!-- 첨부파일 -->
			<!-- 첨부파일 -->

		</div>
	</div>
	<input type="hidden" name='proId' value="${project.proId }"> <input
		type="hidden" name="proDesc" id="proDesc"> 
<!-- modify veiw -->
<!-- button -->
<div class="btn-box clearfix mt-4">
	<a href="${pageContext.request.contextPath }/task"><button
			class="btn btn-secondary">목록</button></a>
	<div class="right float-end">
		<input type="button" class="btn btn-primary" data-bs-toggle="modal"
			data-bs-target="#exampleModal" id="modalBtn"value="수정">
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
            	$(modifyForm).data("taskModEitor",newEditor)
			});
	 $(modifyForm).on("submit",function(e){
			e.preventDefault();
			$(proDesc).val(editor.getData())
			console.log($(proDesc).val())
		})
	 
	 
})

</script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/list.js/1.0.2/list.min.js"
	integrity="sha512-MT5YyrGWqMGkIbwkVUZEWGrRDjlNx8loukEdFyzLo4s8INKVxnDQy2eFcpmnWGrFwJ+X8mRTQOJpWCayXz7+Og=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script
	src="${pageContext.request.contextPath }/resources/js/cstmrList.js"></script>