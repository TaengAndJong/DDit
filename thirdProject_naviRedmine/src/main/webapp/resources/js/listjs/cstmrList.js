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
	let url = submitForm.action;
	console.log(url)
	let listBody = document.querySelector("#listBody");
	fetch(url, {
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
		for (let emp of jsonObj) {
				mberList.add({
					'empId':emp.empId,
					'empName':emp.empName,
					'deptName':emp.deptName,
					'ROLE':`<select data-emp-Id="${emp.empId}" onChange="selectRole(this);" data-emp-name="${emp.empName}" disabled class="form-select">
					<option value="">권한설정</option>
					<option value="ROLE_AA">AA</option>
					<option value="ROLE_DA">DA</option>
					<option value="ROLE_BA">BA</option>
					<option value="ROLE_TA">TA</option>
					<option value="ROLE_UA">UA</option>
					</select>`,
					'select':`<button class='selectBtn btn btn-primary'  data-emp-Id='${emp.empId}' onClick='selectTeam(this);'>선택하기</button>`
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
$('#regBtn').on('click', function(e) {
    e.preventDefault();
    
    // 선택된 사원의 empId를 담을 배열
    var selectedEmpIds = [];
    // 선택된 사원의 roleId를 담을 배열
    var selectedRoleIds = [];
    
    // 각 체크박스를 순회하며 선택된 사원 정보를 가져옴
    $('.cal-Modal_table tbody input[type="checkbox"]:checked').each(function() {
        var empId = $(this).attr('data-emp-id');
        var roleId = $(this).closest('tr').find('select').val();
        
        // empId와 roleId를 각각 배열에 추가
        selectedEmpIds.push(empId);
        selectedRoleIds.push(roleId);
    });
    for(let data of goData){
		selectedEmpIds.push(data["empId"])
		selectedRoleIds.push(data["roleId"]);
	}
    // 선택된 사원 정보를 콘솔에 출력 (테스트용)
    console.log('선택된 사원의 empId:', selectedEmpIds);
    console.log('선택된 사원의 roleId:', selectedRoleIds);
    
    // 선택된 사원 정보를 hidden input 필드에 설정
    $('#empIds').val(selectedEmpIds.join(','));
    $('#roleIds').val(selectedRoleIds.join(','));
	let editor=$(regBtn).data("editor")
    $(proDesc).val(editor.getData());
    // 폼 서브밋
    $('#rgForm').submit();
});
$(".empId").on("click",function(e){
	console.log(e.target)
})
let goData=[];
function selectRole(e){
	let data={};
	let empId = $(e).data("empId");
	let roleId=$(e).val();
	console.log(empId,roleId)
	data["empId"]=empId;
	data["roleId"]=roleId;
	if(goData.length==0){
		goData.push(data)
	}else{
		var cnt=0;
		for(let dt of goData){
			console.log(dt)
			if(dt["empId"]==data["empId"]){
				cnt++;
				dt["roleId"]=data["roleId"]
			}
		}
		if(cnt==0){
			goData.push(data)
		}
	}
	
	console.log(goData)
}
function selectTeam(button){
// 클릭한 버튼의 부모 요소를 찾아 해당 행(tr)을 가져옵니다.
   var row = $(button).closest('tr');
	let empId=$(button).data("empId");
	console.log(mberList.get("empId",empId))
    // 이하 코드는 이전과 동일합니다.
    var selectElement = row.find('select');
    selectElement.prop('disabled', false);
}
document.addEventListener("DOMContentLoaded", () => {
	let options = { "valueNames": ["empId", "empName","deptName", "ROLE","select"], "filter":{"key":"empId"},"page":10, "pagination": true } 
	mberList = new List('cstmrList', options)
	$("#submitForm").submit();
	var listFilter = document.querySelector('[data-list-filter]');
	var key = options.filter.key;
})
	
	

	



