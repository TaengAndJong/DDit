<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form"  prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags"  prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<style>
.myprofil{
	background-image: url(data:image/*;base64,${realUser.base64Img });
    width: 37px;
    height: 37px;
    background-size: cover;
    border-radius: 70%;
}
</style>
  <%-- sub 일 때 class sub 추가  , fixed-top 삭제 --%>
   <%--  sub 일 때  -> 이거사용 <header id="header" class="header sub">--%>
<%--    ${realUser } --%>
    <header id="header" class="header sub">
      <div  class="container d-flex align-items-center justify-content-lg-center position-relative " >
    
        <strong class="logo me-auto me-lg-0">
          <a href="${pageContext.request.contextPath}">
            <h1 class="sr-only">네비마인로고</h1>
          </a>
        </strong>
      
        <nav id="navbar" class="navbar order-last order-lg-0">
          <ul>
          	<c:forEach items="${main}" var="menu">
				    <li><a class="nav-link" href="${pageContext.request.contextPath}${menu.rescUrl}">${menu.rescMenu}</a></li>
            <%--  <li><a class="nav-link" href="${pageContext.request.contextPath}/project">프로젝트</a></li> --%>
			      </c:forEach>
            
          </ul>

         <%-- 알림 --%>
          <ul class="right_util d-flex">
            <li class="dropdown alarm">
              <a href="#">
                <span class="icon alarm"
                  ><span class="sr-only">알림</span><em class="num" id="alramListCnt"></em></span></a>
              <ul class="alarmlist ellipsis">
              </ul>
            </li>
            <%-- 알림 --%>
            <%-- 프로필,로그아웃--%>
            <li class="dropdown profil">
              <a href="#">
              <c:if test="${not empty realUser.empImage }">
                <span class="myprofil icon">
<%--                      <img id="profilimg"src="data:image/*;base64,${realUser.base64Img }" alt="프로필이미지"> --%>
                </span>
                </c:if>
                <c:if test="${empty realUser.empImage }">
                <span class="icon profil ">
                </span>
                </c:if>
                ${sessionMenu}
              </a>
              <ul class="my_list">
                <li class="li">
                	<div class="li-con">
	                  <em class="d-flex align-items-center mb-2"><i class="icon sleepAlarm_b me-3"></i><span>졸음방지</span></em>
	                  <%-- checked 일때 on , checked 아닐 때 off --%>
	                  <div class="wk_con form-check form-switch">
	                   <label class="form-check-label" for="flexSwitchCheckChecked" >on/off</label>
	                    <input
	                      class="form-check-input"
	                      type="checkbox"
	                      role="switch"
	                      id="flexSwitchCheckChecked"
	                      onclick="toggleAction()"
	                    />
	                    </div>
   	                   <script>
						var testPopup;
						
						function toggleAction() {
						  var checkbox = document.getElementById("flexSwitchCheckChecked");
						  if (checkbox.checked) {
						    // Open test.jsp in a popup window
						    testPopup = window.open("${pageContext.request.contextPath}/sleepAlarm", "TestPopup", "width=600,height=400");
						  } else {
						    // Close the popup window
						    if (testPopup) {
						      testPopup.close();
						    }
						  }
						}
						</script>
                  </div>
                </li>
                 <li class="li">
                  <a href="${pageContext.request.contextPath}/myLogout" class="li-con"><i class="icon logout_b me-3"></i>로그아웃</a>
                </li>
              </ul>
            </li>
            <%--  프로필 ,로그아웃--%>
          </ul>
          <%--모바일--%>
          <i class="bi bi-list mobile-nav-toggle"></i>
          <%--모바일--%>
        </nav>
        <%-- .navbar --%>
      </div>

<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
  <div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="toast-header text-white bg-primary">
      <img src="${pageContext.request.contextPath}/resources/images/layout/navi.png" width="20px" height="20px" class="rounded me-2" alt="">
      <strong class="me-auto">NAVIMINE <small></small></strong>
     
      <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
    <div class="toast-body" id="alram-body">
      Hello, world! This is a toast message.
    </div>
  </div>
</div>
    </header>
<%-- End Header --%>

<script type="text/javascript">
		function clock(){
		    let timetext = document.querySelector('small'); /* h1 태그 갖고오기 */
		    let today = new Date(); /* 날짜와 시간 */
		    let H = today.getHours();
		    let M = today.getMinutes() < 10 ? '0' + today.getMinutes() : today.getMinutes();
		    let ampm = today.getHours() >= 12 ? 'PM' : 'AM';
// 		    let S = today.getSeconds();
		
		    timetext.innerHTML = H + ":" + M + ampm; /* html에 출력 */
		}
		clock();
		setInterval(clock,1000); /* 1초마다 clock함수 실행 */
</script>
