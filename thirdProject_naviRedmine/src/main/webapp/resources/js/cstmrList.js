/**
 * 
 */
const baseURI = window.location.href
let form = document.querySelector("#submitForm")
const cPath = document.body.dataset.contextPath;
   function getCsrfToken(){
      return document.querySelector('meta[name="_csrf"]').getAttribute('content');
   }
   function getCsrfHeader(){
      return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
   }
$("#submitForm").on("submit", (event) => {
	event.preventDefault();
	let url = form.action;
	let method = form.method;
	let proId=$(insertModal).data("proId");
	let listBody = document.querySelector("#listBody");
	fetch(url+"/list/"+proId, {
		method: "POST",
		headers: {
			"Accept": "application/json",
			[getCsrfHeader()]: getCsrfToken()
		}
	}).then(resp => {
		if (resp.ok) {
			return resp.json();
		} else {
			throw new Error("오류발생", { cause: resp })
		}
	}).then(jsonObj => {
		console.log(jsonObj)
		for (let team of jsonObj) {
				mberList.add({
					'empId':team.empId,
					'empName':team.emp.empName,
					'deptName':team.emp.deptName,
					'roleName':team.roleId,
					'select':`<button data-emp-Id="${team.empId}" data-emp-name="${team.emp.empName}" class="btn-btn-primary" onclick="select(this);">담당자 변경</button>`
				});					
			}
	}).catch(err => {
		console.error(err)
	}).finally(() => {
		var tdList = document.querySelectorAll('#insertModal td');
        tdList.forEach(function(td) {
            if (td.innerHTML.trim() === '') {
                td.style.display = 'none';
            }
 		});
	})

	return false;

})
$(".empId").on("click",function(e){
	console.log(e.target)
	
})
function select(el){
	let $inputTag = $("#modifyForm input[name='taskManId']");
	let empNames = $(el).data("empName");
	let empId = $(el).data("empId");
	console.log($inputTag)
	console.log(empNames)
	console.log(empId)
	$inputTag.val(empId)
	empName.innerHTML=empNames
}
$(modifyBtn).on("click",function(e){
	let data={};
	let formData= new FormData(modifyForm);
	let editor=$(modifyForm).data("taskModEitor");
	$(".edit").find("[name]").each((y, el) => {
	    let name = $(el).attr("name");
	    let value = $(el).val();
		if(name!="bpAttchFile"){
		    formData.append(name, value);
			console.log(name,value)
		}
	});
	formData.append("taskCn",editor.getData())
	
//	for(let n of formData.keys()){
//		data[n]=formData.get(n)
//	}
//	data["taskCn"]=editor.getData()
//	let body=JSON.stringify(data);
	console.log(addFileInput.files)
	for(let file of addFileInput.files){
		formData.append("bpAttchFile",file)
	}
	for(let a of formData.entries()){
		console.log(a)
	}
	fetch(modifyForm.action,{
		method:"POST",
		headers:{
			"accept":"application/json",
//			"content-type":"application/json",
			[getCsrfHeader()]: getCsrfToken()
		},body:formData
	}).then(resp=>{
		if(resp.ok){
			return resp.json()
		}else{
			throw new Error("상태코드 "+resp.status)
		}
	}).then(jsonObj=>{
		let taskId=$(modifyForm).find("input[name='taskId']").val();
		let proId=$(insertModal).data("proId");
		console.log(jsonObj)
		if(jsonObj.msg=='ok'){
			updateResult.innerHTML="수정이 완료되었습니다."
			window.location.pathname=cPath+'/project/task/'+proId+'/'+taskId
		}else{
			updateResult.innerHTML="수정에 실패했습니다.."
		}
	})
})
$(modalBtn).on("click",function(e){
	console.log(e.target)
	
})

document.addEventListener("DOMContentLoaded", () => {
	let options = { "valueNames": ["check","empId", "empName", "deptId", "roleId"], "filter":{"key":"empId"}, "page": 10, "pagination": true } 
	mberList = new List('cstmrList', options)
	$("#submitForm").submit();
})
	
	

	



