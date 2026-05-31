$(document).ready(function(){
	function getCsrfToken(){
		return document.querySelector('meta[name="_csrf"]').getAttribute('content');
	}
	function getCsrfHeader(){
		return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
	}
	
//복구 FUNCTION -> CHECKED항목을 PROID타입의 배열로 전송하여 처리
	$(restoreForm).on("submit", function(e){
		e.preventDefault();
		const checkboxes = document.querySelectorAll('.projectCheckbox:checked');
		const proIds = Array.from(checkboxes).map(checkbox => checkbox.closest('tr').querySelector('td:nth-child(2)').textContent);
		
		let arrayData=[];
		for(let i=0; i< proIds.length; i++){
			let data={};
				data.proId=proIds[i];
				arrayData.push(data);
		}
		
		let body =JSON.stringify(arrayData);
		
		fetch(restoreForm.action,{
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
		 		restoreResult.innerHTML = "선택된 항목이 없습니다.";
			} else if (jsonObj.msg == 'ok') {
	            restoreResult.innerHTML = "복구를 완료되었습니다.";
	        } else {
	            restoreResult.innerHTML = "복구에 실패했습니다.";
	        }
	        setTimeout(() => {
	            window.location.reload();
	        }, 1000);
		})
	})

//삭제 FUNCTION -> CHECKED항목을 PROID타입의 배열로 전송하여 처리
	$(deleteForm).on("submit", function(e){
		e.preventDefault();
		// Get selected project IDs
		const checkboxes = document.querySelectorAll('.projectCheckbox:checked');
		const proIds = Array.from(checkboxes).map(checkbox => checkbox.closest('tr').querySelector('td:nth-child(2)').textContent);
	

		// Add project IDs to form data
		let arrayData = [];
		for (let i = 0; i < proIds.length; i++) { 
		let data={};
			data.proId=proIds[i];
			arrayData.push(data);
		}
		
		let body=JSON.stringify(arrayData);
		
		fetch(deleteForm.action,{
			method:"DELETE",
			headers:{
				"accept":"application/json",
				"content-type":"application/json",
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
		 		deleteResult.innerHTML = "선택된 항목이 없습니다.";
			} else if (jsonObj.msg == 'ok') {
	            deleteResult.innerHTML = "삭제가 완료되었습니다.";
	        } else {
	            deleteResult.innerHTML = "삭제에 실패했습니다.";
	        }
	            setTimeout(() => {
	            window.location.reload();
	        }, 1000);
		})
	})
})