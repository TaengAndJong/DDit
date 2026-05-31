<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>졸음방지알림WebCam</title>
</head>

<body>
    <video id="webcam" width="640" height="480" autoplay></video>
	<audio id="audio" src="" type="audio/mpeg"> </audio>
	
    <script src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/4.3.2/socket.io.js"></script>
	<script>
	    const socket = io('http://192.168.141.24:5000');
	    
	    // 웹캠 스트림 가져오기
	    navigator.mediaDevices.getUserMedia({ video: true })
	    .then(function(stream) {
	        var video = document.getElementById('webcam');
	        
	        video.srcObject = stream;
	
	        var canvas = document.createElement('canvas');
	        var context = canvas.getContext('2d');
	
	        // 웹캠 영상을 실시간으로 서버로 전송
	        setInterval(function() {
	            context.drawImage(video, 0, 0, canvas.width, canvas.height);
	            canvas.toBlob(function(blob) {
	                socket.emit('webcam_data', blob);
	            }, 'image/jpeg');
	        }, 1000);
	    })
	    .catch(function(error) {
	        console.error('웹캠 접근 에러:', error);
	    });
	    
	    // 알람재생
	    socket.on('play_sound', function(data) {
	    	console.log("data", data);
	    	console.log("data.url", data.url);
	        var audio = document.getElementById('audio');
	        audio.src = data.url;
	        audio.play();
	    });
	 	// 알람멈춤
	    socket.on('stop_sound', function(data) {
	    	console.log("data", data);
	    	console.log("data.url", data.url);
	        var audio = document.getElementById('audio');
	        audio.src = data.url;
	        audio.pause();
	    });
	</script>
</body>
</html>