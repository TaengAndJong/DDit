let cPath = document.body.dataset.contextPath;
function getCsrfToken() {
    return document.querySelector('meta[name="_csrf"]').getAttribute('content');
}
AOS.init();
function getCsrfHeader() {
    return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
}
function sendGetRequest(url) {
    const headers = {
        "Accept": "text/html",
        [getCsrfHeader()]: getCsrfToken()
    };

    return fetch(url, {
        method: "GET",
        headers: headers
    });
}

function sendPostRequest(url, data) {
    const password = data; // 사용자가 입력한 비밀번호
    const headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        [getCsrfHeader()]: getCsrfToken()
    };

    return fetch(url, {
        method: "POST",
        headers: headers,
        body: JSON.stringify({ password: password }) // 데이터를 객체로 감싸서 전송
    });
}

$(document).ready(function() {
    $(".chekPw").on("click", function(e) {
        e.preventDefault();
        const password = $("#password").val(); // 사용자가 입력한 비밀번호
        console.log(password);
        const url = cPath + "/chat/login";

        // 비밀번호를 서버로 전송하여 인증 요청 보내기
        sendPostRequest(url, password)
        .then(resp => {
            if (resp.ok) {
                return resp.json();
            } else {
                throw new Error(`상태코드 ${resp.status}`, { cause: resp });
            }
        }).then(jsonObj => {
            if(jsonObj === 'fail') {
				// 인증 실패 시 index 페이지로 이동
		        window.location.href = cPath + "/"; 
		    } else {
		        // 인증이 성공한 경우, 친구 목록을 업데이트하는 JSP 페이지를 호출
		        console.log(jsonObj);
				// 목록을 업데이트하는 JSP 페이지의 URL
		        const empListUrl = cPath + "/chat/chatEmpList";
		        return sendGetRequest(empListUrl);
   		}
        }).then(response => {
            return response.text();
        }).then(html => {
            // 성공적으로 데이터를 받아온 경우, 친구 리스트로 교체
            $('.chat_in').html(html);
		         $("<script/>", {
		              src: `${cPath}/resources/mypage/js/chatEmpList.js`,
		              type: "text/javascript"
		          }).appendTo("body");
        }).catch(err => {
            console.error(err);
        });
    });

$(document).ready(function() {


    // 채팅 닫기 버튼 클릭 시
    $(".close").on("click", function() {
        // chat-box에서 active 클래스 제거
        $("#chatBtn").removeClass("active");
    });
});
});