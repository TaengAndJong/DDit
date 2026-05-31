let val;
$("[name='btn']").on('click',function(){
	let valuescore=$(this).siblings().val()
	let valuest=$(this).data("st")
	val=valuest;
	if(valuescore>100 || valuescore<1){
		return false;
	}else{
		
		$(scoreForm).find('input[name="clsScore"]').val(valuescore)
		$(scoreForm).find('input[name="stdNo"]').val(valuest)
		$(scoreForm).submit();
	}
});

$(scoreForm).on('submit',function(event){
	event.preventDefault();
	let url=scoreForm.action;
	console.log(url)
	let method=scoreForm.method;
	let formData = new FormData(scoreForm);
	let data=new URLSearchParams(formData);
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
		$('td[data-result='+val+']').text(jsonObj["message"])
	}).catch(err=>console.log(err))
	return false;
});