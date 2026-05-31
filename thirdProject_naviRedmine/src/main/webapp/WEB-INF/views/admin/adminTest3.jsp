<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!-- INNER HEADER -->
<div class="header-title select">
	<h2>
		<strong class="title-name">이미지 추가</strong>
	</h2>
</div>
<div class="side_inner">
	<div class="content-box">
		<div class="content">
			<div class="inner html">
			<h4>좌측 버튼이 바뀔 때까지 길게 눌러주세요</h4>
				<video id="webcam" width="540px" height="auto" autoplay></video>
				<br> <input type='button'
					class="btn btn-primary longClickSample" value="길게 눌러주세요" onclick="captureImgs()"/> <input
					type='button' class="btn btn-primary" value="캡쳐업로드" onclick="captureImgSend('NONE3')"/>
				<!-- / INNER HEADER -->
			</div>
		</div>
	</div>
</div>

<script>
	var video = document.getElementById('webcam');
	var canvas = document.createElement('canvas');
	var context = canvas.getContext('2d');
	var formData = new FormData();

	var imgIndex = 0;

	function captureImgs() {
	    canvas.width = video.videoWidth;
	    canvas.height = video.videoHeight;
	    context.drawImage(video, 0, 0, canvas.width, canvas.height);
	    canvas.toBlob(function(blob) {
			formData.append(`file\${imgIndex}`, blob, `image\${imgIndex}.jpg`);
		}, 'image/jpeg', 0.9);
	}

	function captureImgSend(empId) {
		formData.append('empId', empId)
	/*	for(key of formData.keys()){
			console.log(key);
		}*/
		$.ajax({
			url: "http://192.168.141.7:5000/cam_capture_upload.ajax",
			processData: false,
			contentType: false,
			data: formData,
			type: "POST",
			success: function(response) {
			}
		});
	}

	$(document).on('mousedown','.longClickSample',function(){
	    var interval = setInterval(function () {
	        if(imgIndex <= 50){
				captureImgs();
				console.log(imgIndex)
				$('.longClickSample')[0].value = `사진(\${imgIndex++})`
			} else {
				$('.longClickSample')[0].value = `업로드 클릭!`
			}
	    }, 100);

	    $(document).on('mouseup', function () {
	        clearInterval(interval);
	    });
	})

	navigator.mediaDevices.getUserMedia({ video: true }).then(function(stream) {
		video.srcObject = stream;
		video.play();
	}).catch(function(error) {
		console.error(error);
	});

	
</script>