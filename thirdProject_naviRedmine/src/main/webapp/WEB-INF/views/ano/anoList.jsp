<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form"  prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags"  prefix="spring"%>
										
				<form id="searchForm">
					<input type="hidden" name="page"/>
					<input type="hidden" name="baordType" value="${paging.detailCondition.baordType }"/>
					<input type="hidden" name="word"  value="${paging.detailCondition.word }"/>
				</form>
<%-- 				<form id="registerForm" action="${pageContext.request.contextPath}/project/register.do" method="get"></form> --%>
				<div data-pg-role="searchUI" data-pg-target="#searchForm"
					class="searchBox d-flex justify-content-end">
					
					<select class="me-1" name="baordType" data-pg-init-value="${paging.detailCondition.baordType }">
							<option value>게시판 분류</option>
							<c:forEach items="${boardTypeList }" var="boardType">
								<option value="${boardType.cmId }">${boardType.cmName }</option>
							</c:forEach>
					</select>
					<div class="fieldset flex">
						<input class="me-1" type="text" name="word"
							data-pg-init-value="${paging.detailCondition.word }" title="검색어를 입력해주세요"
							value="${paging.detailCondition.word }"
							placeholder="검색어 입력" />
						<button type="button" class="btn btn-primary"
							data-pg-role="searchBtn">검색</button>
					</div>
				</div>
				<!-- ui : table s -->
				<table class="table text-center">
					<caption class="sr-only">프로젝트 목록 테이블입니다.</caption>

					<colgroup>
						
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: 10%;">
						<col style="width: auto;">
						<col style="width: 10%;">
						<col style="width: 10%;">

					</colgroup>

					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">게시판 번호</th>
							<th scope="col">게시판 분류</th>
							<th scope="col">제목</th>
							<th scope="col">등록일자</th>
							<th scope="col">조회수</th>
						</tr>
					</thead>
					<tbody>
				
						<!-- 1 -->
						<c:forEach items="${anoList }" var="ano">
						<tr>
							<th scope="row">${ano.rnum }</th>
							<td>${ano.bpId }</td>
							<td>
							<c:if test="${ano.bpNtcName  eq '공지'}">
								<span class="category emergency">${ano.bpNtcName }</span>
							</c:if> 
							<c:if test="${ano.bpNtcName  eq '서식'}">
								<span class="category ordinary">${ano.bpNtcName }</span>
							</c:if> 
							<c:if test="${ano.bpNtcName  eq '칭찬공간'}">
								<span class="category cate2">${ano.bpNtcName }</span>
							</c:if> 
							<c:if test="${ano.bpNtcName  eq '포토공간'}">
								<span class="category cate3">${ano.bpNtcName }</span>
							</c:if> 
							<c:if test="${ano.bpNtcName  eq 'QNA'}">
								<span class="category project">${ano.bpNtcName }</span>
							</c:if> 
							<c:if test="${ano.bpNtcName  eq '나눔공간'}">
								<span class="category share">${ano.bpNtcName }</span>
							</c:if> 
							
							</td>
							<td class="text-start"><a href="${pageContext.request.contextPath }/board/ano/${ano.bpId}" class="text-link d-flex new">

									<c:if test="${empty ano.nowCheck}">
										<span class="icon new_icon">
												<span class="sr-only">new</span>
											</span>
									</c:if>
									<em class="text-elipsis">${ano.bpTitle }</em>
								</a>
							</td>
							<td>${ano.bpRegDtStr }</td>
							<td>${ano.bpCnt }</td>
						</tr>
						</c:forEach>
						
						<!-- 1 -->
					</tbody>
				</table>
				<!-- ui : table e -->
				${pagingHTML }
										
<script src="<c:url value='/resources/js/common/paging.js'/>"></script>