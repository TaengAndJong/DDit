const cPath = document.body.dataset.contextPath;
const baseURI=`${cPath}/09/property`
document.addEventListener("DOMContentLoaded", function() {

   // 리스트 a태그에 해당하는 아이디값 동적 부여
   let stdTalbe = document.querySelector("#modalTable");
   let atagTargetArray = stdTalbe.querySelectorAll("a")
   let modalBox = stdTalbe.nextElementSibling;

   //부트스트랩 모달 수동작동   
   modalBox.style.display = "none";


   // a태그를 셀렉했을 때 그 행의 값을 가져오기 위함
   atagTargetArray.forEach(function(a, idx) {
      idx = idx + 1;
      a.id = "exampleModal" + (idx);

      //선택된 a의 tr 찾기부모 찾기 
      a.addEventListener("click", (event) => {

         let tr = a.parentNode.parentNode;
         let stdNo = tr.querySelector(".stdNo").innerText;
         let stdId = tr.querySelector(".stdId").innerText;
         let stdName = tr.querySelector(".stdName").innerText;
         let stdAddress = tr.querySelector(".stdAddress").innerText;
         let stdTelno = tr.querySelector(".stdTelno").innerText;
         let proNo = tr.querySelector(".proNo").innerText;
         // 모달창 열리기전에 테이블에 있는 데이터값 가져오기
         modalBox.querySelector("#stdNo").value = stdNo;
         modalBox.querySelector("#stdId").value = stdId;
         modalBox.querySelector("#stdName").value = stdName;
         modalBox.querySelector("#stdTelno").value = stdTelno;
         modalBox.querySelector("#stdAddress").value = stdAddress;
         modalBox.querySelector("#proNo").value = proNo;

         //모달 a 링크 클릭시 열림
         modalBox.classList.add(event.target.id);
         modalBox.classList.add("show");
         modalBox.style.display = "block";

      });
});
const formToObject=(form)=>{
	let data={};
	let formData=new FormData(form);
	for(let n of formData.keys()){
		data[n]=formData.get(n)
	}
	return data;
}
   //모달 닫기 버튼   
   let topClose = modalBox.querySelector("#closeBtn");
   topClose.addEventListener("click", () => {
      modalBox.classList.remove("show");
      modalBox.style.display = "none";

   });


var fnModifyProperty=(event)=>{
	event.preventDefault()
	let form = event.target;
	let data=formToObject(form);
	let body=JSON.stringify(data);
	fetch(`${cPath}/staff/staffStudentList.do`,{
		method:"post",
			headers: {
				"Accept":"application/json",
				"Content-Type":"application/json"
			},body:body
	}).then(res=>{
		return res.json();
	}).then(jsonObj => {
		console.log(jsonObj)
		});
	return false;
}

updateForm.addEventListener("submit",fnModifyProperty);
});

