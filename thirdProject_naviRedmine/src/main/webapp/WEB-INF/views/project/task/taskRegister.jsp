<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div class="modal fade flexibleModal" id="taskModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true"
	data-pro-id="${project.proId }">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header bg-primary text-white">
				<strong class="modal-title fs-5" id="exampleModalLabel">안내</strong>
				<button type="button" class="btn-close w me-1" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body" id="in" style="
        overflow: auto; /* 내용이 넘칠 경우 스크롤 생성 */
        ">
				<div id="taskList" data-list>
					<div class="row justify-content-end g-0">
						<div class="searchBox">
							<form id="submitForm1" action="${pageContext.request.contextPath }/task/add/task/${project.proId }" method="post">
								<div class="input-group">
									<input class="form-control form-control-sm shadow-none search"
										type="search" placeholder="Search..." aria-label="search" />
									<div class="input-group-text btn btn-secondary col-2">
										<span class="fa fa-search fs-10 text-600"></span>
									</div>
								</div>
							</form>
						</div>
					</div>
					<div class="table-responsive scrollbar scrollbar scrollY mt-4" >

						<table class="table table-bordered table-striped fs-10 mb-0 mt-4">
							<colgroup>
							<col style="width:15%">
							<col style="width:auto%">
							<col style="width:20%">
							<col style="width:10%">
							
						</colgroup>
							<thead class="bg-200">
								<tr class="bg-200">
									<th class="text-900 sort text-center" data-sort="taskId">일감번호</th>
									<th class="text-900 sort text-center" data-sort="taskName">제목</th>
									<th class="text-900 sort text-center" data-sort="taskManName">담당자</th>
									<th class="text-900 sort text-center" data-sort="btn">선택</th>
								</tr>
							</thead>
							<tbody class="list" id="listBody1">
								<tr>
									<td  class="taskId text-center"></td>
									<td class="taskName text-center"></td>
									<td class="taskManName text-center"></td>
									<td class="btn text-center"></td>
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
				<button type="submit" class="btn btn-secondary"
					data-bs-dismiss="modal">확인</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade info" id="insertModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true"
	data-pro-id="${project.proId }">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<strong class="modal-title fs-5" id="exampleModalLabel">안내</strong>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body" id="in">
				<div id="cstmrList" data-list>
					<div class="row justify-content-end g-0">
						<div class="col-auto col-sm-5 mb-3">
							<form id="submitForm" action="${pageContext.request.contextPath }/task/add" method="post">
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
									<th class="text-900 sort" data-sort="empId">사원번호</th>
									<th class="text-900 sort" data-sort="empName">이름</th>
									<th class="text-900 sort" data-sort="deptName">부서명</th>
									<th class="text-900 sort" data-sort="roleName">권한</th>
									<th class="text-900 sort" data-sort="select">선택</th>
								</tr>
							</thead>
							<tbody class="list" id="listBody">
								<tr>
									<td  class="empId"></td>
									<td class="empName"></td>
									<td class="deptName"></td>
									<td class="roleName"></td>
									<td class="select"></td>
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
				<button class="btn btn-secondary"
					data-bs-dismiss="modal">확인</button>
			</div>
		</div>
	</div>
</div>
<div class="btn-box clearfix mt-4">
	<div class="right float-end">
	<button class="btn btn-primary" data-bs-toggle="modal"
							data-bs-target="#taskModal">상위 일감 등록</button>
	<button class="btn btn-primary" data-bs-toggle="modal"
							data-bs-target="#insertModal">담당자 등록</button>
	</div>
</div>
<form:form id="insertForm" action="${pageContext.request.contextPath }/task/add/${project.proId }" modelAttribute="task" 
enctype="multipart/form-data"
>
	<input type="hidden" name="taskId" value="${task.taskId }">		
	<input type="hidden" name="taskTopId" id="taskTopId">
<div class="modal fade info" id="exampleModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<strong class="modal-title fs-5" id="exampleModalLabel">안내</strong>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body" id="insertResult">"일감을 등록하시겠습니까?"</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" id="insertBtn">확인</button>
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
						<form:input placeholder="제목을 입력해주세요" cssClass="form-control" path="taskTitle" value="${task.taskTitle }"/>
						<form:errors path="taskTitle" element="span" cssClass="text-danger" />
					</div>

				</strong>
				<ul class="ul clearfix">

					<li><span
						class="list-tit d-flex w-50  align-items-center mb-2">담당자</span> <span
						class=" col-sm-6" aria-label="Default select example">
							<input class="form-control bg-body" type="text" id="empName" readonly="readonly">
							<form:input type="hidden" cssClass="form-control" path="taskManId" value="${task.taskManId}"/>
							<form:errors path="taskManId" element="span" cssClass="text-danger" />
					</span>
						</li>
					<li><span class="list-tit">예상처리시간</span> <span
						class=" col-sm-6" aria-label="Default select example">
							<form:input type="number" path="taskEstTime" cssClass="form-control"  value="${task.taskEstTime }"/>
							<form:errors path="taskEstTime" element="span" cssClass="text-danger" />
					</span></li>
					<li><span class="list-tit">마감예정일</span> <span
						class=" col-sm-6" aria-label="Default select example"> 
						<input
						class="form-control" type="datetime-local" name="taskCompDt"
						value="${task.taskCompDt }">
						<form:errors path="taskCompDt" element="span" cssClass="text-danger" />
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
						<form:errors path="tpsId" element="span" cssClass="text-danger" />
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
						<form:errors path="tsId" element="span" cssClass="text-danger" />
					</span></li>
					<li><span
						class="list-tit d-flex w-50  align-items-center mb-2">상위일감</span> <span
						class=" col-sm-6" aria-label="Default select example">
							<span class="form-control" id="taskTop">상위일감 없음</span>
						
					</span>
						</li>

				</ul>
			</div>
			<div class="view_content" id="viewEdit">${task.taskCn }</div>
				<form:errors path="taskCn" element="span" cssClass="text-danger" />
			<!-- 첨부파일 -->
			<div class="content">
			<div class="inner html">
				<c:forEach items="${fileList }" var="f">
					<div class="addfile">
						<ul class="fileList">
							<li
								class="d-flex file-row align-items-center justify-content-between mb-2">
								<i data-id="${f.tfId}" class="icon close"><em
									class="sr-only">첨부파일삭제</em></i> <a
								href="${pageContext.request.contextPath }/project/issue/download/${f.tfId}"
								class="file_item d-flex align-items-center"> <c:choose>
										<c:when test="${empty f.tfGbId}">
											<em class="file_name">첨부된 파일이 없습니다.</em>
										</c:when>
										<c:otherwise>
											<c:if test="${f.tfGbId eq 'pdf' }">
												<i class="icon pdf"><em class="sr-only">${f.tfGbId }</em></i>
											</c:if>
											<c:if test="${f.tfGbId eq 'txt' }">
												<i class="icon txt"><em class="sr-only">${f.tfGbId }</em></i>
											</c:if>
											<c:if test="${f.tfGbId eq 'jpg'}">
												<i class="icon txt"><em class="sr-only">${f.tfGbId }</em></i>
											</c:if>
											<c:if test="${f.tfGbId eq 'png' }">
												<i class="icon txt"><em class="sr-only">${f.tfGbId }</em></i>
											</c:if>
											<c:if test="${f.tfGbId eq 'word' }">
												<i class="icon word"><em class="sr-only">${f.tfGbId }</em></i>
											</c:if>
											<c:if test="${f.tfGbId eq 'xlsx' }">
												<i class="icon xlsx"><em class="sr-only">${f.tfGbId }</em></i>
											</c:if>
											<c:if test="${f.tfGbId eq 'zip' }">
												<i class="icon zip"><em class="sr-only">${f.tfGbId }</em></i>
											</c:if>
											<c:if test="${f.tfGbId eq 'hwp' }">
												<i class="icon hangle"><em class="sr-only">${f.tfGbId }</em></i>
											</c:if>
											<c:if test="${f.tfGbId eq 'ppt' }">
												<i class="icon ppt"><em class="sr-only">${f.tfGbId }</em></i>
											</c:if>
											<c:if test="${f.tfGbId eq 'pptx' }">
												<i class="icon ppt"><em class="sr-only">${f.tfGbId }</em></i>
											</c:if>
										</c:otherwise>
									</c:choose> <span class=""> <em class="file_name">${f.tfOrgNm }</em></span>
							</a> <span class="file_size p-1 border border-dark-subtle fileSize">${f.taskFileSize }</span>
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
			<!-- 첨부파일 -->

		</div>
	</div>
	<input type="hidden" name='proId' value="${project.proId }"/> 
	<input type="hidden" name="taskCn" id="taskCn"> 
<!-- modify veiw -->
<!-- button -->
</form:form>
<div class="btn-box clearfix mt-4">
	<a href="${pageContext.request.contextPath }/task"><button
			class="btn btn-secondary">목록</button></a>
	<div class="right float-end">
	<button id="autoBtn" class="btn btn-primary"
		>자동</button>
		<input type="button" class="btn btn-primary" data-bs-toggle="modal"
			data-bs-target="#exampleModal" id="modalBtn"value="등록">
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
            	$(insertForm).data("taskModEitor",newEditor)
            	$(autoBtn).on("click",function(){
            		let name=$(insertForm).find("input[name]")
            		name.each((i,v)=>{
            			console.log(i,v)
            			if($(v).attr("name")=="taskTitle"){
            				$(v).val("단위업무 정의서 작성")
        				}
            			if($(v).attr("name")=="taskEstTime"){
            				$(v).val(2)
        				}
            			if($(v).attr("name")=="taskCn"){
            				let cn=`<p>서식에서 <span style="color:hsl(0,75%,60%);"><strong>[단위업무정의서 공통 서식]</strong></span> 다운로드 하고 기본적인 내용 작성</p><p>내용 작성 이후 <span style="color:hsl(0,75%,60%);"><strong>04.02</strong></span>일까지 회의 참석</p><p>&nbsp;</p>`;
	        				$(v).val(cn)
	    					newEditor.setData(cn)
        				}
            		})
            	})
			});
})

</script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/list.js/1.0.2/list.min.js"
	integrity="sha512-MT5YyrGWqMGkIbwkVUZEWGrRDjlNx8loukEdFyzLo4s8INKVxnDQy2eFcpmnWGrFwJ+X8mRTQOJpWCayXz7+Og=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script
	src="${pageContext.request.contextPath }/resources/js/listjs/taskReg.js"></script>