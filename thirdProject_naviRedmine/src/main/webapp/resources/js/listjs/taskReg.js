/**
 * 
 */
 // 모든 cbtn 요소를 가져옵니다.
    document.addEventListener("click", function(event) {
      // 클릭된 요소가 cbtn 클래스를 가지고 있는지 확인합니다.
      if (event.target.classList.contains("cbtn")) {
        // 모든 cbtn 요소를 가져옵니다.
        var cbtns = document.querySelectorAll(".cbtn");

        // 클릭된 버튼에만 active 클래스를 추가하고 나머지 버튼들의 active 클래스를 제거합니다.
        cbtns.forEach(function(btn) {
          btn.classList.remove("btn-secondary");
		btn.classList.add("btn-primary")
        });
        event.target.classList.add("btn-secondary");
      }
	if (event.target.classList.contains("tbtn")) {
	        // 모든 cbtn 요소를 가져옵니다.
	        var tbtn = document.querySelectorAll(".tbtn");
	
	        // 클릭된 버튼에만 active 클래스를 추가하고 나머지 버튼들의 active 클래스를 제거합니다.
	        tbtn.forEach(function(btn) {
	          btn.classList.remove("btn-secondary");
			btn.classList.add("btn-primary")
	        });
	        event.target.classList.add("btn-secondary");
	      }
    });
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
	console.log(url+"/list/"+proId)
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
		console.log("팀원조회",jsonObj)
		for (let team of jsonObj.teamVOList) {
				mberList.add({
					'empId':team.empId,
					'empName':team.emp.empName,
					'deptName':team.emp.deptName,
					'roleName':team.roleId,
					'select':`<a data-emp-name="${team.emp.empName}" data-emp-id="${team.empId}" class="btn btn-primary tbtn" onclick="select(this);">선택</a>`
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
$("#submitForm1").on("submit", (event) => {
	event.preventDefault();
	let url = submitForm1.action;
	let method = form.method;
	let proId=$(insertModal).data("proId");
	let listBody1 = document.querySelector("#listBody1");
	fetch(url ,{
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
		for (let task of jsonObj) {
				tsList.add({
					'taskId':task.taskId,
					'taskName':task.taskTitle,
					'taskManName':task.taskManEmp.empName+"("+task.taskManEmp.deptName+","+task.taskManEmp.psName+")",
					'btn':`<button data-task-id="${task.taskId}" class="btn btn-primary cbtn" onclick="selectTask(this);">선택</button>`
				});					
			}
	}).catch(err => {
		console.error(err)
	}).finally(() => {
		var tdList = document.querySelectorAll('#taskModal td');
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
	let $inputTag = $("#insertForm input[name='taskManId']");
	let empNames = $(el).data("empName")
	let empId = $(el).data("empId")
	console.log($inputTag)
	console.log(empNames)
	console.log(empId)
	$inputTag.val(empId)
	$(empName).val(empNames)
}
function selectTask(el){
	let taskId=$(el).data("taskId");
	$(taskTopId).val(taskId);
	taskTop.innerHTML=taskId;
	if($(el).hasClass("btn-primary")){
		$(el).removeClass("btn-primary")
		$(el).addClass("btn-secondary")
	}else{
		$(el).removeClass("btn-secondary")
		$(el).addClass("btn-primary")
	}
}
$(insertBtn).on("click",function(e){
	let data={};
	let formData= new FormData(insertForm);
	let editor=$(insertForm).data("taskModEitor");
	for(let n of formData.keys()){
		data[n]=formData.get(n)
	}
	for (var pair of formData.entries()) {
        let input = document.createElement('input');
        input.type = 'hidden';
        input.name = pair[0];
        input.value = pair[1];
		if(pair[0]=="taskCn"){
			continue;
		}
		form.appendChild(input);
		console.log(pair)
        
    }
	$(taskCn).val(editor.getData())
	console.log(taskCn)
//	console.log($(".edit").find("[name]"))
	$(insertForm).submit();
})
$(modalBtn).on("click",function(e){
	console.log(e.target)
	
})

document.addEventListener("DOMContentLoaded", () => {
	let options = { "valueNames": ["empId","empName", "deptId", "roleName", "select"], "filter":{"key":"empId"}} 
	let options1 = { "valueNames": ["taskId","taskName", "taskManName","btn"], "filter":{"key":"taskId"} } 
	mberList = new List('cstmrList', options)
	tsList = new List('taskList', options1)
	$("#submitForm").submit();
	$("#submitForm1").submit();
})
	
	

	



