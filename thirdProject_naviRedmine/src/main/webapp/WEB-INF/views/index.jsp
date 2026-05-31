<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/js/common/aos/aos.css">
<script src="${pageContext.request.contextPath }/resources/js/common/aos/aos.js"></script>
<style>

</style>
<!-- wrap -->
<div class="wrap">
	<!-- section1 -->
	<div class="section sc1">
		<div class="inner">
			<div class="box img" data-aos="fade-up"  data-aos-delay="600" data-aos-easing="ease-in-out">
				<div class="box-in img-in">
					<div class="imgcon"></div>
				</div>
			</div>
			<div class="box text">
				<div class="box-in">
					<em class="tit s-tit txt1" data-aos="fade-up" data-aos-delay="600"  data-aos-easing="ease-in-out" >project managment System</em>
					<strong class="tit m-tit txt2" data-aos="fade-up"  data-aos-delay="750" >NAVIMINE</strong>
					<em class="tit m-tit yel txt3" data-aos="fade-up"  data-aos-delay="800" >SEAMLESS</em>
					<em class="tit m-tit yel txt4" data-aos="fade-up"  data-aos-delay="850" data-aos-anchor=".txt3">SOLUTIONS</em>
				</div>
			</div>
		</div>
	</div>
	<!-- section1 -->
	<!-- section2 프로젝트현황-->
	<div class="section sc2">
		<div class="inner">
		<div class="object obj1"  data-aos="fade-in" data-aos-delay="600" ></div>
			<!-- text -->
			<div class="box text">
				<div class="box-in">
					<em class="tit s-tit txt5" data-aos="fade-up"  data-aos-delay="600" data-aos-easing="ease-in-out"  data-aos-anchor=".obj1">project managment System</em> <strong
						class="tit m-tit txt6" data-aos="fade-up" data-aos-delay="700" data-aos-anchor=".txt5">NAVIMINE</strong> <em
						class="tit m-tit yel txt7" data-aos="fade-up" data-aos-delay="750" data-aos-anchor=".txt6">CONSTRACT</em>
				</div>
			</div>
			<!-- text -->
			<!--  /* 그래프 넣아야함 */-->
			<div class="box img" data-aos="fade-up" data-aos-delay="500" data-aos-easing="ease-in-out" >
			
				<div class="box-in img-in">
					<canvas id="projectContract"></canvas>
					<!-- <div class="imgcon"></div> -->
				</div>
			</div>
			<!-- img -->
		</div>
	</div>
	<!-- section2 프로젝트현황 -->
	<!-- section3 우수회원-->
	<div class="section sc3 ">
		
		<div class="inner testimonials">
			<div class="object obj2" data-aos="fade-in" data-aos-delay="400"></div>
			<!-- 우수회원 -->
			<strong class="sc-tit" data-aos="fade-up"  data-aos-anchor=".sc3 .obj2">Top Performer</strong>

			<div class="top row">
				<div class=" d-flex row-in img-card-list"  data-aos-easing="ease-in-out"  data-aos-anchor=".sc3 .obj2">
					<!-- 1 -->
					<c:forEach items="${topPers }" var="emp">
						<div class="col-lg-4" data-aos="fade-up" data-aos-anchor=".img-card-list" data-aos-easing="ease-in-out" data-aos-delay="400">
						<div class="item mx-auto mb-5 mb-lg-0" >

							<div class="img-card" >
								<div class="object star">
									<div class="con">
										<span class="smStar star1"></span>
										<span class="bigStar"></span>
										<span class="smStar star2"></span>
									</div>
								</div>
								<div class="img-in clearfix">
								<c:if test="${empty emp.base64Img}">
								<img class="img img-fluid rounded-circle mb-3"
										src="./resources/images/main/noImg.jpg" alt="...">
							</c:if>
							<c:if test="${not empty emp.base64Img}">
							<img class="img img-fluid rounded-circle mb-3" 
										src="data:image/*;base64,${emp.base64Img }" alt="...">
							</c:if>
								</div>
								<span class="category all fw-bold">${emp.deptName }</span>
							</div>
							<div class="text ">
								<strong>${emp.empName } ${emp.psName } </strong>
							</div>

						</div>
					</div>
					</c:forEach>
				
					<!-- end -->

				</div>
			</div>
			<!-- 우수회원 -->
			<!-- 공지사항-->
			<strong class="sc-tit noti-tit" data-aos="fade-up" data-aos-easing="ease-in-out" data-aos-delay="500"> Notice </strong>
			<div class="bottom row">
<%-- 	${anoMainlist} --%>
				<div class="row-in board-notice" data-aos="fade-up" data-aos-delay="800" data-aos-anchor=".noti-tit">
					
					<div class="board-list">
					  <c:if test="${empty anoMainlist} ">
					  	<div class="content-box">
							<div class="d-flex w100">
								<strong class="content-title">등록된 공지사항이 없습니다.</strong>
							</div>
						</div> 
					  </c:if>
					  <c:if test="${not empty anoMainlist}">
						<c:forEach items="${anoMainlist}" var="ano">
						<div class="content-box">
							
							
							 <c:choose>
						         <c:when test = "${ano.bpNtcName  eq '서식'}">
						            <a href="${pageContext.request.contextPath }/board/form/${ano.bpId}" class="content-link d-flex align-items-center"> 
						         </c:when>
						         <c:when test = "${ano.bpNtcName  eq '칭찬공간'}">
						           <a href="${pageContext.request.contextPath }/board/prais/${ano.bpId}" class="content-link d-flex align-items-center"> 
						         </c:when>
						          <c:when test = "${ano.bpNtcName  eq '포토공간'}">
						           <a href="${pageContext.request.contextPath }/board/photo/${ano.bpId}" class="content-link d-flex align-items-center"> 
						         </c:when>
						          <c:when test = "${ano.bpNtcName  eq 'QNA'}">
						           <a href="${pageContext.request.contextPath }/board/qna/${ano.bpId}" class="content-link d-flex align-items-center"> 
						         </c:when>
						          <c:when test = "${ano.bpNtcName  eq '나눔공간'}">
						           <a href="${pageContext.request.contextPath }/board/share/${ano.bpId}" class="content-link d-flex align-items-center"> 
						         </c:when>
						         
						         <c:otherwise>
						          	<a href="${pageContext.request.contextPath }/board/ano/${ano.bpId}" class="content-link d-flex align-items-center"> 
						         </c:otherwise>
						      </c:choose>
						
							<%-- <a href="${pageContext.request.contextPath }/board/ano/${ano.bpId}" class="content-link d-flex align-items-center">  --%>
									
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
							<strong class="content-title ms-2">${ano.bpTitle }</strong> <span class="content-date">${ano.bpRegDtStr }</span>
							</a>
						</div>
						</c:forEach>
						<%--<div class="content-box">
							<a href="" class="content-link"> <strong
								class="content-title">2222PMS 공지사항2입니다 PMS 공지사항2입니다 PMS
									공지사항입니2다 PMS 공지사항2입니다 PMS 공지사항2입니다 PMS 공지사항2입니다 PMS 2공지사항2입니다
									PMS 공지사항입니다</strong> <span class="content-date">2023.12.30</span>
							</a>
						</div> --%>	
					</c:if>
					</div>
					<a href='<c:url value="/board/ano"/>' class="more"> 
						<span> <i class="sr-only">공지사항더보기</i></span>
					</a>
				</div>
			</div>

		</div>
		<!-- 공지사항-->
	</div>

<!-- wrap -->

	
</div>


<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
