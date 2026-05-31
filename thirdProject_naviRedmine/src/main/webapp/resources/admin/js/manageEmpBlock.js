$(document).ready(function(){
	function getCsrfToken(){
		return document.querySelector('meta[name="_csrf"]').getAttribute('content');
	}
	function getCsrfHeader(){
		return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
	}
	
	$(blockForm).one("submit",function(e){
		e.preventDefault();
		
		const checkboxes = document.querySelectorAll('.empCheckbox:checked');
		const empIds = Array.from(checkboxes).map(checkbox=>checkbox.closest('tr').querySelector('td:nth-child(2)').textContent);
		
		let arrayData=[];
		for(let i=0; i< empIds.length; i++){
			let= data={};
				data.empId=empIds[i];
				arrayData.push(data);
		}
		
		let body = JSON.stringify(arrayData);
		
		fetch(blockForm.action,{
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
	            deleteResult.innerHTML = "차단이 완료되었습니다.";
	        } else {
	            deleteResult.innerHTML = "차단에 실패했습니다.";
	        }
	        setTimeout(() => {
	            window.location.reload();
	        }, 1000);
		})
	})
	
	
	$(restoreForm).one("submit",function(e){
		e.preventDefault();
		
		const checkboxes = document.querySelectorAll('.empCheckbox:checked');
		const empIds = Array.from(checkboxes).map(checkbox=>checkbox.closest('tr').querySelector('td:nth-child(2)').textContent);
		
		let arrayData=[];
		for(let i=0; i< empIds.length; i++){
			let= data={};
				data.empId=empIds[i];
				arrayData.push(data);
		}
		
		let body = JSON.stringify(arrayData);
		
		fetch(restoreForm.action,{
			method:"PUT",
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
		 		restoreResult.innerHTML = "선택된 항목이 없습니다.";
			} else if (jsonObj.msg == 'ok') {
	            restoreResult.innerHTML = "차단 해제되었습니다.";
	        } else {
	            restoreResult.innerHTML = "해제에 실패했습니다.";
	        }
	        setTimeout(() => {
	            window.location.reload();
	        }, 1000);
		})
	})
	
})