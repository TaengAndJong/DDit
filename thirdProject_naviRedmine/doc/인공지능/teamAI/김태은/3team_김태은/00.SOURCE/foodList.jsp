<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<link rel="stylesheet" href='<c:url value="/resources/css/voice/voice.css"/>'>
<%-- 추천모달버튼 --%>
<div class="d-flex justify-content-end">
	<button type="button" class="btn btn-primary mb-3" id="openModalBtn"
		data-bs-toggle="modal" data-bs-target="#recomModal">음식추천</button>
</div>
<%-- 추천모달버튼 --%>
<%-- ${recomList} --%>
<%-- 추천모달 --%>
<div class="modal fade recomModal" id="recomModal" tabindex="-1"
	aria-labelledby="recomModal" aria-hidden="true">

	<div class="modal-dialog modal-fullsize">
		<div class="modal-content" >
			<div class="modal-header bg-primary text-white">
				<strong class="modal-title">음식추천</strong>
			</div>
			<div class="modal-body" id="modalRecom">
				<!-- modal con -->
				<div class="row row-cols-3 g-4 list  common_list recomList" id="resultFoodRecom">
			
				<c:forEach items="${recomList}" var="recomList">
							<a href="<c:url value='/quick/food/${recomList.foodId}'/>" > 
								<div class="col">
								
									<div class="card">
									
										<div class="photo_img">
											<div class="img-in">
												<img src="${recomList.foodImgUrl}" class="card-img-top" alt="${recomList.foodPlace}${recomList.foodName}">
											</div>
										</div>
										<div class="card-body">
											<strong class="card-title">
												<em class="text-elipsis">${recomList.foodName}</em>
											</strong>
											<ul class="card-footer d-flex justify-content-between border-0 py-0">
												<li>
													<span>
														<i class="icon market_b"><em class="sr-only">음식점</em></i>
														${recomList.foodPlace}
													</span>
												</li>
											</ul>
										</div>
										
									</div>
								
								</div> 
							</a>
							
						</c:forEach> 
					</div>
				
			</div>
			<div class="modal-footer justify-content-center">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<%-- 추천모달  --%>

<%--음성 검색--%>
<form id="searchForm" action="<c:url value='/quick/food'/>">
	<input type="number" name="page" />
	<input type="text" name="searchWord" >
</form>

<div data-pg-role="searchUI" data-pg-target="#searchForm" class="searchBox d-flex justify-content-end">
		
		<div class="fieldset flex">
			<div class="msgBox">
				<div class="msg_inner">
					<p id="message"></p>
					<span>음성 인식 완료 후 검색버튼을 눌러주세요.</span>
				</div>
			</div>
			<input  id="result" class="me-1" type="text" name="searchWord"
			 title="음식 입력"  placeholder="검색어 입력" value="">
			<button id="speech" class="btn btn-danger me-1"  type="button" >음성입력</button>
			<button type="button" class="btn btn-secondary" data-pg-role="searchBtn">검색</button>
		</div>
			
</div>
<%--음성 검색--%>

<div class="row row-cols-2 row-cols-md-4 g-4 list mb-4 common_list recomList" id="foodRecomList">
	
<c:choose>
	<c:when test="${not empty foodList}">
		<c:forEach items="${foodList}" var="food">
			<!-- col -->
				<a href="<c:url value='/quick/food/${food.foodId}'/>"  class="recomfood"> 
					<div class="col">
					<%-- 카드 --%>
						<div class="card">
							<%-- 	<span class="category weather">${todayWeather.weatherId}</span> --%>
							<div class="photo_img">
								<div class="img-in">
									<img src="${food.foodImgUrl}" class="card-img-top" alt="${food.foodPlace}${food.foodName}">
								</div>
							</div>
							<div class="card-body">
								<strong class="card-title">
									<em class="text-elipsis">${food.foodName}</em>
								</strong>
								<ul class="card-footer d-flex justify-content-between border-0 py-0">
									<li>
										<span>
											<i class="icon market_b"><em class="sr-only">음식점</em></i>
											${food.foodPlace}
										</span>
									</li>
									<li>
										<span>
											<i class="icon see_b"><em class="sr-only">조회수</em></i>
											<em class="seenum">0</em>
										</span>
									</li>
								</ul>
							</div>
							
						</div>
						<%-- 카드 --%>
					</div> 
				</a>
				<!-- col -->
			</c:forEach>
	</c:when>
	<c:otherwise>
		<div class="nodata text-center GmarketSans"> 검색조건에 맞는 데이터가 없습니다.
			<span class="mt-2 GmarketSans d-block">다시 검색해 주세요!</span>
		</div>
		
	</c:otherwise>
</c:choose>


</div>


${pagingHTML }

<%-- 추천모달버튼 --%>


<script type="text/javascript">

$(function() {
    var msgBox = document.querySelector(".msgBox");
    var message = document.querySelector("#message");
    var button = document.querySelector("#speech");
    var obj_result = document.querySelector("#result");

    var isRecognizing = false;
    if ('SpeechRecognition' in window) {
        // Speech recognition support. Talk to your apps! 
        console.log("음성인식을 지원하는 브라우저입니다.")
    }
    try {
        var recognition = new (window.SpeechRecognition
                || window.webkitSpeechRecognition
                || window.mozSpeechRecognition || window.msSpeechRecognition)();
    } catch (e) {
        console.error(e);
    }
    recognition.lang = 'ko-KR'; //선택하게 해줘야 할듯 . 
    recognition.interimResults = false;
    recognition.maxAlternatives = 5;
    //recognition.continuous = true;

    function speech_to_text() {
        recognition.start();
        isRecognizing = true;
        
        recognition.onstart = function(event) {
            //음성인식 클릭시 초기검색어 리셋
            obj_result.value="";
            console.log("2,음성인식이 시작, onstart");
            msgBox.classList.add("visible");
            message.innerHTML = "음성인식 시작";
            button.innerHTML = "인식중";
            button.disabled = true;
             return event;
        }

        recognition.onend = function(event) {
            console.log("onend 끝");
            
            if(obj_result.value.length == 0){
                console.log("onend 끝");
                message.innerHTML = "검색어 재입력";
                button.disabled = false;
                button.innerHTML = "음성입력";
                isRecognizing = false;
            }
        }

        recognition.onresult = function(event) {
            var resText = event.results[0][0].transcript;
            obj_result.value = resText;
            text_to_speech(resText);
            
            message.innerHTML = "검색어 인식완료";
            button.disabled = false;
            button.innerHTML = "음성입력";
            isRecognizing = false;
            setTimeout(function() {
                msgBox.classList.remove("visible");
            }, 2000);
            
            return false;
        };

        return false;
    }

    function stop() {
        console.log("6, stop");
        msgBox.classList.remove("visible");
        recognition.stop();
    }

    function text_to_speech(txt) {
        if ('speechSynthesis' in window) {
            console.log("음성합성을 지원하는  브라우저입니다.");
        }
        var msg = new SpeechSynthesisUtterance();
        var voices = window.speechSynthesis.getVoices();
        msg.voiceURI = 'native';
        msg.volume = 1; // 0 to 1 
        msg.rate = 1.3; // 0.1 to 10 
        msg.text = txt;
        msg.lang = 'ko-KR';
        msg.onend = function(e) {
            console.log('Finished in ' + event.elapsedTime + ' seconds.');
        };
        window.speechSynthesis.speak(msg);
    }

    // 버튼 클릭 이벤트 핸들러 추가
    $(button).on("click", function() {
        speech_to_text();
    });

});

</script>
<script src='<c:url value="/resources/js/common/paging.js"/>'></script>

	

