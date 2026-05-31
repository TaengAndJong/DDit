<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!-- form  -->
<form id="searchForm">
	<input type="hidden" name="page" /> 
	<input type="hidden" name="state" value="${paging.detailCondition.state }" />
	<input type="hidden" name="brdId" value="${paging.detailCondition.brdId }" />
	<input type="hidden" name="bpTitle" value="${paging.detailCondition.bpTitle }" />
</form>
<!-- form  -->

<!-- searchBar -->
<div data-pg-role="searchUI" data-pg-target="#searchForm" class="searchBox d-flex justify-content-end">
	<!-- 입력용도 UI  -->
	<select class="me-1" name="state" data-pg-init-value="${paging.detailCondition.state}">
		<option value="" ${empty paging.detailCondition.state ? 'selected' : ''}>전체</option>
		<option value="ing" ${paging.detailCondition.state == 'ing' ? 'selected' : ''}>진행중</option>
		<option value="end" ${paging.detailCondition.state == 'end' ? 'selected' : ''}>삭제</option>
	</select> 
	
	<select class="me-1" name="brdId" data-pg-init-value="${paging.detailCondition.brdId }">
		<option value>분류선택</option>
		<c:forEach items="${boardTypeList }" var="brd">
			<option value="${brd.cmId }">${brd.cmName }</option>
		</c:forEach>
	</select>

	<div class="fieldset flex">
		<input class="me-1" type="text" name="bpTitle" data-pg-init-value="${paging.detailCondition.bpTitle }" placeholder=" 제목" />
		<button type="button" class="btn btn-primary" data-pg-role="searchBtn">검색</button>
	</div>
</div>
<!-- searchBar -->

<!-- ui : table s -->
<table class="table text-center">
	<caption class="sr-only"> 내 커뮤니티 목록</caption>
	<c:choose>
		<c:when test="${empty paging.detailCondition.brdId or paging.detailCondition.brdId eq 'BN0005' or paging.detailCondition.brdId eq 'BN0006'}">
		<!-- 상태표시하는 테이블 -->
				<colgroup>
					<col style="width: 5%">
					<c:if test="${empty paging.detailCondition.brdId}">
						<col style="width: 8%">
					</c:if>
					<col style="width: 10%">
					<col style="width: auto">
					<col style="width: 10%">
					<col style="width: 5%;">
<%-- 					<c:if test="${paging.detailCondition.state != 'ing'}"> --%>
<%-- 						<col style="width: 10%;"> --%>
<%-- 					</c:if> --%>
				</colgroup>
	
				<thead>
					<tr>
						<th scope="col">번호</th>
						<c:if test="${empty paging.detailCondition.brdId}">
							<th scope="col">게시판명</th>
						</c:if>
						<th scope="col">상태</th>
						<th scope="col">제목</th>
						<th scope="col">작성일</th>
						<th scope="col">조회수</th>
<%-- 						<c:if test="${paging.detailCondition.state != 'ing'}"> --%>
<!-- 							<th scope="col">삭제일</th> -->
<%-- 						</c:if> --%>
					</tr>
				</thead>
<%-- 	${boardList } --%>
				<tbody>
					<c:if test="${not empty boardList }">
						<c:forEach items="${boardList }" var="brdlist">
							<tr>
								<td>${brdlist.rnum }</td>
								<c:if test="${empty paging.detailCondition.brdId}">
									<td>
									<c:if test="${brdlist.cmName  eq '공지'}">
										<span class="category emergency">${brdlist.cmName }</span>
									</c:if> 
									<c:if test="${brdlist.cmName  eq '서식'}">
										<span class="category ordinary">${brdlist.cmName }</span>
									</c:if> 
									<c:if test="${brdlist.cmName  eq '칭찬공간'}">
										<span class="category cate2">${brdlist.cmName }</span>
									</c:if> 
									<c:if test="${brdlist.cmName  eq '포토공간'}">
										<span class="category cate3">${brdlist.cmName}</span>
									</c:if> 
									<c:if test="${brdlist.cmName  eq 'QNA'}">
										<span class="category project">${brdlist.cmName }</span>
									</c:if> 
									<c:if test="${brdlist.cmName  eq '나눔공간'}">
										<span class="category share">${brdlist.cmName }</span>
									</c:if> 
									</td>
								</c:if>
								
								<%-- <c:if test="${empty paging.detailCondition.brdId}">
									<td>${brdlist.cmName}</td>
								</c:if> --%>
								<!-- 상태표시 -->
								<td><c:choose>
										<c:when test="${empty brdlist.bpQnaAs and brdlist.cmName eq 'QNA'}">
											<!-- bpQnaAs 값이 null인 경우 -->
											<span class="category disable">미답변</span>
										</c:when>
										<c:when test="${not empty brdlist.bpQnaAs and brdlist.cmName eq 'QNA'}">
											<!-- bpQnaAs 값이 not null인 경우 -->
											<span class="category share">답변완료</span>
										</c:when>
										<c:when test="${empty brdlist.bpShrYn and brdlist.cmName eq '나눔공간'}">
											<!-- bpShrYn 값이 null인 경우 -->
											<!-- 아무것도 표시 안 함 -->
										</c:when>
										<c:when test="${brdlist.bpShrYn eq 'Y' and brdlist.cmName eq '나눔공간'}">
											<!-- bpShrYn 값이 'Y'인 경우 -->
											<span class="category emergency">나눔가능</span>
										</c:when>
										<c:when test="${brdlist.bpShrYn eq 'N' and brdlist.cmName eq '나눔공간'}">
											<!-- bpShrYn 값이 'Y'인 경우 -->
											<span class="category disable">나눔완료</span>
										</c:when>
									</c:choose></td>
								<!-- 상태표시 -->
								<td class="text-start">
									<!-- 새글일 때 new 클래스 추가 -->
									<a href="${pageContext.request.contextPath }/board/${brdlist.cmAtt1 }/${brdlist.bpId}" class="text-link d-flex new">
									<!-- icon new_icon 추가 -->
									<span class="icon new_icon"><span class="sr-only">new</span></span>
									<em class="text-elipsis">${brdlist.bpTitle}</em>
									</a>
								</td>
								<td>${brdlist.bpRegDtStr }</td>
								<td>${brdlist.bpCnt }</td>
<%-- 								<c:if test="${paging.detailCondition.state != 'ing'}"> --%>
<%-- 									<td>${brdlist.bpDelDtStr }</td> --%>
<%-- 								</c:if> --%>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty boardList }">
						<tr>
							<td colspan="7" class="text-center">게시글이 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
		</c:when>
		<c:otherwise>
		<!-- 상태 없는 테이블 -->
				<colgroup>
					<col style="width: 8%">
					<c:if test="${empty paging.detailCondition.brdId}">
						<col style="width: 10%">
					</c:if>
					<col style="width: auto">
					<col style="width: 10%">
					<col style="width: 8%;">
<%-- 					<c:if test="${paging.detailCondition.state != 'ing'}"> --%>
<%-- 						<col style="width: 10%;"> --%>
<%-- 					</c:if> --%>
				</colgroup>
	
				<thead>
					<tr>
						<th scope="col">번호</th>
						<c:if test="${empty paging.detailCondition.brdId}">
							<th scope="col">게시판명</th>
						</c:if>
						<th scope="col">제목</th>
						<th scope="col">작성일</th>
						<th scope="col">조회수</th>
<%-- 						<c:if test="${paging.detailCondition.state != 'ing'}"> --%>
<!-- 							<th scope="col">삭제일</th> -->
<%-- 						</c:if> --%>
					</tr>
				</thead>
	
				<tbody>
					<c:if test="${not empty boardList }">
						<c:forEach items="${boardList }" var="brdlist">
							<tr>
								<td>${brdlist.rnum }</td>
								<c:if test="${empty paging.detailCondition.brdId}">
									<td>${brdlist.cmName}</td>
								</c:if>
								<td class="text-start">
									<!-- 새글일 때 new 클래스 추가 -->
									<a href="${pageContext.request.contextPath }/board/${brdlist.cmAtt1 }/${brdlist.bpId}" class="text-link d-flex new">
									<!-- icon new_icon 추가 -->
									<span class="icon new_icon"><span class="sr-only">new</span></span>
									<em class="text-elipsis">${brdlist.bpTitle}</em></a>
								</td>
								<td>${brdlist.bpRegDtStr }</td>
								<td>${brdlist.bpCnt }</td>
								<c:if test="${paging.detailCondition.state != 'ing'}">
									<td>${brdlist.bpDelDtStr }</td>
								</c:if>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty boardList }">
						<tr>
							<td colspan="6" class="text-center">게시글이 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
	    </c:otherwise>
	</c:choose>
</table>
${pagingHTML }
<script src="<c:url value='/resources/js/common/paging.js'/>"></script>