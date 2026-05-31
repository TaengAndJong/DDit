<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form"  prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags"  prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="security"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <script src="${pageContext.request.contextPath }/resources/js/common/jquery-3.7.1.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SKJ-Project Management System</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath }/resources/images/main/noImg.jpg" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/template/login.css"/>
    <script src="${pageContext.request.contextPath}/resources/assets/dist/js/bootstrap.bundle.min.js"></script>
    <security:csrfMetaTags/>
</head>

<body>
<form:form id="loginForm"> 
     <%-- 로그인  --%>
       <div class="wrap">

        <div class="wrap-inner">

				<!-- 로그인 버튼 -->
				<button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#webcamModal" ></button>

				<!-- 웹캠 모달 -->
				<div class="modal fade" id="webcamModal" tabindex="-1"
					aria-labelledby="webcamModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
						
							<div class="modal-header">
								<h5 class="modal-title" id="webcamModalLabel">얼굴인식 로그인</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							
							<div class="modal-body">
								<!-- 여기에 웹캠을 띄우는 코드를 추가 -->
								<video id="webcam" width="100%" height="auto" autoplay></video>
							</div>
							
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary" id="closeModalBtn"
									data-bs-dismiss="modal" >닫기</button>
								<button type="button" class="btn btn-primary"
									onclick="captureAndSend()">로그인</button>
							</div>
						</div>
					</div>
				</div>


				<div class="centerBox">
             <%-- right:box  --%>
                <div class="box right">
                	<%-- login  --%>
                    <div class="login">
                       
                        <strong class="login-title">
                            <em class="sr-only">PMS LOGIN</em>
                        </strong>
                        <em class="sub-title">
                            NAVI MINE에 오신걸 환영합니다.
                        </em>
                    
                        <div class="login-info">
                            <div class="mb-1">
                                <input type="text" title="사원번호를 입력해주세요." placeholder="사원번호를 입력해주세요."
                                    class="form-control" id="id" name="username" autocomplete="off" required=""
                                    aria-required="true">
                            </div>
                            <div class="mb-2">
                                <input type="password" title="비밀번호를 입력해주세요." placeholder="비밀번호를 입력해주세요."
                                    class="form-control" id="password" name="password" autocomplete="off"
                                    required="" aria-required="true">
                            </div>
                            <div class="d-flex justify-content-start m-2 my-3 align-items-center">
                                <span class="ui-check">
<!--                                     <input class="form-check-input" type="checkbox" id="loginStateCheck" -->
<!--                                         name="username" title="로그인 상태 유지하기" value="d"> -->
<!--                                     <label class="checkbox-inline" for="loginStateCheck"> -->
<!--                                         로그인상태 유지하기 -->
<!--                                     </label> -->
<!--                                     <input type="hidden" name="loginState" id="loginState" value="false"> -->
                                </span>
                            </div>
                            <button id="login" type="submit" class="btn btn-primary">로그인</button>
                            <button type="button" class="btn btn btn-secondary" data-bs-toggle="modal"
							data-bs-target="#empIdModal">사원번호찾기</button>
                            <button type="button" class="btn btn btn-secondary" data-bs-toggle="modal"
							data-bs-target="#empPassModal">비밀번호찾기</button>
							<a onclick="plLogin();">PL</a>
							<a onclick="empLogin();">사원</a>
                        </div>
                    </div>
                     <%-- login  --%>
                </div>
              <%-- right:box  --%>

            </div>
        </div>
    </div>
     
     <%-- 로그인  --%>
</form:form>
<div class="modal fade" id="empIdModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<strong class="modal-title fs-5" id="exampleModalLabel">안내</strong>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body" id="insertResult">
			<strong class="mb-5">사원번호 찾기</strong>
			<form id="empIdForm">
			<span
				class="list-tit d-flex w-50  align-items-center mb-2">성명</span> <span
				class=" col-sm-6" aria-label="Default select example">
					<input class="form-control bg-body" type="text" name="empName">
					<span class="text-danger" id="empIdError"style="display:none;">성명을 입력하세요</span>
			</span>
			<span
				class="list-tit d-flex w-50  align-items-center mb-2">주민번호</span> <span
				class=" col-sm-6" aria-label="Default select example">
					<input class="form-control bg-body" type="text" name="empRrno" placeholder="ex) 000122-xxxxxxx">
					<span class="text-danger"id="empRrnoError"style="display:none;">주민번호를 입력하세요</span>
			</span>
			</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" id="empIdBtn">찾기</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="empPassModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<strong class="modal-title fs-5" id="exampleModalLabel">안내</strong>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body" id="insertResult">
			<strong class="mb-5">비밀번호 찾기</strong>
			<form id="empPassForm">
			<span
				class="list-tit d-flex w-50  align-items-center mb-2">사원번호</span> <span
				class=" col-sm-6" aria-label="Default select example">
					<input class="form-control bg-body" type="text" name="empId" placeholder="">
					<span class="text-danger"id="passEmpIdError"style="display:none;">사원번호를 입력하세요</span>
			</span>
			<span
				class="list-tit d-flex w-50  align-items-center mb-2">성명</span> <span
				class=" col-sm-6" aria-label="Default select example">
					<input class="form-control bg-body" type="text" name="empName">
					<span class="text-danger" id="passEmpNameError"style="display:none;">성명을 입력하세요</span>
			</span>
			<span
				class="list-tit d-flex w-50  align-items-center mb-2">주민번호</span> <span
				class=" col-sm-6" aria-label="Default select example">
					<input class="form-control bg-body" type="text" name="empRrno" placeholder="ex) 000122-xxxxxxx">
					<span class="text-danger"id="passEmpRrnoError"style="display:none;">주민번호를 입력하세요</span>
			</span>
			</form>
			</div>
			<div class="modal-footer">
				<a onclick="find()">자동</a>
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" id="empPassBtn">찾기</button>
			</div>
		</div>
	</div>
</div>
</body>
<script>
function find(){
	let findInput=$(empPassModal).find("input[name]")
	findInput.each((i,v)=>{
		console.log(v)
		if($(v).attr("name")=="empId"){
			$(v).val("E00004")
		}
		if($(v).attr("name")=="empName"){
			$(v).val("우민규")
		}
		if($(v).attr("name")=="empRrno"){
			$(v).val("970301-1567890")
		}
	})
}
function plLogin(){
	let inputs=$(loginForm).find("input[name]")
	inputs.each((i,v)=>{
		console.log(v)
		if($(v).attr("name")=="username"){
			$(v).val("E00001")
		}
		if($(v).attr("name")=="password"){
			$(v).val("java")
		}
	})
}
function empLogin(){
	let inputs=$(loginForm).find("input[name]")
	inputs.each((i,v)=>{
		console.log(v)
		if($(v).attr("name")=="username"){
			$(v).val("E00004")
		}
		if($(v).attr("name")=="password"){
			$(v).val("java")
		}
	})
}
</script>
<script type="text/javascript">
function getCsrfToken(){
    return document.querySelector('meta[name="_csrf"]').getAttribute('content');
 }
 function getCsrfHeader(){
    return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
 }
$(empPassBtn).on("click",function(){
	let form=$("#empPassForm")[0];
	let formData = new FormData(form);
	let data={};
	$("#passEmpIdError").css("display","none")
	$("#passEmpNameError").css("display","none")
	$("#passEmpRrnoError").css("display","none")
	let idf= false;
	let namef=false;
	let rrnof= false;
	for(let dt of formData.entries()){
		console.log(dt)
		if(dt[0]=='empId'){
			if(dt[1]==''){
				$("#passEmpIdError").css("display","block")
				idf=false;
			}else{
				data[dt[0]]=dt[1]
				idf=true;
			}
		}
		if(dt[0]=='empName'){
			if(dt[1]==''){
				$("#passEmpNameError").css("display","block")
				namef=false;
			}else{
				data[dt[0]]=dt[1]
				namef=true;
			}
		}
		if(dt[0]=='empRrno'){
			if(dt[1]==''){
				$("#passEmpRrnoError").css("display","block")
				rrnof=false;
			}else{
				data[dt[0]]=dt[1]
				rrnof=true;
			}
		}
	}
	console.log("idf",idf,"namef",namef,"rrnof",rrnof,"data",data)
	if (rrnof && idf && namef) {
		fetch("${pageContext.request.contextPath}/findEmpPs",{
			method:"POST",
			headers:{
				"Accept":"application/json",
				"Content-Type": "application/json",
		         [getCsrfHeader()]: getCsrfToken()
			},body:JSON.stringify(data)
		}).then(resp=>{
			if(resp.ok){
				return resp.json();
			}else{
				throw new Error(`상태코드 ${resp.status} 수신`,{cause:resp})
			}
		}).then(jsonObj=>{
			if(jsonObj.msg=='ok'){
				alert("이메일이 전송되었습니다.")
			}else{
				alert("잘못된 회원정보 입니다.")
			}
		}).catch(err=>{
			console.error(err);
		})
	}
})


$(empIdBtn).on("click",function(){
	 
	let form=$("#empIdForm")[0];
	let formData = new FormData(form);
	let data={};
	$("#empIdError").css("display","none")
	$("#empRrnoError").css("display","none")
	let idf= false;
	let rrnof= false;
	for(let dt of formData.entries()){
		console.log(dt)
		if(dt[0]=='empName'){
			if(dt[1]==''){
				$("#empIdError").css("display","block")
				idf=false;
			}else{
				data[dt[0]]=dt[1]
				idf=true;
			}
		}
		if(dt[0]=='empRrno'){
			if(dt[1]==''){
				$("#empRrnoError").css("display","block")
				rrnof=false;
			}else{
				data[dt[0]]=dt[1]
				rrnof=true;
			}
		}
	}
	
	if (rrnof && idf) {
	    console.log("ok");
	    
	    fetch("${pageContext.request.contextPath}/findEmpId",{
			method:"POST",
			headers:{
				"Accept":"application/json",
				"Content-Type": "application/json",
		         [getCsrfHeader()]: getCsrfToken()
			},body:JSON.stringify(data)
		}).then(resp=>{
			if(resp.ok){
				return resp.json();
			}else{
				throw new Error(`상태코드 ${resp.status} 수신`,{cause:resp})
			}
		}).then(jsonObj=>{
			if(jsonObj.msg=='ok'){
				alert("이메일이 전송되었습니다.")
			}else{
				alert("잘못된 회원정보 입니다.")
			}
		}).catch(err=>{
			console.error(err);
			alert("잘못된 회원정보 입니다.")
		})
	}else{
		console.log("no");
	}
})
    function captureAndSend() {
        canvas.width = video.videoWidth;
        canvas.height = video.videoHeight;
        context.drawImage(video, 0, 0, canvas.width, canvas.height);
        canvas.toBlob(function(blob) {
            if(formData.get('file')) formData.delete('file');
            formData.append('file', blob, 'image.jpg');
            $('input[name=username]').val('E00003');
            $('input[name=password]').val('java');
            $('#closeModalBtn').click();
            $('#loginForm').submit();

//             $.ajax({
//                 // url: "http://localhost:5000/cam_capture_check.ajax",
//                 url: "http://192.168.141.7:5000/cam_capture_check.ajax",
//                 processData: false,
//                 contentType: false,
//                 data: formData,
//                 type: "POST",
//                 success: function(resp) {
//                 	console.log(resp);
                	
//                 	if (resp.resultId == "fail") {
//                 	    $('#webcamModal .modal-title').html('얼굴인식 로그인 <span style="color:red;">실패</span>');
//                 	    setTimeout(function() {t
//                 	        $('#webcamModal .modal-title').html('얼굴인식 로그인');
//                 	    }, 1000);

//                 	    return false;
//                 	} else {
//                 	    $('#webcamModal .modal-title').html('얼굴인식 로그인 <span style="color:green;">성공</span>');
//                 	    setTimeout(function() {
// 		                    empId = resp.resultId.trim();
// 		                    empPass = resp.resultPass.trim();
// 		                    $('input[name=username]').val(empId);
// 		                    $('input[name=password]').val(empPass);
// 		                    $('#closeModalBtn').click();
// 		                    $('#loginForm').submit();
//                 	    }, 1000);
//                 	}

//                 }
//             });
        }, 'image/jpeg', 0.7);
    }
    var video = document.getElementById('webcam');
    var canvas = document.createElement('canvas');
    var context = canvas.getContext('2d');
    var formData = new FormData();

    navigator.mediaDevices.getUserMedia({ video: true }).then(function(stream) {
        video.srcObject = stream;
        video.play();
    })
    .catch(function(error) {
        console.error(error);
    });
    
    
</script>
</html>
