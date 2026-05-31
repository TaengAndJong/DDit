$(document).ready(function(){
	function getCsrfToken(){
		return document.querySelector('meta[name="_csrf"]').getAttribute('content');
	}
	function getCsrfHeader(){
		return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
	}
	
//복구 FUNCTION -> CHECKED항목을 PROID타입의 배열로 전송하여 처리
	$(inviteForm).on("submit", function(e){
		e.preventDefault();
		const checkboxes = document.querySelectorAll('.empCheckbox:checked');
		const empIds = Array.from(checkboxes).map(checkbox => checkbox.closest('tr').querySelector('td:nth-child(2)').textContent);
		let arrayData=[];
		for(let i=0; i< empIds.length; i++){
			let data={};
				data.empId=empIds[i];
				arrayData.push(data);
		}
		
		let body =JSON.stringify(arrayData);
		
		fetch(inviteForm.action,{
			method:"PUT",
			headers:{
				"accept": "application/json",
				"content-type": "application/json",
				[getCsrfHeader()]: getCsrfToken()
			},body:body
		}).then(resp=>{
			if(resp.ok){
				return resp.json()
			}else{
				throw new Error("상태코드 "+resp.status)
			}
		}).then(jsonObj=>{
			console.log(jsonObj)
	         if (jsonObj.msg == 'empty'){
		 		inviteResult.innerHTML = "선택된 사원이 없습니다.";
			} else if (jsonObj.msg == 'ok') {
	            inviteResult.innerHTML = "해당사원을 초대하였습니다.";
	        } else {
	            inviteResult.innerHTML = "초대에 실패했습니다.";
	        }
	        setTimeout(() => {
	            window.location.reload();
	        }, 1000);
		})
	})
})