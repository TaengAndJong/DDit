$('a[data-val]').on('click',function(event){
	fetch(url,{
		method:'get',
		headers: {
        'Accept': 'application/json', // JSON을 원할 경우
		'Content-Type': 'application/x-www-form-urlencoded'
    	},body:data
	}).then(res=>{
		if(res.ok){
			return res.json()
		}else{
			throw new Error(`상태코드 {res.status}`,{cause:res})
		}
	}).then(jsonObj=>{
		console.log(jsonObj)
	}).catch(err=>console.log(err))
});


$(updateForm).on("submit",function(event){
	event.preventDefualt();
	let url=this.action;
	let method=this.method;
	let formData = new FormData(updateForm);
	let data = new URLSearchParams(formData);
	fetch(url,{
		method:method,
		headers: {
        'Accept': 'application/json', // JSON을 원할 경우
		'Content-Type': 'application/x-www-form-urlencoded'
    	},body:data
	}).then(res=>{
		if(res.ok){
			return res.json()
		}else{
			throw new Error(`상태코드 {res.status}`,{cause:res})
		}
	}).then(jsonObj=>{
		console.log(jsonObj)
	}).catch(err=>console.log(err))
	return false;
});