	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>
<style>
#myProgress {
  width: 100%;
  background-color: grey;
}

#myBar {
  width: 1%;
  height: 30px;
  background-color: #5346db;
  text-align: center; /* To center it horizontally (if you want) */
  line-height: 30px; /* To center it vertically */
  color: white;
}
</style>
<div class="info_box red mb-5">
<strong><i class="info"></i>전체 프로젝트 현황</strong>
	<ul class="ul bullet  mt-3 mb-5">
		<li class="li indent mb-2">
			<span class="category cate3">안정</span> <span class="mx-2">${projectTo.PS0002 }</span> 
			<span class="category emergency">긴급</span> <span class="mx-2">${projectTo.PS0003 }</span> 
			<span class="category new">신규</span> <span class="mx-2">${projectTo.PS0001 }</span> 
		</li>
	</ul>
	<strong class="h4 GmarketSans bold mb-0 ">전체 프로젝트 평균 진행률</strong>
	<div id="myProgress"class="mt-3">
	 	 <div id="myBar">1%</div>
	</div>
</div>
<form id="searchForm">
	<input type="hidden" name="page" /> <input type="hidden"
		name="projectState" value="${paging.detailCondition.projectState }" />
	<input type="hidden" name="project"
		value="${paging.detailCondition.project }" /> <input type="hidden"
		name="ing" value="${paging.detailCondition.ing }" />
</form>
<% String f=""; %>
<c:if test="${realUser.roleId eq 'ROLE_EMP'}">
<% f="justify-content-end"; %>
</c:if>
<div data-pg-role="searchUI" data-pg-target="#searchForm"
	class="searchBox d-flex <%=f%>">

	<form id="registerForm" class="me-auto"
		action="${pageContext.request.contextPath}/project/register.do"
		method="get">
		<c:if test="${realUser.roleId eq 'ROLE_PRO_CREATE'}">
			<button class="btn btn-primary " id="registerBtn">프로젝트 등록</button>
		</c:if>
	</form>
	<select class="me-1" name="projectState"
		data-pg-init-value="${paging.detailCondition.projectState }">
		<option value>분류선택</option>
		<c:forEach items="${projectStateList }" var="prost">
			<option value="${prost.cmId }">${prost.cmName }</option>
		</c:forEach>
	</select> <input type="hidden" name="ing "
		data-pg-init-value="${paging.detailCondition.ing }"
		value="${paging.detailCondition.ing }" />
	<div class="fieldset flex">
		<input class="me-1" type="text" name="project"
			data-pg-init-value="${paging.detailCondition.project }"
			title="검색어를 입력해주세요" value="${paging.detailCondition.project }"
			placeholder="프로젝트 검색" />
		<button type="button" class="btn btn-primary" data-pg-role="searchBtn">검색</button>
	</div>

</div>
<table class="table text-center">
	<caption class="sr-only">프로젝트 목록 테이블입니다.</caption>

	<colgroup>
		<col style="width: 10%;">
		<col style="width: 10%;">
		<col style="width: auto;">
		<col style="width: 10%;">
		<col style="width: 10%;">
		<col style="width: 10%;">


	</colgroup>

	<thead>
		<tr>
			<th scope="col">프로젝트ID</th>
			<th scope="col">프로젝트 상태</th>
			<th scope="col">프로젝트명</th>
			<th scope="col">담당자</th>
			<th scope="col">마감일</th>
			<th scope="col">위키이동</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${not empty projectList }">
			<c:forEach items="${projectList }" var="projects">

				<tr>
					<td> ${projects.proId }</td>
					<td><c:if test="${projects.proStId eq 'PS0002'}">
							<span class="category cate3">안정</span>
						</c:if> <c:if test="${projects.proStId eq 'PS0003'}">
							<span class="category emergency">긴급</span>
						</c:if> <c:if test="${projects.proStId  eq 'PS0001'}">
							<span class="category new">신규</span>
						</c:if></td>

					<td class="text-start">
						<!-- 새글일 때 new 클래스 추가 --> <a
						href="${pageContext.request.contextPath}/project/dashboard/${projects.proId}"
						class="text-link d-flex new"> <!-- icon new_icon 추가 --> <c:if
								test="${projects.proStId eq 'PS0001' }">
								<span class="icon new_icon"> <span class="sr-only">new</span>
								</span>
							</c:if> <span><c:if test="${not empty projects.myProject}"><strong style="color:#5346db;">[참여]</strong></c:if>${projects.proName }</span>
					</a>
					</td>
					
					<td>${projects.empName}</td>
					<td>${projects.proDdlineExStr}</td>
					<c:if test="${empty projects.wikiId }">
						<td><a
							href="${pageContext.request.contextPath}/wiki/add/${projects.proId}"><button
									type="button" class="btn btn-primary">위키등록</button></a></td>
					</c:if>
					<c:if test="${not empty projects.wikiId }">
						<td><button type="button" class="btn btn-secondary" disabled>위키등록</button></td>
					</c:if>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty projectList }">
			<tr>
				<td colspan="6" class="text-center">데이터가 없습니다.</td>
			</tr>
		</c:if>

	</tbody>

</table>
<script>
var i = 0;
move();
//프로젝트 진행률 스크립트
function move() {
  if (i == 0) {
    i = 1;
    var elem = document.getElementById("myBar");
    var width = 10;
    var id = setInterval(frame, 10);	//올라가는 시간 지연 용도
    function frame() {
      if (width >= ${projectTo.projectTotalIng}) {
        clearInterval(id);
        i = 0;
      } else {
        width++;
        elem.style.width = width + "%";
        elem.innerHTML = width + "%";
      }
    }
  }
}
</script>

${pagingHTML }
<script src="<c:url value='/resources/js/common/paging.js'/>"></script>
<script src="<c:url value='/resources/project/js/project.js'/>"></script>
