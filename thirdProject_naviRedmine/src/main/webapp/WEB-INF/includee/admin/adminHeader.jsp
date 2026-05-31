<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
	<!-- 아코디언메뉴 -->
	<div id="admin" class="admin d-flex">
		<div id="layoutSidenav_nav"
			class="side_navi shadow-right sidenav-light clearfix">
			<nav class="sidenav clearfix ">
				<div class="sidenav-menu">
					<div class="nav accordion" id="accordionSidenav">
						<!-- Sidenav Menu Heading (Account)-->
						<div class="admin_title text-center fs-3">
							<em>NANIMINE</em> <strong>PMS ADMIN</strong>
						</div>
						<!-- 어카운트-->
						<div class="sidenav-menu-heading d-sm-none">Account</div>
						<a class="nav-link d-sm-none" href="#!">
							<div class="nav-link-icon ">
								<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
									viewBox="0 0 24 24" fill="none" stroke="currentColor"
									stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
									class="feather feather-bell">
	                                    <path
										d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path>
	                                    <path
										d="M13.73 21a2 2 0 0 1-3.46 0"></path>
	                                </svg>
							</div> Alerts <span class="badge bg-warning-soft text-warning ms-auto">4
								New!</span>
						</a>
						<!-- 레프트 링크 -->
						<a class="nav-link d-sm-none" href="#!">
							<div class="nav-link-icon">
								<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
									viewBox="0 0 24 24" fill="none" stroke="currentColor"
									stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
									class="feather feather-mail">
	                                    <path
										d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z">
	                                    </path>
	                                    <polyline points="22,6 12,13 2,6"></polyline>
	                                </svg>
							</div> Messages <span
							class="badge bg-success-soft text-success ms-auto">2 New!</span>
						</a>
						<!-- Sidenav Menu Heading (Core)-->

						<!-- 사원관리(조회)-->
						<strong class="sidenav-menu-heading">관리</strong> 
						<!-- 사원관리(조회 ,초대,권한설정)-->
						<!-- 프로젝트(조회,삭제복구)-->
						<a class="nav-link collapsed" href="javascript:void(0);"
							data-bs-toggle="collapse" data-bs-target="#project"
							aria-expanded="false" aria-controls="project">
							<div class="nav-link-icon">
								<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
									viewBox="0 0 24 24" fill="none" stroke="currentColor"
									stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
									class="feather feather-tool">
	                                    <path
										d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z">
	                                    </path>
	                                </svg>
							</div> <strong class="depth1 tit">프로젝트</strong>
							<div class="sidenav-collapse-arrow">
								<svg class="svg-inline--fa fa-angle-down" aria-hidden="true"
									focusable="false" data-prefix="fas" data-icon="angle-down"
									role="img" xmlns="http://www.w3.org/2000/svg"
									viewBox="0 0 384 512" data-fa-i2svg="">
	                                    <path fill="currentColor"
										d="M169.4 342.6c12.5 12.5 32.8 12.5 45.3 0l160-160c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L192 274.7 54.6 137.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l160 160z">
	                                    </path>
	                                </svg>
								<!-- <i class="fas fa-angle-down"></i> Font Awesome fontawesome.com -->
							</div>
						</a>
					<div class="collapse" id="project"
						data-bs-parent="#accordionSidenav" style="">
						<nav class="sidenav-menu-nested nav">
							<a class="nav-link" href="${pageContext.request.contextPath }/admin/project/?ing=ing">조회 및 설정</a> 
							<a class="nav-link" href="${pageContext.request.contextPath }/admin/project/?ing=end">프로젝트 복구</a>
						</nav>
					</div>
					<!-- 프로젝트(조회,삭제복구) -->

						<!-- 일감(조회)-->
						<a class="nav-link collapsed" href="javascript:void(0);"
							data-bs-toggle="collapse" data-bs-target="#task"
							aria-expanded="false" aria-controls="task">
							<div class="nav-link-icon">
								<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
									viewBox="0 0 24 24" fill="none" stroke="currentColor"
									stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
									class="feather feather-tool">
	                                    <path
										d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z">
	                                    </path>
	                                </svg>
							</div> <strong class="depth1 tit">일감</strong>
							<div class="sidenav-collapse-arrow">
								<svg class="svg-inline--fa fa-angle-down" aria-hidden="true"
									focusable="false" data-prefix="fas" data-icon="angle-down"
									role="img" xmlns="http://www.w3.org/2000/svg"
									viewBox="0 0 384 512" data-fa-i2svg="">
	                                    <path fill="currentColor"
										d="M169.4 342.6c12.5 12.5 32.8 12.5 45.3 0l160-160c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L192 274.7 54.6 137.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l160 160z">
	                                    </path>
	                                </svg>
								<!-- <i class="fas fa-angle-down"></i> Font Awesome fontawesome.com -->
							</div>
						</a>
						<div class="collapse" id="task" data-bs-parent="#accordionSidenav"
							style="">
							<nav class="sidenav-menu-nested nav">
								<a class="nav-link" href="${pageContext.request.contextPath }/admin/task">일감 관리</a>

							</nav>
						</div>
						<!-- 일감(조회)-->
						<!-- 사원 -->
						<a
							class="nav-link collapsed" href="javascript:void(0);"
							data-bs-toggle="collapse" data-bs-target="#worker"
							aria-expanded="false" aria-controls="worker">
							<div class="nav-link-icon">
								<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
									viewBox="0 0 24 24" fill="none" stroke="currentColor"
									stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
									class="feather feather-tool">
	                                    <path
										d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z">
	                                    </path>
	                                </svg>
							</div> <strong class="depth1 tit">사원</strong>
							<div class="sidenav-collapse-arrow">
								<svg class="svg-inline--fa fa-angle-down" aria-hidden="true"
									focusable="false" data-prefix="fas" data-icon="angle-down"
									role="img" xmlns="http://www.w3.org/2000/svg"
									viewBox="0 0 384 512" data-fa-i2svg="">
	                                    <path fill="currentColor"
										d="M169.4 342.6c12.5 12.5 32.8 12.5 45.3 0l160-160c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L192 274.7 54.6 137.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l160 160z">
	                                    </path>
	                                </svg>
								<!-- <i class="fas fa-angle-down"></i> Font Awesome fontawesome.com -->
							</div>
						</a>
						<div class="collapse" id="worker"
							data-bs-parent="#accordionSidenav" style="">
							<nav class="sidenav-menu-nested nav">
								<a class="nav-link" href="${pageContext.request.contextPath }/admin/emp">전체 및 PMS 사원조회</a> 
								<a class="nav-link" href="${pageContext.request.contextPath }/admin/emp/invite">PMS 시스템 초대</a> 
								<a class="nav-link" href="${pageContext.request.contextPath }/admin/emp/empo">프로젝트관리자 관리</a> 
								<a class="nav-link" href="${pageContext.request.contextPath }/admin/emp/block">PMS 접근권한 관리</a>
							</nav>
						</div>
<!-- 						사원 -->
<!-- 						위키(조회) -->
<!-- 						<a class="nav-link collapsed" href="javascript:void(0);" -->
<!-- 							data-bs-toggle="collapse" data-bs-target="#wiki" -->
<!-- 							aria-expanded="false" aria-controls="wiki"> -->
<!-- 							<div class="nav-link-icon"> -->
<!-- 								<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" -->
<!-- 									viewBox="0 0 24 24" fill="none" stroke="currentColor" -->
<!-- 									stroke-width="2" stroke-linecap="round" stroke-linejoin="round" -->
<!-- 									class="feather feather-tool"> -->
<!-- 	                                    <path -->
<!-- 										d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z"> -->
<!-- 	                                    </path> -->
<!-- 	                                </svg> -->
<!-- 							</div> <strong class="depth1 tit">위키</strong> -->
<!-- 							<div class="sidenav-collapse-arrow"> -->
<!-- 								<svg class="svg-inline--fa fa-angle-down" aria-hidden="true" -->
<!-- 									focusable="false" data-prefix="fas" data-icon="angle-down" -->
<!-- 									role="img" xmlns="http://www.w3.org/2000/svg" -->
<!-- 									viewBox="0 0 384 512" data-fa-i2svg=""> -->
<!-- 	                                    <path fill="currentColor" -->
<!-- 										d="M169.4 342.6c12.5 12.5 32.8 12.5 45.3 0l160-160c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L192 274.7 54.6 137.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l160 160z"> -->
<!-- 	                                    </path> -->
<!-- 	                                </svg> -->
<!-- 								<i class="fas fa-angle-down"></i> Font Awesome fontawesome.com -->
<!-- 							</div> -->
<!-- 						</a> -->
<!-- 						<div class="collapse " id="wiki" -->
<!-- 							data-bs-parent="#accordionSidenav" style=""> -->
<!-- 							<nav class="sidenav-menu-nested nav"> -->
<%-- 								<a class="nav-link" href="${pageContext.request.contextPath }/admin/wiki">위키 관리</a> --%>
<!-- 							</nav> -->
<!-- 						</div> -->
<!-- 						위키(조회) -->

<!-- 공지사항(조회)-->
						<a class="nav-link collapsed" href="javascript:void(0);"
							data-bs-toggle="collapse" data-bs-target="#worker_invite"
							aria-expanded="false" aria-controls="worker_invite">
							<div class="nav-link-icon">
								<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
									viewBox="0 0 24 24" fill="none" stroke="currentColor"
									stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
									class="feather feather-tool">
	                                    <path
										d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z">
	                                    </path>
	                                </svg>
							</div> <strong class="depth1 tit">공지사항</strong>
							<div class="sidenav-collapse-arrow">
								<svg class="svg-inline--fa fa-angle-down" aria-hidden="true"
									focusable="false" data-prefix="fas" data-icon="angle-down"
									role="img" xmlns="http://www.w3.org/2000/svg"
									viewBox="0 0 384 512" data-fa-i2svg="">
	                                    <path fill="currentColor"
										d="M169.4 342.6c12.5 12.5 32.8 12.5 45.3 0l160-160c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L192 274.7 54.6 137.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l160 160z">
	                                    </path>
	                                </svg>
								<!-- <i class="fas fa-angle-down"></i> Font Awesome fontawesome.com -->
							</div>
						</a>
						<div class="collapse" id="worker_invite"
							data-bs-parent="#accordionSidenav" style="">
							<nav class="sidenav-menu-nested nav">
								<a class="nav-link" href="${pageContext.request.contextPath }/admin/ano">공지사항 관리</a>

							</nav>
						</div>
						<!-- 공지사항 (조회)-->


						<!-- 서식자료 (조회)-->
						<a class="nav-link collapsed" href="javascript:void(0);"
							data-bs-toggle="collapse" data-bs-target="#form"
							aria-expanded="false" aria-controls="form">
							<div class="nav-link-icon">
								<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
									viewBox="0 0 24 24" fill="none" stroke="currentColor"
									stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
									class="feather feather-tool">
	                                    <path
										d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z">
	                                    </path>
	                                </svg>
							</div> <strong class="depth1 tit">서식자료</strong>
							<div class="sidenav-collapse-arrow">
								<svg class="svg-inline--fa fa-angle-down" aria-hidden="true"
									focusable="false" data-prefix="fas" data-icon="angle-down"
									role="img" xmlns="http://www.w3.org/2000/svg"
									viewBox="0 0 384 512" data-fa-i2svg="">
	                                    <path fill="currentColor"
										d="M169.4 342.6c12.5 12.5 32.8 12.5 45.3 0l160-160c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L192 274.7 54.6 137.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l160 160z">
	                                    </path>
	                                </svg>
								<!-- <i class="fas fa-angle-down"></i> Font Awesome fontawesome.com -->
							</div>
						</a>
						<div class="collapse " id="form"
							data-bs-parent="#accordionSidenav" style="">
							<nav class="sidenav-menu-nested nav">
								<a class="nav-link" href="${pageContext.request.contextPath }/admin/form">서식자료 관리</a>

							</nav>
						</div>
						<!-- 서식자료 (조회)-->

						<!-- 커뮤니티(조회)-->
						<a class="nav-link collapsed" href="javascript:void(0);"
							data-bs-toggle="collapse" data-bs-target="#community"
							aria-expanded="false" aria-controls="community">
							<div class="nav-link-icon">
								<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
									viewBox="0 0 24 24" fill="none" stroke="currentColor"
									stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
									class="feather feather-tool">
	                                    <path
										d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z">
	                                    </path>
	                                </svg>
							</div> <strong class="depth1 tit">커뮤니티</strong>
							<div class="sidenav-collapse-arrow">
								<svg class="svg-inline--fa fa-angle-down" aria-hidden="true"
									focusable="false" data-prefix="fas" data-icon="angle-down"
									role="img" xmlns="http://www.w3.org/2000/svg"
									viewBox="0 0 384 512" data-fa-i2svg="">
	                                    <path fill="currentColor"
										d="M169.4 342.6c12.5 12.5 32.8 12.5 45.3 0l160-160c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L192 274.7 54.6 137.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l160 160z">
	                                    </path>
	                                </svg>
								<!-- <i class="fas fa-angle-down"></i> Font Awesome fontawesome.com -->
							</div>
						</a>
						<div class="collapse" id="community"
							data-bs-parent="#accordionSidenav" style="">
							<nav class="sidenav-menu-nested nav">
								<a class="nav-link" href="${pageContext.request.contextPath }/admin/board/photo">포토게시판 관리</a> 
								<a class="nav-link" href="${pageContext.request.contextPath }/admin/board/prais">칭찬게시판 관리</a> 
								<a class="nav-link" href="${pageContext.request.contextPath }/admin/board/share">나눔게시판 관리</a>
							</nav>
						</div>
						<!-- 커뮤니티 (조회)-->

						<!-- 추천AI-->
						<a class="nav-link collapsed" href="javascript:void(0);"
							data-bs-toggle="collapse" data-bs-target="#manageqna"
							aria-expanded="false" aria-controls="manageqna">
							<div class="nav-link-icon">
								<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
									viewBox="0 0 24 24" fill="none" stroke="currentColor"
									stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
									class="feather feather-tool">
	                                    <path
										d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z">
	                                    </path>
	                                </svg>
							</div> <strong class="depth1 tit">질문관리</strong>
							<div class="sidenav-collapse-arrow">
								<svg class="svg-inline--fa fa-angle-down" aria-hidden="true"
									focusable="false" data-prefix="fas" data-icon="angle-down"
									role="img" xmlns="http://www.w3.org/2000/svg"
									viewBox="0 0 384 512" data-fa-i2svg="">
	                                    <path fill="currentColor"
										d="M169.4 342.6c12.5 12.5 32.8 12.5 45.3 0l160-160c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L192 274.7 54.6 137.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l160 160z">
	                                    </path>
	                                </svg>
								<!-- <i class="fas fa-angle-down"></i> Font Awesome fontawesome.com -->
							</div>
						</a>
						<div class="collapse" id="manageqna"
							data-bs-parent="#accordionSidenav" style="">
							<nav class="sidenav-menu-nested nav">
								<a class="nav-link" href="${pageContext.request.contextPath }/admin/qna">QNA 관리</a> 
							</nav>
						</div>
						<!-- 추천AI-->

						<!-- 데이터리포팅 -->
						<a class="nav-link collapsed" href="javascript:void(0);" onclick="redirectToAdmin()" data-bs-toggle="collapse"
							data-bs-target="" aria-expanded="false" aria-controls="">
							<div class="nav-link-icon">
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
								class="feather feather-tool">
            				<path d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z"></path>
        					</svg>
							</div>
							<strong class="depth1 tit">AI얼굴인식 등록</strong>
							<div class="sidenav-collapse-arrow">
							<svg class="svg-inline--fa fa-angle-down" aria-hidden="true"
								focusable="false" data-prefix="fas" data-icon="angle-down"
								role="img" xmlns="http://www.w3.org/2000/svg"
								viewBox="0 0 384 512" data-fa-i2svg="">
           					 	<path fill="currentColor" d="M169.4 342.6c12.5 12.5 32.8 12.5 45.3 0l160-160c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L192 274.7 54.6 137.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l160 160z"></path>
      						 </svg>
						</div>
					</a>

					<script>
					    function redirectToAdmin() {
					        window.location.href = '${pageContext.request.contextPath}/admin/facelogin';
					    }
					</script>
					
						<!-- 관리자 로그아웃 -->
						<!-- 데이터리포팅 -->
						
						<!-- 타사원 사진추가 -->
						<a class="nav-link collapsed" href="javascript:void(0);" onclick="redirectToAdmin2()" data-bs-toggle="collapse"
							data-bs-target="" aria-expanded="false" aria-controls="">
							<div class="nav-link-icon">
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
								class="feather feather-tool">
            				<path d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z"></path>
        					</svg>
							</div>
							<strong class="depth1 tit">AI얼굴인식 등록(사원)</strong>
							<div class="sidenav-collapse-arrow">
							<svg class="svg-inline--fa fa-angle-down" aria-hidden="true"
								focusable="false" data-prefix="fas" data-icon="angle-down"
								role="img" xmlns="http://www.w3.org/2000/svg"
								viewBox="0 0 384 512" data-fa-i2svg="">
           					 	<path fill="currentColor" d="M169.4 342.6c12.5 12.5 32.8 12.5 45.3 0l160-160c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L192 274.7 54.6 137.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l160 160z"></path>
      						 </svg>
						</div>
					</a>

					<script>
					    function redirectToAdmin2() {
					        window.location.href = '${pageContext.request.contextPath}/admin/faceemp';
					    }
					    
					</script>
					
						<!-- 관리자 로그아웃 -->
						<!-- 데이터리포팅 -->
						<!-- end -->
					</div>
					
					<a class="nav-link logout" href="${pageContext.request.contextPath }/myLogout"> <strong
						class="depth1 tit">로그아웃</strong>
					</a>
				</div>

			</nav>
		</div>
		<!--  content-->
		<div id="layoutSidenav_content" class="side_content">
			<!--inner-->
			<div class="side_inner">
			
	<script type="text/javascript">
 		let links = $('.nav-link')
		for(link of links){
			if(link.href.includes(window.location.href) != -1){
				link.parent.
			}
		}
 
 	
 	</script>