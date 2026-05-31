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

				<li><span class="list-tit">작성자</span> <span>관리자 </span> <!-- <select class="select-box" aria-label="Default select example">
                                    <option selected>우민규(디자인1팀, 사원)</option>
                                    <option value="1">유길상(디자인1팀, 사원)</option>
                                    <option value="2">정민지(디자인1팀, 사원)</option>
                                    <option value="4">이상철(디자인1팀, 사원)</option>
                                    <option value="5">김태은(디자인1팀, 사원)</option>
                                </select> --></li>
				<!-- <li><span class="list-tit">진행기간</span><span>2024.04.05</span></li> -->
				<li><span class="list-tit">등록일</span> <span>${ano.bpRegDtStr }</span></li>
				<li><span class="list-tit">게시판 분류</span> <span>${ano.bpNtcName }</span></li>
				<li><span class="list-tit">수정일</span> <span> <c:if
							test="${empty ano.bpModDt }">수정내역 없음</c:if> <c:if
							test="${not empty ano.bpModDtStr }">${ano.bpModDtStr }</c:if>
				</span></li>
				<li><span class="list-tit">조회수</span> <span>${ano.bpCnt }</span>
				</li>
				<!-- 프로젝트 상태값:
                                        <li><span class="">상태</span><span>신규</span></li>
                                        <li><span class="">상태</span><span>안정</span></li>
                                        <li><span class="">상태</span><span>긴급</span></li>
                                -->

			</ul>
		</div>
		<div class="view_content">${ano.bpCn }
		
</div>
	</div>
	<div class="content">
		<div class="inner html">
			<strong class="d-flex align-items-cente mb-3"> <i class=""></i>첨부파일
			</strong>
			<c:if test="${empty bpfv}">
				<em class="file_name">첨부된 파일이 없습니다.</em>
			</c:if>
			<c:forEach items="${bpfv }" var="f">
				<div class="addfile">
					<ul class="fileList">
						<li
							class="d-flex file-row align-items-center justify-content-between mb-2">
							<a
							href="${pageContext.request.contextPath}/board/ano/download/${f.bpFileId}"
							class="file_item d-flex align-items-center"> <c:choose>
									<c:when test="${empty f.bpFileGbId}">
										<em class="file_name">첨부된 파일이 없습니다.</em>
									</c:when>
									<c:otherwise>
										<c:if test="${f.bpFileGbId eq 'pdf' }">
											<i class="icon pdf"><em class="sr-only">${f.bpFileGbId }</em></i>
										</c:if>
										<c:if test="${f.bpFileGbId eq 'txt' }">
											<i class="icon txt"><em class="sr-only">${f.bpFileGbId }</em></i>
										</c:if>
										<c:if test="${f.bpFileGbId eq 'jpg' }">
											<i class="icon txt"><em class="sr-only">${f.bpFileGbId }</em></i>
										</c:if>
										<c:if test="${f.bpFileGbId eq 'png' }">
											<i class="icon txt"><em class="sr-only">${f.bpFileGbId }</em></i>
										</c:if>
										<c:if test="${f.bpFileGbId eq 'word' }">
											<i class="icon word"><em class="sr-only">${f.bpFileGbId }</em></i>
										</c:if>
										<c:if test="${f.bpFileGbId eq 'xlsx' }">
											<i class="icon xlsx"><em class="sr-only">${f.bpFileGbId }</em></i>
										</c:if>
										<c:if test="${f.bpFileGbId eq 'zip' }">
											<i class="icon zip"><em class="sr-only">${f.bpFileGbId }</em></i>
										</c:if>
										<c:if test="${f.bpFileGbId eq 'hwp' }">
											<i class="icon hangle"><em class="sr-only">${f.bpFileGbId }</em></i>
										</c:if>
										<c:if test="${f.bpFileGbId eq 'ppt' }">
											<i class="icon ppt"><em class="sr-only">${f.bpFileGbId }</em></i>
										</c:if>
										<c:if test="${f.bpFileGbId eq 'pptx' }">
											<i class="icon ppt"><em class="sr-only">${f.bpFileGbId }</em></i>
										</c:if>
									</c:otherwise>
								</c:choose> <span class=""> <em class="file_name">${f.bpOrgNm }</em></span>

						</a><span class="file_size p-1 border border-dark-subtle fileSize">${f.bpFileSize }</span>
						</li>
					</ul>
				</div>
			</c:forEach>
		</div>
	</div>
</div>
<!-- project veiw -->
<!-- button -->
<div class="btn-box clearfix mt-4">
	<a href="${pageContext.request.contextPath }/board/ano"><button class="btn btn-secondary">목록</button></a>
</div>
<!-- button -->


