<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<style>
.myprofil{
    width: 37px;
    height: 37px;
    background-size: cover;
    border-radius: 70%;
}
</style>
    
<!-- project veiw -->
						<div class="view task">
							<div class="view_inner">
								<div class="view-info">
									<strong class="view-tit">
										<em>
										${bf.bpTitle }
										</em></strong>
									<ul class="ul clearfix">

										<li><span class="list-tit">작성자</span>
											<span>${bf.empName }</span>
										</li>
										<li><span class="list-tit">수정일자</span>
											<span><c:if test="${empty prais.bpModDt}">수정내역 없음</c:if>
												<c:if test="${not empty prais.bpModDt}">${prais.bpModDtStr}</c:if>
											</span>
										</li>
										<li><span class="list-tit">작성일자</span>
											<span>${bf.bpRegDtStr }</span>
										</li>
										<li><span class="list-tit">조회수</span>
											<span>${bf.bpCnt }</span>
										</li>
								
									</ul>
								</div>
								<div class="view_content">
								${bf.bpCn}

								</div>
							</div>
				<div class="content file">
					<div class="inner html">
						<strong class="d-flex align-items-cente mb-3"> <i
							class=""></i>첨부파일
						</strong>
						<c:if test="${empty bpfv}">
							<em class="file_name">첨부된 파일이 없습니다.</em>
						</c:if>
						<c:forEach items="${bpfv }" var="f">
							<div class="addfile">
								<ul class="fileList">
									<li
										class="d-flex file-row align-items-center justify-content-between mb-2">
										<a href="${pageContext.request.contextPath}/board/form/download/${f.bpFileId}" class="file_item d-flex align-items-center"> <c:choose>
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


						<!-- button -->
						<div class="btn-box clearfix mt-4">
							<a href="${pageContext.request.contextPath }/board/form"><button class="btn btn-secondary">목록</button></a>
<!-- 							<div class="right float-end"> -->
<!-- 								<button class="btn btn-danger">삭제</button> -->
<%-- 								<a href="${pageContext.request.contextPath }/board/form/modify/${bf.bpId}"><button class="btn btn-primary">수정</button></a> --%>
<!-- 							</div> -->
						</div>
						<!-- button -->
						
 <script>


 
</script>