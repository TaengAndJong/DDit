<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!-- project veiw -->
<div class="view task">
	<div class="view_inner">
		<div class="view-info">
			<strong class="view-tit"> <span class="category project">${ano.bpId }</span>
				<em>${ano.bpTitle}</em></strong>
			<ul class="ul clearfix">

				<li><span class="list-tit">작성자</span> <span>관리자
				<li><span class="list-tit">등록일</span> <span>${ano.bpRegDtStr }</span></li>
				<li><span class="list-tit">게시판 분류</span> <span>${ano.bpNtcName }</span></li>
				<li>
				<span class="list-tit">수정일</span>
				<span>
					<c:if test="${empty ano.bpModDt }">수정내역 없음</c:if>
					<c:if test="${not empty ano.bpModDtStr }">${ano.bpModDtStr }</c:if>
				</span>
				
				</li>
				<li>
					<span class="list-tit">조회수</span>
					<span>${ano.bpCnt }</span>
				</li>
			</ul>
		</div>
		<div class="view_content">
			${ano.bpCn }
		</div>
	</div>

</div>
<!-- project veiw -->
<!-- button -->
<div class="btn-box clearfix mt-4">
	<a href="${pageContext.request.contextPath }/board/ano"><button class="btn btn-secondary">목록</button></a>
</div>
<!-- button -->


