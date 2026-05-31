<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<link rel="stylesheet"
	href='<c:url value="/resources/css/todayList/todayList.css"/>'>
<div class="info_box red">
	<strong><i class="info"></i>사용안내</strong>
	<ul class="ul bullet mt-3">
		<li class="li mb-1">당일 작업을 진행할 프로젝트의 일감만 등록해주세요.</li>
		<li class="li mb-3">작업이 진행되지 못할 경우, 미진행 또는 대기로 작업상태를 설정해주세요.</li>
		<li class="li indent mb-2"><span class="">- 일정 등록</span>
			<ul class="ul">
				<li class="li">추가로 작업할 일감을 조회 후 선택해 가져 온 후 , 완료버튼을 눌러 반영해주세요.</li>
			</ul></li>
		<li class="li indent"><span class="">- 작업시간 및 기타 설정</span>
			<ul class="ul">
				<li class="li">작업시간 및 기타 내용 입력 후, 완료버튼을 눌러 반영해주세요.</li>
			</ul></li>
	</ul>


</div>


<div class="toDo_list mt-5">

	<div class="todo_content clearfix">
		<div class="todo_title float-start mt-2">
			<i class="icon date"></i> <span class="date-text GmarketSans fw-bold">${now } ${week }
				</span>
		</div>
		<div class="btn-box clearfix">
			<div class="right float-end">
				<button type="button" class="btn btn-primary me-2"
					data-bs-toggle="modal" data-bs-target="#todoListModal">조회</button>
				<button class="btn btn-danger  me-2" id="delBtn">삭제</button>
				<button class="btn btn-custom" id="completeBtn">완료</button>
			</div>
		</div>



		<!-- ui : todoListModal s -->
		<div class="modal fade todolistModal" id="todoListModal" tabindex="-1"
			aria-labelledby="todoListModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg" id="asynBody" data-list>
				<div class="modal-content">
					<div class="modal-header bg-primary text-white">
						<strong class="modal-title" id="todoListModalLabel">일감조회</strong>
					</div>
					<div class="modal-body">
						<!-- search -->
						<%--체크박스 클릭 시 모달 데이터 전송 폼 --%>
						<form:form id="checkboxForm"
							action="${pageContext.request.contextPath}/todaylist"
							method="POST" enctype="application/x-www-form-urlencoded">
						</form:form>
						<%--체크박스 클릭 시 데이터 전송 폼 --%>
						<div data-pg-role="searchUI" data-pg-target="#submitForm"
							class="searchBox d-flex justify-content-end">

							<%-- 일감제목 일감번호 에 대한 키워드로 검색 // 구조때문에 text쪽 파라미터를 못가져 왔음--%>
							<input class="me-1 search fuzzy-search" type="text" name="word"
								title="일감ID,프로젝트명,일감명 검색" placeholder="일감ID,프로젝트명,일감명 검색" />
							<button type="button" class="btn btn-primary" id="searchBtn">검색</button>


						</div>
						<!-- search -->

						<!-- table -->
						<div class="tdList-Modal_table scrollY">
							<table class="table text-center" id="modalTable">
								<caption class="sr-only">일감 목록 테이블입니다.</caption>

								<colgroup>
									<col style="width: 5%">
									<col style="width: 5%;">
									<col style="width: 8%;">
									<col style="width: 5%;">
									<col style="width: auto;">
									<col style="width: 8%;">
									<col style="width: 8%;">
									<col style="width: 8%;">
									<col style="width: 10%;">
								</colgroup>

								<thead>
									<tr>
										<th><input type="checkbox" class="checkAll"></th>
										<th scope="col">번호</th>
										<th scope="col">일감ID</th>
										<th scope="col">상태</th>
										<th scope="col">제목</th>
										<th scope="col">담당자</th>
										<th scope="col">진행상태</th>
										<th scope="col">진행률</th>
										<th scope="col" data-default-order='desc'>등록일</th>
									</tr>
								</thead>
								<tbody class="list" id="listBody">
									<tr class="tr">
										<td class="check"></td>
										<td class="rnum"></td>
										<td class="taskId"></td>
										<td class="tsNameCon"></td>
										<td class="text-start taskTitle"></td>
										<td class="empName"></td>
										<td class="tpsName"></td>
										<td class="tpsIng"></td>
										<td class="taskRegDtStr"></td>
									</tr>



								</tbody>

							</table>

							<!-- pagination   -->
							<ul class="pagination justify-content-center align-items-center"></ul>
							<!-- pagination   -->

						</div>
						<!-- anybody -->
					</div>
					<div class="modal-footer justify-content-center">
						<button type="button" class="btn btn-light btn-outline-secondary"
							data-bs-dismiss="modal">닫기</button>
						<button type="button" class="btn btn-primary" id="addTaskBtn">추가</button>
					</div>
				</div>
			</div>
		</div>
		<!-- modal e -->
		<!-- ui : todoListModal e -->

		<form id="checkboxForm2" action="" method="POST">
			<%-- <c:forEach items="${taskList }" var="taskList">
         					<input type="text" name="${taskList.taskId }" value="${taskList.taskId }">
         				</c:forEach> --%>
		</form>
		<!-- ui : table s -->
		<table class="table text-center mt-4" id="todaylistTable">
			<caption class="sr-only">일감목록 테이블입니다.</caption>
			<colgroup>
				<col style="width: 5%">
				<col style="width: 8%;">
				<col style="width: 10%;">
				<col style="width: 10%;">
				<col style="width: auto;">
				<col style="width: 10%;">
				<col style="width: 10%;">
				<col style="width: 10%;">
				<col style="width: 10%;">
			</colgroup>

			<thead>
				<tr>
					<th><input type="checkbox" class="checkAll" title=""></th>
					<th scope="col">번호</th>
					<th scope="col">일감ID</th>
					<th scope="col">상태</th>
					<th scope="col">제목</th>
					<th scope="col">마감일</th>
					<th scope="col">예상시간</th>
					<th scope="col">소요시간</th>
					<th scope="col">작업상태</th>
				</tr>
			</thead>
			<tbody id="todaylist-tbody">
				<!-- 일반 -->
				<c:if test="${empty todayList }">
                           	 데이터없음
                              <tr>
						<td colspan="9">오늘의 일정을 등록해주세요.</td>
					</tr>
                              데이터없음
                        </c:if>
				<c:if test="${not empty todayList }" var="todaylst">
					<c:forEach items="${todayList }" var="td">
						<form>
							<tr>

								<th><input type="checkbox" name="${td.taskId }"> <input
									type="hidden" name="taskId" value="${td.taskId }"></th>
								<th scope="row">${td.tlIdx }</th>
								<th scope="row">${td.taskId }</th>

								<td><c:if test="${td.task.taskStatus.tsName eq '일반'}">
										<span class="category ordinary">${td.task.taskStatus.tsName }</span>
									</c:if> <c:if test="${td.task.taskStatus.tsName eq '긴급'}">
										<span class="category emergency">${td.task.taskStatus.tsName }</span>
									</c:if> <c:if test="${td.task.taskStatus.tsName eq '신규'}">
										<span class="category new">${td.task.taskStatus.tsName }</span>
									</c:if></td>
								<td class="text-start">
									<!-- 새글일 때 new 클래스 추가 --> <a
									href="${pageContext.request.contextPath}/project/task/${td.task.proId}/${td.taskId}"
									title="[${item.proId}]${item.taskTitle} 상세페이지로 이동"> <!-- icon new_icon 추가 -->
										<em class="text-elipsis"><span class="fw-bold">[${td.task.proId}]</span>
											${td.task.taskTitle }</em>
								</a>
								</td>
								<td>${td.task.taskCompDtStr }</td>
								<td><input type="text" class="form-control min-auto"
									placeholder="예상시간" name="taskEstTime"
									value="${td.task.taskEstTime }"></td>
								<td><input type="text" class="form-control min-auto"
									placeholder="소요시간" name="taskRqrd" value="${td.task.taskRqrd }"></td>
								<td>
									<div class="input">
										<select class="form-select"
											aria-label="Default select example" title="작업상태선택"
											name="tpsId">
											<c:forEach items="${taskProcessStatusList}" var="tps">
												<c:choose>
													<c:when
														test="${tps.tpsId eq td.task.taskProcessStatus.tpsId}">
														<option value="${tps.tpsId}" selected>${tps.tpsIng}</option>
													</c:when>
													<c:otherwise>
														<option value="${tps.tpsId }">${tps.tpsIng}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select>
									</div>
								</td>
							</tr>
							
						</form>
					</c:forEach>
					<!-- 일반 -->
				</c:if>



			</tbody>

		</table>

		<!-- ui : table e -->

	</div>

</div>
<script src="<c:url value='/resources/js/common/listJs/list.min.js'/>"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/list.pagination.js/0.1.1/list.pagination.min.js"></script>
<script src="<c:url value='/resources/js/todayList/tdList.js'/>"></script>
