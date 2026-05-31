function getCsrfToken(){
	return document.querySelector('meta[name="_csrf"]').getAttribute('content');
	}
function getCsrfHeader(){
	return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
}
	let todayListTableEl=$("#todaylistTable")
	todayListTableEl.find(".checkAll").on('change',function(e){
		let isChecked = $(this).prop('checked');
		$("#todaylist-tbody input[type='checkbox']").prop('checked', isChecked);
	})

//체크박스 전체, 개별클릭 
function checkbox(checkall,tableClass) {
    let checkAll = $(checkall);
    let checkboxes = $(tableClass).find("input[type='checkbox']"); //테이블내부의 체크박스 
    let checked = checkboxes.prop("checked");
    checkAll.attr("title", "");
    checkboxes.attr("title", "");
    
    console.log("checkAll",checkAll);
    //여기서 체크박스가 다 선택된 경우 체크해제 해줘야함

	//체크가 되어있지 않을 경우! 실행하게 
    checkAll.on("click", function() {
        let checked = $(this).prop("checked");
        $(this).attr("title", checked ? "체크" : "체크해제");
        
        checkboxes.on(function() { // 전체에 대한 선택 동시 변경
            checkboxes.prop("checked", checked);
            checkboxes.attr("title", checked ? "체크" : "체크해제");
        });
    });

    checkboxes.each(function() {
        $(this).on("click", function() {
            let checked = $(this).prop("checked");
            $(this).attr("title", checked ? "체크" : "체크해제");
        });
    });

    return checkboxes;
}

function checkReset(checkTable){
	//해당 모달의 체크박스 전부 해제하기 
	let ckgroup = $(checkTable).find("input[type='checkbox']");
	console.log("ckgroup",ckgroup);
	//모달 닫히면 내부의 체크박스 초기화하기
	ckgroup.each(function() {
	    $(this).prop("checked", false);
	});
	
}

//클릭된 체크박스를 전송 폼에 추가하는 메소드
function addCheckInput(data, checkboxForm) { // data는 테이블 내부의 체크박스들
	console.log("data",data);
	console.log("checkboxForm",checkboxForm);
	
    data.each(function(idx) {

        // 조회된 체크박스가 체크될 때마다 동적으로 submit할 input 박스 추가
        $(this).on("change", function() {
            // 체크박스의 상태가 변경될 때마다 실행되는 코드
            let isChecked = $(this).prop("checked");
            let value = $(this).attr("id");

            if ($(this).hasClass("checkAll")) { // checkAll 클릭 시
                // checkAll 했을 경우 전체 인풋 찾아서 checkboxForm에 넣기
                data.filter(".checkbox").prop("checked", isChecked);
                data.filter(".checkbox").each(function() {
                    let checkboxValue = $(this).attr("id");
                    if (isChecked) {
                        // 체크된 경우에는 해당 체크박스의 입력란을 추가합니다.
                        checkboxForm.innerHTML += `<input type="hidden" name="taskId" value="${checkboxValue}">`;
                    } else {
                        // 체크가 해제된 경우 해당 체크박스의 입력란을 삭제합니다.
                        $(`input[type='text'][value='${checkboxValue}']`).remove();
                    }
                });
            }

            if ($(this).hasClass("checkbox")) {
                // 나머지 체크박스의 경우 개별적으로 처리합니다.
                if (isChecked) {
                    // 체크된 경우에는 해당 체크박스의 입력란을 추가합니다.
                    checkboxForm.innerHTML += `<input type="hidden" name="taskId" value="${value}">`;
                } else {
                    // 체크가 해제된 경우 해당 체크박스의 입력란을 삭제합니다.
                    $(`input[type='text'][value='${value}']`).remove();
                }
            }

        });
    });
}


//체크박스 함수실행
//1번 searchBox , 2번 전송할 데이터 셀렉팅

function addTrasnform(searchBox, select, inputText, form) {
    let searchboxTag = $(searchBox);
    let targetSelect = searchboxTag.find(select); // select 요소 찾기
    let targetInput = searchboxTag.find(inputText); // input 요소 찾기
 	let searchForm = $(form);
    console.log("targetSelect", targetSelect);
    console.log("targetInput", targetInput);

    targetSelect.each(function () {
	 	
      $(this).on("change", function () {
		    console.log("변경 중");
		    console.log("this", $(this));
		    let targetName = $(this).attr("name");
		    let existingInput = searchForm.find(`input[name='${targetName}']`);
		    if ($(this).val() && $(this).val().trim() !== '') { // 값이 존재하고 공백이 아닌 경우
		        let targetValue = $(this).val();
		        if (existingInput.length) { // 이미 해당 필드가 존재하면 값을 업데이트
		            existingInput.val(targetValue);
		        } else { // 존재하지 않으면 새로운 input을 추가
		            searchForm.append(`<input type='text' value='${targetValue}' name='${targetName}'>`);
		        }
		    } else { // 값이 없는 경우 해당 필드를 삭제
		        existingInput.remove();
		    }
		});
    });

	//input은 입력할 때마다 검색 , 검색어 전체 입력완료시 blur
    targetInput.on("input", function () {
        console.log("글자입력중");
 		console.log("this", $(this));
		let targetValue = $(this).val();
        let targetName = $(this).attr("name");
  		 searchForm.append(`<input type='text' value='${targetValue}' name='${targetName}'>`);
    });
}



let checkboxForm2 = document.querySelector('#checkboxForm2');
let cPath = document.body.dataset.contextPath;
const todoListModal = document.getElementById('todoListModal');
 let asynBody = document.querySelector('#asynBody');

$(":input[data-pg-init-value]").each(function(index, input) {
    let $input = $(input);
    let initValue = $input.data("pgInitValue");
    $input.val(initValue);
});


//list.JS



//모달이 있으면 열릴때

let options = {
                "valueNames": ['check','rnum', 'taskId','tsNameCon','taskTitle','empName','tpsName','tpsIng','taskRegDtStr'],
				"filter":{"key":"taskId"}
				   };
	
let taskList=new List(asynBody, options);

todoListModal.addEventListener('show.bs.modal', event => {
    let checkboxForm = document.querySelector('#checkboxForm');
 
      
            
	
    checkReset("#modalTable");
    // 모달 전송폼 초기화
    checkboxForm.innerHTML='';
    //console.log('폼 초기화 완료')
//	 $(todoListModal).on('hidden.bs.modal', function () {
//		console.log(1111)
// 		taskList=null;
//		})

	    //비동기 호출 후 실행되어야 할 코드를 함수로 분리
	    function modalAllList (JsonObj) {
		taskList.clear();
		taskList.add({})
        console.log("----------->>>>>>ss",JsonObj);
		 
        objLength = Object.keys(JsonObj).length;
		
//		taskList=new List(asynBody, options);
		console.log(taskList)
        for (let i = 0; i < objLength; i++) {
            // 데이터 배열에 담기
            
            let tsNameCon = "";
            
            if (JsonObj[i].tsId == 'T00001') {
                tsNameCon = `<span class="category new">${JsonObj[i].taskStatus.tsName}</span>`;
            }
            
            if (JsonObj[i].tsId == 'T00002') {
                tsNameCon = `<span class="category emergency">${JsonObj[i].taskStatus.tsName}</span>`;
            }
            
            if (JsonObj[i].tsId == 'T00003') {
                tsNameCon = `<span class="category ordinary">${JsonObj[i].taskStatus.tsName}</span>`;
            }
			
			
			
           // console.log("taskList",taskList)
            taskList.add( {
                check:`<input type="checkbox" class="checkbox" title="" name ="taskId" id="${JsonObj[i].taskId}">`,
                rnum: `${JsonObj[i].rnum}`,
                taskId :`${JsonObj[i].taskId}`,
                tsNameCon:`${tsNameCon}` ,
                taskTitle:` <a href="${cPath}/project/task/${JsonObj[i].proId}/${JsonObj[i].taskId}" title="[${JsonObj[i].proId}]${JsonObj[i].taskTitle} 상세페이지로 이동">
                              <em class="text-elipsis">
                                 <span class="fw-bold">[${JsonObj[i].proId}]</span>						       
                                ${JsonObj[i].taskTitle}
                            </a>`,
                empName:`${JsonObj[i].empName}`,
                tpsName:`${JsonObj[i].taskProcessStatus.tpsName}`,
                tpsIng:`${JsonObj[i].taskProcessStatus.tpsIng}`,
                taskRegDtStr:`${JsonObj[i].taskRegDtStr}`			
                } );
        }
      
    };
    //비동기 호출
    fetch(`${cPath}/todaylist/todayModal`, {
        method:"POST",
        headers:{
			"Accept":"application/json",
            "Content-Type":"application/json",
            [getCsrfHeader()]: getCsrfToken()
        }
    })
    .then(resp => {
        if (resp.ok) {
            console.log("성공", resp);
            return resp.json();
        } else {
            throw new Error(`상태코드 ${resp.status} 수신`, {cause: resp});
        }
    })
    .then(JsonObj => {
        modalAllList(JsonObj);
		//비동기 후에	
		let checkboxForm = document.querySelector('#checkboxForm');
		let ckbox = checkbox('#modalTable .checkAll', '#modalTable');
		addCheckInput(ckbox, checkboxForm);
    })
    .catch(err => {
        console.log("error", err);
    }).finally(() => {
		var tdList = document.querySelectorAll('#todoListModal td');
        tdList.forEach(function(td) {
            if (td.innerHTML.trim() === '') {
                td.style.display = 'none';
            }
 		});
	});


	//검색버튼 
	let searchForm = $("#searchForm");
	addTrasnform(".searchBox", "select", "input[type='text']", searchForm);

	//모달 열린 후 검색 버튼을 눌렀을 떄 
	$("#searchBtn").on("click",function(){
		let asynBody = document.querySelector('#asynBody');
		checkReset("#modalTable");
		checkboxForm.innerHTML='';
		console.log('폼 초기화 완료')
		//셀렉트 박스 선택시 searchform 에 전송 데이터 추가
		let body= {
			"ts":searchForm.find("[name='ts']").val(),
			"tps":searchForm.find("[name='tps']").val(),
			"word":searchForm.find("[name='word']").last().val()
		}
		
		
		   //비동기 호출 후 실행되어야 할 코드를 함수로 분리
    	const modalsearchList = (JsonObj) => {
      			console.log("JsonObj",JsonObj);
	    		objLength = Object.keys(JsonObj).length;
			
				var options = {
					  valueNames: ['check','rnum', 'taskId','tsNameCon','taskTitle','empName','tpsName','tpsIng','taskRegDtStr'],
						page: 10,
						pagination: true,
						  plugins: [
						      ListPagination({
							 paginationClass: "pagination",
							
							})
						 ],
					 	//searchColumns: ['taskId','tsNameCon','taskTitle','tpsIng']
					};
					
				var taskList = new List(asynBody, options);
			
				taskList.clear();
				
				if(objLength==0){
					taskList.clear();
					
					taskList.add( {
		 				check:"",
		               	rnum:"" ,
					 	taskId :"",
						tsNameCon:"",
						taskTitle:`<td class="text-center">검색 조건에 맞는 데이터가 없습니다.</td>`,
						empName:"",
						tpsName:"",
						tpsIng:"",
						taskRegDtStr:""		
		         	});
					
		            return; // 데이터 없음 메시지를 추가하고 더 이상 진행하지 않음
				}
		
				
			    for (let i = 0; i < objLength; i++) {
			        // 데이터 배열에 담기
			        let tsNameCon = "";
			        
			        if (JsonObj[i].tsId == 'T00001') {
			            tsNameCon = `<span class="category new">${JsonObj[i].taskStatus.tsName}</span>`;
			        }
			        
			        if (JsonObj[i].tsId == 'T00002') {
			            tsNameCon = `<span class="category emergency">${JsonObj[i].taskStatus.tsName}</span>`;
			        }
			        
			        if (JsonObj[i].tsId == 'T00003') {
			            tsNameCon = `<span class="category ordinary">${JsonObj[i].taskStatus.tsName}</span>`;
			        }
			        
					taskList.add({
						check:`<input type="checkbox" class="checkbox" title="" name ="${JsonObj[i].taskId}" id="${JsonObj[i].taskId}">`,
						rnum: `${JsonObj[i].rnum}`,
					 	taskId :`${JsonObj[i].taskId}`,
						tsNameCon:`${tsNameCon}` ,
						taskTitle:` <a href="${cPath}/project/task/${JsonObj[i].proId}/${JsonObj[i].taskId}" title="[${JsonObj[i].proId}]${JsonObj[i].taskTitle} 상세페이지로 이동">
									  <em class="text-elipsis">
						                 <span class="fw-bold">[${JsonObj[i].proId}]</span>						       
										${JsonObj[i].taskTitle}
									</a>`,
						empName:`${JsonObj[i].empName}`,
						tpsName:`${JsonObj[i].taskProcessStatus.tpsName}`,
						tpsIng:`${JsonObj[i].taskProcessStatus.tpsIng}`,
						taskRegDtStr:`${JsonObj[i].taskRegDtStr}`			
						});
					
	   				}
	      			
			}
			
		
			/*비동기*/
			fetch(`${cPath}/todaylist/search`, {
			    method: "POST",
			    headers: {
			        "Accept": "application/json", // 클라이언트가 서버로 보내는 요청 타입 
			        "Content-Type": "application/json", // 서버가 클라이언트에게 보내는 요청 타입
			        [getCsrfHeader()]: getCsrfToken()
			    },
			    body: JSON.stringify(body) // body 객체를 JSON 문자열로 변환하여 전송
			}).then(resp => {
	        if (resp.ok) {
	            console.log("성공", resp);
	           	return resp.json();
	        } else {
	            throw new Error(`상태코드 ${resp.status} 수신`, {cause: resp});
	        }
	
	    }).then(JsonObj => {
		//비워주기
		
			modalsearchList(JsonObj);
			
		let checkboxForm = document.querySelector('#checkboxForm');
		let ckbox = checkbox('#modalTable .checkAll', '#modalTable');
		//비동기 후에		
		addCheckInput(ckbox, checkboxForm);
		
		}).catch(err => {
		    console.log("error", err);
		});
			
	});

  

});



//// 데이터를 받아온 후 화면을 구성하는 함수
//function renderData(data) {
//	
//	console.log(data);
//	
//    let todaylistCon = document.querySelector("#todaylistTable tbody");
//    todaylistCon.innerHTML = ''; // 기존 데이터 초기화
//	
//    if (data.length === 0) {
//        todaylistCon.innerHTML = `
//            <tr>
//                <td colspan="9">오늘의 일정을 등록해주세요.</td>
//            </tr>
//        `;
//        return; // 데이터가 없는 경우 함수 종료
//    }
//	
//    // 데이터를 사용하여 화면 구성
//    data.forEach(function(item, index) {
//        let tsNameCon = '';
//        if (item.tsId === 'T00001') {
//            tsNameCon = `<span class="category new">${item.taskStatus.tsName}</span>`;
//        } else if (item.tsId === 'T00002') {
//            tsNameCon = `<span class="category emergency">${item.taskStatus.tsName}</span>`;
//        } else if (item.tsId === 'T00003') {
//            tsNameCon = `<span class="category ordinary">${item.taskStatus.tsName}</span>`;
//        }
//		let tpsNameCon = '<select class="me-1 form-select"  name="tpsId" data-pg-init-value=""><option value="">진행률</option>'
//	
//		
//        if (item.task.taskProcessStatus.tpsId == 'T00001') {
//			tpsNameCon+='<option value="T00001" selected>10%</option>'
//        } else{
//			tpsNameCon+='<option value="T00001">10%</option>'
//		}
//		if (item.task.taskProcessStatus.tpsId  == 'T00002') {
//			tpsNameCon+='<option value="T00002" selected>30%</option>'
//        }else{
//			tpsNameCon+='<option value="T00002">30%</option>'
//		}
//		if (item.task.taskProcessStatus.tpsId  == 'T00003') {
//			tpsNameCon+='<option value="T00003"selected>50%</option>'
//        }else{
//			tpsNameCon+='<option value="T00003">50%</option>'
//		}
//		if (item.task.taskProcessStatus.tpsId  == 'T00004') {
//			tpsNameCon+='<option value="T00004"selected>70%</option>'
//        }else{
//			tpsNameCon+='<option value="T00004">70%</option>'
//		}
//		if (item.task.taskProcessStatus.tpsId  == 'T00005') {
//			tpsNameCon+='<option value="T00005"selected>90%</option>'
//        }else{
//			tpsNameCon+='<option value="T00005">90%</option>'
//		}
//		if (item.task.taskProcessStatus.tpsId  == 'T00006') {
//			tpsNameCon+='<option value="T00006"selected>99%</option>'
//        }else{
//			tpsNameCon+='<option value="T00006">99%</option>'
//		}
//		if (item.task.taskProcessStatus.tpsId  == 'T00007') {
//			tpsNameCon+='<option value="T00007"selected>100%</option>'
//        }else{
//			tpsNameCon+='<option value="T00007">100%</option>'
//		}
//tpsNameCon+='</select>'
//	var text=`<form><tr>
//                <th>
//					<input type="checkbox" class="checkbox" title="" name ="${item.taskId}" id="${item.taskId}">
//					<input type="hidden" name="taskId" value="${item.taskId }">
//				</th>
//                <td>${item.tlIdx}</td>
//                <td>${item.taskId}</td>
//                <td>${tsNameCon}</td>
//                <td class="text-start">
//                    <a href="${cPath}/project/task/${item["task"]["proId"]}/${item.task.taskId}" title="[${item["task"]["proId"]}]${item.task.taskTitle} 상세페이지로 이동">
//                        <em class="text-elipsis">
//                            <span class="fw-bold">[${item["task"]["proId"]}]</span>
//                            ${item.task.taskTitle}
//                        </em>
//                    </a>
//                </td>
//                <td>${item.taskCompDtStr}</td>
//                <td><input type="text" class="form-control min-auto" placeholder="예상시간" value="${item.task.taskEstTime}" name="taskEstTime"></td>
//                <td><input type="text" class="form-control min-auto" placeholder="소요시간" name="taskRqrd" value="${item.task.taskRqrd}"></td>
//                <td>
//					${tpsNameCon}
//				</td>
//            </tr></form>`;
//		console.log(text)
//        todaylistCon.innerHTML +=text;
//    });
//
//
//}

// 데이터를 받아온 후 화면을 구성하는 함수
function renderData(data) {
	
	console.log(data);
	
    let todaylistCon = document.querySelector("#todaylistTable tbody");
    todaylistCon.innerHTML = ''; // 기존 데이터 초기화
	
    if (data.length === 0) {
        todaylistCon.innerHTML = `
            <tr>
                <td colspan="9">오늘의 일정을 등록해주세요.</td>
            </tr>
        `;
        return; // 데이터가 없는 경우 함수 종료
    }
	console.log(data)
    // 데이터를 사용하여 화면 구성
    data.forEach(function(item, index) {
        let tsNameCon = '';
        if (item.task.taskStatus.tsId === 'T00001') {
            tsNameCon = `<span class="category new">${item.task.taskStatus.tsName}</span>`;
        } else if (item.task.taskStatus.tsId === 'T00002') {
            tsNameCon = `<span class="category emergency">${item.task.taskStatus.tsName}</span>`;
        } else if (item.task.taskStatus.tsId === 'T00003') {
            tsNameCon = `<span class="category ordinary">${item.task.taskStatus.tsName}</span>`;
        }
	let tpsNameCon = '<select class="me-1 form-select"  name="tpsId" data-pg-init-value=""><option value="">진행률</option>'
	
		
        if (item.task.taskProcessStatus.tpsId == 'T00001') {
			tpsNameCon+='<option value="T00001" selected>10%</option>'
        } else{
			tpsNameCon+='<option value="T00001">10%</option>'
		}
		if (item.task.taskProcessStatus.tpsId  == 'T00002') {
			tpsNameCon+='<option value="T00002" selected>30%</option>'
        }else{
			tpsNameCon+='<option value="T00002">30%</option>'
		}
		if (item.task.taskProcessStatus.tpsId  == 'T00003') {
			tpsNameCon+='<option value="T00003"selected>50%</option>'
        }else{
			tpsNameCon+='<option value="T00003">50%</option>'
		}
		if (item.task.taskProcessStatus.tpsId  == 'T00004') {
			tpsNameCon+='<option value="T00004"selected>70%</option>'
        }else{
			tpsNameCon+='<option value="T00004">70%</option>'
		}
		if (item.task.taskProcessStatus.tpsId  == 'T00005') {
			tpsNameCon+='<option value="T00005"selected>90%</option>'
        }else{
			tpsNameCon+='<option value="T00005">90%</option>'
		}
		if (item.task.taskProcessStatus.tpsId  == 'T00006') {
			tpsNameCon+='<option value="T00006"selected>99%</option>'
        }else{
			tpsNameCon+='<option value="T00006">99%</option>'
		}
		if (item.task.taskProcessStatus.tpsId  == 'T00007') {
			tpsNameCon+='<option value="T00007"selected>100%</option>'
        }else{
			tpsNameCon+='<option value="T00007">100%</option>'
		}
tpsNameCon+='</select>'
		var text=`<form><tr>
                <th>
					<input type="checkbox" class="checkbox" title="" name ="${item.taskId}" id="${item.taskId}">
					<input type="hidden" name="taskId" value="${item.taskId }">
				</th>
                <td>${item.tlIdx}</td>
                <td>${item.taskId}</td>
                <td>${tsNameCon}</td>
                <td class="text-start">
                    <a href="${cPath}/project/task/${item["task"]["proId"]}/${item.task.taskId}" title="[${item["task"]["proId"]}]${item.task.taskTitle} 상세페이지로 이동">
                        <em class="text-elipsis">
                            <span class="fw-bold">[${item["task"]["proId"]}]</span>
                            ${item.task.taskTitle}
                        </em>
                    </a>
                </td>
                <td>${item.taskCompDtStr}</td>
                <td><input type="text" class="form-control min-auto" placeholder="예상시간" value="${item.task.taskEstTime}" name="taskEstTime"></td>
                <td><input type="text" class="form-control min-auto" placeholder="소요시간" name="taskRqrd" value="${item.task.taskRqrd}"></td>
                <td>
					<div class="input">
					${tpsNameCon}
					</div>
				</td>
            </tr></form>`;
		console.log(text)
        todaylistCon.innerHTML += text;
    });

	

}

// 데이터를 로컬 스토리지에 저장하는 함수
function saveDataToLocalStorage(data) {
    localStorage.setItem('myData', JSON.stringify(data));
}

// 저장된 데이터를 로컬 스토리지에서 불러오는 함수
function loadDataFromLocalStorage() {
    const data = localStorage.getItem('myData');
    return data ? JSON.parse(data) : null;
}

//추가버튼 클릭시 체크된 데이터를 post 오늘의 일정 insert 데이터 컨트롤러로 보내기
//checkboxForm에서 만들어진 일감의 아이디값을 '추가버튼 클릭시 비동기  요청 보내기 ?'

let addTdBtn = $("#addTaskBtn");
let todaylistTable = document.querySelector('#todaylistTable');
addTdBtn.on("click", function () {
    // 모달 닫기
    $("#todoListModal").modal("hide");
    checkReset(todoListModal);
    let checkedInput = $(checkboxForm).find("input[type='hidden']");
    let sendData2 = [];
    checkedInput.each(function () {
        let name = "taskId";
        let value = $(this).val();
        sendData2.push({ [name]: value });
    });


    fetch(`${cPath}/todaylist/addList`, {
        method: "POST",
        headers: {

            "Content-Type": "application/json",
            [getCsrfHeader()]: getCsrfToken()
        },
        body: JSON.stringify(sendData2)
    }).then(resp => {
        if (resp.ok) {
            console.log("통신 성공");
            return resp.json();
        } else {
            throw new Error(`상태코드 ${resp.status} 수신`, { cause: resp });
        }
    }).then(JsonObj => {
        console.log("JsonObj 데이터는 받아옴",JsonObj)
          // 로컬 스토리지에 데이터 저장
        //saveDataToLocalStorage(JsonObj);
        
        // 데이터 렌더링
        renderData(JsonObj);
        
        
    }).catch(err => {
        console.error(err);
    });
    
});


// 페이지 로드 시 저장된 데이터가 있으면 불러와서 렌더링
document.addEventListener('DOMContentLoaded', function() {
    const savedData = loadDataFromLocalStorage();
    if(savedData) {
        renderData(savedData);
    }
});

		
let comBtn = $("#completeBtn");
comBtn.on("click", function (){


	//배열에 담을 객체의 요소는 : 일감ID, 예상시간, 작업상태 
		//일감아이디 객체 안에 예상시간,작업상태 값을 담아준다. 
		let updateData=[] // 소요값이 변경되거나, 예상시간이 변경되거나, 작업상태가 변경되거나
	
		console.log("완료버튼 클릭");
		let checkList = $(todaylistTable).find("input[type='checkbox']");
		console.log("1111111111111111",checkList);
		let tr = checkList.filter(":checked").parents("tr")
			console.log("22222222222222222222",checkList.filter(":checked"),tr);
		
		//삭제된 나머지 목록 배열에 담아서 바디에 담아서 서버로 보내기
		checkList.each(function(item,idx){
			if(item==0){
				return;
			}
			console.log(item)
		    let isChecked = $(this).is(":checked");
		    if(isChecked){
				let data=makeFormdata(idx);
				console.log(data)
				updateData.push(data)
		
				// fetch 요청 보내기 
				
		    } 
	
		});
		console.log(updateData)
		let url = `${cPath}/todaylist/update`;
		fetch(url, {
				    method: "POST",
				    headers: {
				        "Accept": "application/json", // Json으로 요청
				        "Content-Type": "application/json",// 받아오는 데이터 타입-> todayList 테이블에서 조회오기
						[getCsrfHeader()]: getCsrfToken() 
				    },
				    body: JSON.stringify(updateData) // 비동기 요청시 서버로 보내는 데이터, 문자열 타입으로 변형해야함
				
				}).then(resp => {
				
				    if (resp.ok) {
				        console.log("성공", resp); // 서버가 반환해주는  Json type의 데이터들
				        return resp.json();
				    } else {
				        throw new Error(`상태코드 ${resp.status} 수신`, { cause: resp });
				    }
				
				}).then(JsonObj=>{
					
					console.log("JsonObj",JsonObj.cnt);
					alert(JsonObj.cnt+"개의 일감이 수정되었습니다.")
					console.log("일감상태가 업데이트 되었다.");
					// 2. checkboxForm2 비워주기
						checkboxForm2.innerHTML='';
				}).catch(err => {
				
				    console.error("에러다", err);
				
				});
		
		
		
		
		

//end			
});



		
let delBtn = $("#delBtn");
delBtn.on("click", function (){
	//테이블 데이터 비동기요청으로 보내야함 
	//  1. 체크된 테이블 목록 지우기
	let checkList = $(todaylistTable).find("input[type='checkbox']");
	let tr = checkList.filter(":checked").parents("tr")
		console.log(checkList.filter(":checked"),tr);
	let delData=[];
	
	//삭제된 나머지 목록 배열에 담아서 바디에 담아서 서버로 보내기
	checkList.each(function(item,idx){
	    let isChecked = $(this).is(":checked");
	    if(isChecked){
			if($(idx).hasClass("checkAll")){
				return;
			}
			console.log("item:",idx)
 			delData.push({"taskId":$(this).attr("name")}); // 삭제전 살제할 데이터 네임값 먼저 추가하기
	        $(this).closest("tr").remove();//삭제하기
			
	    } 

	});
	console.log(checkList)
	console.log("delData",delData);
	
		let url = `${cPath}/todaylist/delete`;
		console.log("url", url);
		// fetch 요청 보내기 
		fetch(url, {
		    method: "POST",
		    headers: {
		        "Accept": "application/json", // Json으로 요청
		        "Content-Type": "application/json",// 받아오는 데이터 타입-> todayList 테이블에서 조회오기
				[getCsrfHeader()]: getCsrfToken() 
		    },
		    body: JSON.stringify(delData) // 비동기 요청시 서버로 보내는 데이터, 문자열 타입으로 변형해야함
		
		}).then(resp => {
		
		    if (resp.ok) {
		        console.log("성공", resp); // 서버가 반환해주는  Json type의 데이터들
		        return resp.json();
		    } else {
		        throw new Error(`상태코드 ${resp.status} 수신`, { cause: resp });
		    }
		
		}).catch(err => {
		
		    console.error("에러다", err);
		
		});
		
		console.log("일감이 삭제되었습니다.");
		console.log("delData",delData);
			
		// 2. checkboxForm2 비워주기
			checkboxForm2.innerHTML='';
location.reload();
//end			
});

function makeFormdata(checkBtn){
	let myForm = new FormData();
	let a = $($(checkBtn).parent()).siblings()
	let cnt=-1;
	let data={}
	for(k of a){
		cnt++;
		if(cnt==1) data["taskId"]=$(k).html()
		if(cnt<=4) continue;
		if(cnt==7){
			data[$(k).children().children().attr("name")]=$(k).children().children().val()
		}else{
			data[$(k).children().attr("name")]=$(k).children().val()
		}
	}
	return data;
}



