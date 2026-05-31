$(document).ready(function(){
	

	const sse = new EventSource("/navi/connect");
	
	sse.addEventListener('connect', (e) => {
		const { data: receivedConnectData } = e;
		console.log('connect event data: ',receivedConnectData);  // "connected!"
	});
	sse.addEventListener('count', e => {
	    const { data: receivedCount } = e;  
	    console.log(receivedCount);
	    let mg=receivedCount.replace(/"/g, "");
	 // 문자열을 HTML 요소로 변환
	    let tempElement = document.createElement('div');
	    tempElement.innerHTML = mg;
		$(".alarmlist")[0].innerHTML+=mg
		let cnt = parseInt(alramListCnt.innerHTML)
		console.log(cnt)
		if(isNaN(cnt)){
			cnt++;
			alramListCnt.innerHTML=cnt
		}
	    // 변환된 HTML 요소를 가져오기
	    let liTag = tempElement.firstChild;
	    let aTag = liTag.firstChild;
	    console.log("aaaaaa", $(aTag).attr("href"));
		$("#alram-body").html(mg)
		$("#liveToast").show()
		
		setTimeout(function() {
			$("#liveToast").hide()
		    console.log('이 함수는 10초 후에 실행됩니다.');
		}, 10000);
	});
	
	sse.addEventListener('login', e => {
	    const { data: receivedMessage  } = e;  
	    console.log("receivedMessage ", receivedMessage );
		
	    let mg=receivedMessage.replace(/\\/g, "").replace(/"/g, "");
	 // 문자열을 HTML 요소로 변환
	    let tempElement = document.createElement('div');
	    tempElement.innerHTML = mg;
		$(".alarmlist")[0].innerHTML+=mg
		let cnt = parseInt(alramListCnt.innerHTML)
		console.log(cnt)
		if(isNaN(cnt)){
			cnt++;
			alramListCnt.innerHTML=cnt
		}
	    // 변환된 HTML 요소를 가져오기
	    let liTag = tempElement.firstChild;
		$("#alram-body").html(mg)
		$("#liveToast").show()
		$("#liveToast").click(function() {
			$("#chatBtn").addClass("active");
	    });
		setTimeout(function() {
			$("#liveToast").hide()
		    console.log('이 함수는 10초 후에 실행됩니다.');
		}, 10000);
	});
	
	sse.addEventListener('chat', e => {
 		const { data: receivedMessage  } = e;  
		const parsedData = JSON.parse(receivedMessage);
		const data = JSON.parse(parsedData)
		
		const message = data.notificationMessage;
		const roomId = data.roomId;
		const username = data.username;
		
	    // 예시: 채팅 메시지를 화면에 출력하는 등의 처리 수행
	    let mg = message.replace(/\\/g, "").replace(/"/g, "");
	 // 문자열을 HTML 요소로 변환
	    let tempElement = document.createElement('div');
	    tempElement.innerHTML = mg;
		$(".alarmlist")[0].innerHTML+=mg
		let cnt = parseInt(alramListCnt.innerHTML)
		console.log(cnt)
		if(isNaN(cnt)){
			cnt++;
			alramListCnt.innerHTML=cnt
		}
	    // 변환된 HTML 요소를 가져오기
	    let liTag = tempElement.firstChild;
		$("#alram-body").html(mg)
		$("#liveToast").show()
		
		$("#liveToast").click(function() {
			console.log("roomId", roomId);
			$("#roomId").val(roomId);
			$("#username").val(username);
			openChatRoom(roomId);
	    });

		setTimeout(function() {
			$("#liveToast").hide()
		    console.log('이 함수는 10초 후에 실행됩니다.');
		}, 10000);
	});
	
	function getCsrfToken(){
	    return document.querySelector('meta[name="_csrf"]').getAttribute('content');
	 }
	 function getCsrfHeader(){
	    return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
	 }
	let context=$("body").data("contextPath")
	fetch(context+"/index.do/alram",{
		method:"GET",
		headers:{
			"Accept":"application/json"
		}
	}).then(resp=>{
		if(resp.ok){
			return resp.json();
		}else{
			throw new Error(`상태코드 ${resp.status} 수신`,{cause:resp})
		}
	}).then(jsonObj=>{
		console.log("jsonObj : ",jsonObj.length);
		if(jsonObj.length==0){
			$(".alarmlist")[0].innerHTML+=' <li><a href="#">새로운 알림이 없습니다.</a></li>'
				alramListCnt.innerHTML='0'
		}else{
			console.log(jsonObj)
			for(let al of jsonObj){
				let cn=al["altypeCn"]
				if(al["alCn"]!=null){
					cn=al["alCn"]
				}
				let alarm='<li><a class="alram-item" data-id="'+al["alarmId"]+'" href="'+context+al["alMoveUrl"]+'">'+cn+'<i class="icon new_icon"></i> </a></li>'
				$(".alarmlist")[0].innerHTML+=alarm
			}
			if(jsonObj.length>=10){
				alramListCnt.innerHTML="10+"
			}else{
				alramListCnt.innerHTML=jsonObj.length+""
			}
		}
	}).catch(err=>{
		console.error(err);
	}).finally(()=>{
		$(".alram-item").on("click",function(e){
			e.preventDefault();
			let alId=$(e.target).data("id");
			console.log(alId)
			fetch(context+"/index.do/alram?alId="+alId,{
				method:"POST",
				headers:{
					"Accept":"application/json",
					 [getCsrfHeader()]: getCsrfToken()
				}
			}).then(resp=>{
				if(resp.ok){
					return resp.json();
				}else{
					throw new Error(`상태코드 ${resp.status} 수신`,{cause:resp})
				}
			}).then(jsonObj=>{
				console.log(jsonObj)
			})
			
			let lo=$(e.target).attr("href");
			location.href=lo
		})
	})
	
})