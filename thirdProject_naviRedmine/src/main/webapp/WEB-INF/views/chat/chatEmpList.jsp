<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div id="cstmrList" data-list>
	<div class="chat_top point_bg">
		<button class="btn close ">
			<i class="icon left_arrow"></i> <em class="sr-only">채팅숨기기</em>
		</button>
			<!-- 검색 -->
			<div class="chat_search">
				<form id="chatForm"
					action="${pageContext.request.contextPath }/chat/chatEmpList"
					method="post">
					<div class="input-group d-flex">
						<input class="form-control form-control-sm shadow-none search search_input"
							type="search" placeholder="Search..." aria-label="search" />
					</div>
				</form>
			</div>
			<!-- 검색 -->
	</div>
	<form:form name="usersForm">
		<input type="hidden" id="roomId" name="roomId"/>
		<input type="hidden" id="username" name="username"/>
	<div class="flex-container font mt-3 me">
		<c:if test="${empty realUser.base64Img}">
			<img src="${pageContext.request.contextPath}/resources/images/prog/navi.jpg" alt="프로필이미지">
		</c:if>
		<c:if test="${not empty realUser.base64Img}">
			<img class="empImg radius-img" src="data:image/*;base64,${realUser.base64Img }" alt="프로필" />
		</c:if>
		<c:set var="username" value="${realUser.empName}" />
		<c:set var="userId" value="${realUser.empId }" />
		<span class="empOne">${realUser.empName }${realUser.psName }(${realUser.deptName })</span>
	</div>
	<div class="chat_list content scrollbar" id="users" name="users">
		<!-- 리스트 시작 -->
		<ul class="list" id="listBody">
			<li class="font text-start mb-3 d-flex align-items-center justify-content-between popup">
				<div class="flex-container">
					<div class="empImg"></div>
					<div class="ml-3 ">
                <span class="empOne font-weight-bold d-block"></span>
                <span class="lastChat text-muted d-block"></span>
            </div>
        </div>
        	<span class="lastChatSendDtStr"></span>
			</li>
		</ul>
		<!-- 리스트 종료 -->
	</div>
	</form:form>
</div>

<script>
function getCsrfToken(){
	   return document.querySelector('meta[name="_csrf"]').getAttribute('content');
	}

// CSRF 헤더를 가져오는 함수
function getCsrfHeader(){
   return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
}
	
	var webSocket = null;
	$(document).ready(function() {
		 // WebSocket 연결 URL을 설정(EndPoint)
		 var url = 'ws://' + window.location.host + '/navi/usersServerEndpoint';
		 webSocket = connection(url);
		 
		 webSocket.onopen = function() {
		     console.log("WebSocket 연결됨");
		 };
		 
		 webSocket.onmessage = function(message) {
		     processMessage(message);
		 };
	});
	
	//WebSocket 연결설정
	function connection(url) {
		 var webSocket = null;
		 // 현재 브라우저가 WebSocket을 지원하는지 확인
		 if ('WebSocket' in window) {
		     webSocket = new WebSocket(url);
		 } else if ('MozWebSocket' in window) {
		     webSocket = new MozWebSocket(url);
		 } else {
		     // 브라우저가 WebSocket을 지원하지 않는 경우 에러를 출력하고 null을 반환
		     console.error('Error: WebSocket is not supported by this browser.');
		     return null;
		 }
		 return webSocket;
	}

	// 서버에서 메시지가 넘어왔을 때 처리하는 함수
	function processMessage(message) {
	    // 서버에서 전송한 메시지를 JSON 형식으로 파싱
	    var jsonData = JSON.parse(message.data);
	    // 만약 서버로부터 받은 메시지에 채팅방 ID가 포함되어 있다면,
	    if (jsonData.roomId) {
	        // 선택한 사람의 roomId를 가져옴
	        var selectedRoomId = jsonData.roomId;
// 	        var selectedEmpId = $(".popup").find('.dataa').data("emp-id");
	        var username = "${username}";
	        
	        // 서버에서 받은 roomId와 선택한 사람의 roomId를 비교
	        if (selectedRoomId === jsonData.roomId) {
	        	
	        	$("#roomId").val(selectedRoomId);
	            $("#username").val(username);
	            
		        // 일치할 경우 팝업창 띄우기
		        openChatRoom(selectedRoomId);
	        }
	    }
	}
	
	$(document).ready(function() {
	    // li.popup 요소에 대한 클릭 이벤트추가
	    $(document).on("click", "li.popup", function() {
	        // 클릭된 li 요소 내에서 roomId 데이터를 가져옴
	        var roomId = $(this).find('.dataa').data("room-id");
	        var connectingUser = $(this).find('.dataa').data("emp-id");
        	
	        // 대화 상대의 대화창을 엽니다.
	        openChatRoom(roomId);
	        
	     	// 대화 요청 메시지를 서버에 보냅니다.
            var connectionType = "chatConnection";
            var username = "${username}";
            var userId = "${userId}";
            
            webSocket.send(JSON.stringify({
                "connectionType": connectionType,
                "username": username,
                "userId": userId,
                "connectingUser": connectingUser
            }));
		});
	});
	
	// 채팅방을 팝업으로 열기 위한 함수
	function openChatRoom(roomId) {
	    // 팝업 창 옵션 설정
	    var popOptions = "width=500, height=700, resizable=yes, status=no, scrollbar=yes";
	    // 채팅방 열기를 요청하는 URL 설정
	    var url = "<c:url value='/chat/chatRoom'/>";
	    // 채팅방 열기를 요청하고 팝업 창을 엽니다.
	    popupPost(url, "chatRoomPopup", popOptions);
	}

	// 팝업 창을 열기 위한 함수
	function popupPost(url, target, option) {
	    // 팝업 창 열기
	    window.open("", target, option);
	    var form = $("form[name=usersForm]");
		form.attr("target", target);
		form.attr("action", url);
		form.attr("method", "post");
		form.submit();
	}

	window.onbeforeunload = function() {
		if (webSocket) {
			webSocket.close();
			console.log("WebSocket 연결 닫힘");
		}
	};
</script>