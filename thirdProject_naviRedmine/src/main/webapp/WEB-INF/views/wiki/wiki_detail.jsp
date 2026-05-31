<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

    
<!-- project veiw -->
						<div class="view task">
							<div class="view_inner">
								<div class="view-info">
									<strong class="view-tit">
										<span class="category project">${wiki.proId }</span>
										<em>${wiki.wikiTitle }</em></strong>
									<ul class="ul clearfix">
										<li><span class="list-tit">프로젝트명</span>
											<span>${wiki.proName }</span></li>
										<li><span class="list-tit">담당자</span>
											<span>${wiki.empName }</span></li>
										<li><span class="list-tit">등록일자</span>
											<span>${wiki.proRegDtStr }</span></li>
										<li><span class="list-tit">마감일자</span>
											<span>${wiki.proDdlineExStr }</span></li>
										<li><span class="list-tit">위키수정일자</span>
											<span>
											<c:if test="${empty wiki.wikiModDtStr}">수정내역 없음</c:if>
											<c:if test="${not empty wiki.wikiModDtStr}">${wiki.wikiModDtStr }</c:if>
											</span>
										</li>
										<li><span class="list-tit">상태</span>
											<span>${wiki.cmName }</span></li>
									</ul>
								</div>
								<div class="view_content">
								${wiki.wikiCn }
								</div>
							</div>
						</div>
						<!-- project veiw -->
						
						<!-- 첨부파일 -->
<div class="content">
	<div class="inner html">
		<strong class="d-flex align-items-center mb-3"> <i class=""></i>첨부파일
		</strong>
		<c:if test="${empty fileList}">
			<em class="file_name">첨부된 파일이 없습니다.</em>
		</c:if>
		<c:forEach items="${fileList }" var="f">
			<div class="addfile">
				<ul class="fileList">
					<li	class="d-flex file-row align-items-center justify-content-between mb-2">
						<a href="${pageContext.request.contextPath }/wiki/download/${f.wfId}"
						class="file_item d-flex align-items-center"> 
						<c:choose>
								<c:when test="${empty f.wkFileGbId}">
									<em class="file_name">첨부된 파일이 없습니다.</em>
								</c:when>
								<c:otherwise>
									<c:if test="${f.wkFileGbId eq 'pdf' }">
										<i class="icon pdf"><em class="sr-only">${f.wkFileGbId }</em></i>
									</c:if>
									<c:if test="${f.wkFileGbId eq 'txt' }">
										<i class="icon txt"><em class="sr-only">${f.wkFileGbId }</em></i>
									</c:if>
									<c:if test="${f.wkFileGbId eq 'jpg'}">
										<i class="icon txt"><em class="sr-only">${f.wkFileGbId }</em></i>
									</c:if>
									<c:if test="${f.wkFileGbId eq 'png' }">
										<i class="icon txt"><em class="sr-only">${f.wkFileGbId }</em></i>
									</c:if>
									<c:if test="${f.wkFileGbId eq 'word' }">
										<i class="icon word"><em class="sr-only">${f.wkFileGbId }</em></i>
									</c:if>
									<c:if test="${f.wkFileGbId eq 'xlsx' }">
										<i class="icon xlsx"><em class="sr-only">${f.wkFileGbId }</em></i>
									</c:if>
									<c:if test="${f.wkFileGbId eq 'zip' }">
										<i class="icon zip"><em class="sr-only">${f.wkFileGbId }</em></i>
									</c:if>
									<c:if test="${f.wkFileGbId eq 'hwp' }">
										<i class="icon hangle"><em class="sr-only">${f.wkFileGbId }</em></i>
									</c:if>
									<c:if test="${f.wkFileGbId eq 'ppt' }">
										<i class="icon ppt"><em class="sr-only">${f.wkFileGbId }</em></i>
									</c:if>
									<c:if test="${f.wkFileGbId eq 'pptx' }">
										<i class="icon ppt"><em class="sr-only">${f.wkFileGbId }</em></i>
									</c:if>
								</c:otherwise>
							</c:choose> <span class=""> <em class="file_name">${f.wfOrgNm }</em></span>
					</a> <span class="file_size p-1 border border-dark-subtle fileSize">${f.wikiFileSize }</span>
					</li>
				</ul>

			</div>
		</c:forEach>
	</div>
</div>
<!-- 첨부파일 -->

			<!-- button -->
			<div class="btn-box clearfix mt-4">
				<a href="${pageContext.request.contextPath }/wiki"><button class="btn btn-secondary">목록</button></a>
				<div class="right float-end">
					<a href="${pageContext.request.contextPath }/wiki/mod/${wikiId }"><button class="btn btn-primary">수정</button></a>
				</div>
			</div>
			<!-- button -->
						
 <script>

 
 
</script>