<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle">Web Messenger</c:set>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="<c:url value='/resources/css/chat/bubbleChat.css'/>"/>
<title>${pageTitle} chat</title><!--WebSocket messenger chat -->
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">

	var websocket = null;
	var first = "true";
	$('#sendBtn').attr("disabled", true);
	
	
	$(document).ready(function() {
		var url = 'ws://' + window.location.host + '/navi/chat/'+'<c:out value="${roomId}"/>';
		
		websocket = connection(url);
		
		websocket.onopen = function(){
		    var username = '<c:out value="${username}"/>';
		    send(username);
		    console.log("대화창연결", username);
		};

		websocket.onmessage = function(message) {
			processMessage(message);
		};
		
		websocket.onclose = function() {
			console.log('Info: WebSocket closed.');
		};
		
		websocket.onerror = function(message) {
			processError(message);
		};
		
		$('#sendBtn').click(function() {
			console.log('Send button clicked');
			send(textMessage.value);
			textMessage.value = "";
		});
		
		$('#textMessage').keypress(function(e) {
			if(e.which==13) {
				send(textMessage.value);
				textMessage.value = "";
			}
		});
	});
	
	function connection(url) {
		
		var websocket = null;
		if ('WebSocket' in window) {
			websocket = new WebSocket(url);
		} else if ('MozWebSocket' in window) {
			websocket = new MozWebSocket(url);
		} else {
			Console.log('Error: WebSocket is not supported by this browser.');
            return null;
		}
		return websocket;
	}
	
	function processMessage(message) {
		var jsonData = JSON.parse(message.data);
	    console.log("message", message);
	    console.log("jsonData", jsonData);
	    
	    if (jsonData.messageType == "ChatMessage") {
	        var messageContent = jsonData.name + " : "+ jsonData.message + '\n';
	        display(messageContent);
	        displaybubble(jsonData);
	    } else if (jsonData.messageType == "UsersMessage") {
	        var other = "";
	    } else if (jsonData.messageType == "ChatVO") {
	        var previousMessageContent = jsonData.senderName + " : " + jsonData.chatContent + '\n';
	        displaybubble(jsonData);
	    } 
	}

	function send(message) {
		console.log('Sending message:', message);
		websocket.send(JSON.stringify({ 'message' : message , 'room' : "<c:out value='${roomId}'/>"}));
	}

	function display(message) {
		
	}
	
	function displaybubble(data) {
		console.log("data", data);
	    var messageHTML = '';
	    if (data.messageType == "ChatMessage") {
	        if (data.name == "${username}") {
	            messageHTML += "<br/><div class='me'>" + data.message + "</div>";
	        } else {
	            messageHTML += "<br/><div class='chat-name'>"+ data.name + "</div><div class='you'>" + data.message + "</div>";
	        }
	    } else if (data.messageType == "ChatVO") {
	        if (data.name == "${username}") {
	            messageHTML += "<br/><div class='me'>" + data.message + "</div>";
	        } else {
	            messageHTML += "<br/><div class='chat-name'>"+ data.name + "</div><div class='you'>" + data.message + "</div>";
	        }
	    }
	    $('#chat').append(messageHTML);
	}

	function processError(message) {
		console.log(message)
	}

 	window.onbeforeunload = function() {
		websocket.close();
	};  
	
</script>
</head>
<body>
	<div class="container">
		<div class="middle" id="chat">
		</div>
		<div class="bottom">
			<textarea class="textarea" id="textMessage"></textarea>
			<input class="sendBtn" type="button" id="sendBtn" name="sendBtn" value="전송" />
		</div>
	</div>
</body>
</html>