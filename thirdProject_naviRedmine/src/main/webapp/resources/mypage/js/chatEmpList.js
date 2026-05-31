/**
 * 현재 페이지의 기본 URI를 가져옵니다.
 */
	
function getCsrfToken(){
   return document.querySelector('meta[name="_csrf"]').getAttribute('content');
}

// CSRF 헤더를 가져오는 함수
function getCsrfHeader(){
   return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
}

$(document).ready(function() {
    // 채팅 닫기 버튼 클릭 시
    $(".close").on("click", function() {
        // chat-box에서 active 클래스 제거
        $("#chatBtn").removeClass("active");
    });
});

$("#chatForm").on("submit", function(event) {
	console.log(event)
   let url = this.action; // form의 action 속성을 가져옴
   let method = this.method; // form의 method 속성을 가져옴
   let listBody = document.querySelector("#listBody"); // listBody 요소를 가져옴
   event.preventDefault(); // 기본 동작 방지

   // fetch를 통해 데이터를 서버에 전송
   fetch(url, {
      method: "POST",
      headers: {
         "Accept": "application/json",
         [getCsrfHeader()]: getCsrfToken() // CSRF 헤더 추가
      }
   }).then(resp => {
      if (resp.ok) {
         return resp.json(); // JSON 형식의 응답을 반환
      } else {
         throw new Error("오류발생", { cause: resp }) // 오류 발생 시 에러 처리
      }
   }).then(jsonObj => {
		for (let e of jsonObj) {
			let imgSrc=document.body.dataset.contextPath+"/resources/images/prog/navi.jpg";
			if(e.base64Img!=null){
				imgSrc="data:image/*;base64,"+e.base64Img;
			}
			users.add({
				'empImg': '<img class="radius-img dataa" src="'+ imgSrc + '"data-emp-id="'+e.empId+'" data-room-id="'+e.roomId+'" data-name-id="'+e.empName+'">'
		        , 'empOne': e.empName + e.psName + '(' + e.deptName + ')'
				, 'lastChat': e.lastChat
				, 'lastChatSendDtStr' : e.lastChatSendDtStr
		 	});	
		}
   }).catch(err => {
      console.error(err) // 오류 출력
   }).finally(() => {
      // 빈 td 요소 숨기기
	var spanList = document.querySelectorAll('#users span');
	spanList.forEach(function(span) {
	    if (span.innerHTML.trim() === '') {
	        var li = span.parentNode.parentNode.parentNode; // <li> 요소 찾기
	        li.parentNode.removeChild(li); // <li> 요소 삭제
	    }
	});
   })
   return false; // 기본 동작 방지
})


function loadScript(){
	let options = { "valueNames": ["empName","empId", "empImg", "empOne", "roomId", "base64Img", "lastChatSendDtStr", "lastChat" ]} 
	users = new List('cstmrList', options)
	console.log($(chatForm))
	$("#chatForm").submit(); // chatForm 제출
}

loadScript();
