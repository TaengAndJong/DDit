<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/project/gant/dist/frappe-gantt.css" />
<script
	src="${pageContext.request.contextPath }/resources/project/gant/dist/frappe-gantt.js"></script>
<!-- setting modal -->
<div class="modal fade info" id="settingmodal" tabindex="-1"
	aria-labelledby="settingmodalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header bg-primary mb-1">
				<strong class="modal-title text-white" id="exampleModalLabel">알림설정</strong>
			</div>
			<div class="modal-body">
				<div class="alrambox">
					<ul class="table-bordered ming-sun text-center align-middle mb-0">
						<li class="d-flex justify-content-between py-2 border-bottom">
							일감 날자를 변경하시겠습니까?</li>
					</ul>
				</div>
				<div class="modal-footer justify-content-center">
					<button type="button" class="btn btn-light btn-outline-secondary"
						data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" id="dtBtn" data-bs-dismiss="modal">확인</button>
				</div>
			</div>

		</div>
	</div>
</div>
<!--alram -->



<button type="button" class="btn btn-sm btn-light dateBtn"
	data-cv="Quarter Day">6시간별 조회</button>
<button type="button" class="btn btn-sm btn-light dateBtn"
	data-cv="Half Day">12시간별 조회</button>
<button type="button" class="btn btn-sm btn-light dateBtn" data-cv="Day">일단위 조회</button>
<button type="button" class="btn btn-sm btn-light dateBtn"
	data-cv="Week">주단위 조회</button>
<button type="button" class="btn btn-sm btn-light dateBtn" data-cv="Month">월단위 조회</button>
<div class="container">
	<div class="gantt-target"></div>
</div>
<script>
	function getCsrfToken(){
	      return document.querySelector('meta[name="_csrf"]').getAttribute('content');
	   }
	   function getCsrfHeader(){
	      return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
	   }
	   var tasks;
	fetch("${pageContext.request.contextPath }/project/gantt/${project.proId}",{
		method:"POST",
		headers:{
			"Accept":"application/json",
			[getCsrfHeader()]: getCsrfToken()
		}
	}).then(resp=>{
		if(resp.ok){
			return resp.json();
		}else{
			throw new Error(`상태코드 ${resp.status} 수신`,{cause:resp})
		}
	}).then(tasks=>{
		console.log(tasks)
		var gantt_chart = new Gantt(".gantt-target", tasks, {
			on_click: task => {
				console.log(task);
			},
			on_date_change: dateChange,
			on_progress_change: (task, progress) => {
				console.log(task, progress);
			},
			on_view_change: (mode) => {
				console.log(mode);
			},
			header_height: 50,
		    column_width: 30,
		    step: 24,
		    view_modes: ['Quarter Day', 'Half Day', 'Day', 'Week', 'Month'],
		    bar_height: 20,
		    bar_corner_radius: 5,
		    arrow_curve: 1,
		    padding: 20,
		    view_mode: 'Week',
		    date_format: 'YYYY-MM-DD',
		    language: 'kr', // or 'es', 'it', 'ru', 'ptBr', 'fr', 'tr', 'zh', 'de', 'hu'
		    custom_popup_html: null
		});
// 		console.log(gantt_chart.change_view_mode('Week'));
	$(".dateBtn").on("click",function(e){
		let data=$(e.target).data("cv")
		gantt_chart.change_view_mode(data)
		$(".dateBtn").each((i,b)=>{
			$(b).removeClass("active")
		})
		$(e.target).addClass("active");
	})
	}).catch(err=>{
		console.error(err);
	})
	
	function dateChange(task, start, end){
		let myModalAlternative = new bootstrap.Modal('#settingmodal', {
			keyboard: false
		})
		myModalAlternative.show(settingmodal)
		
			$(dtBtn).on("click",function(){
				let startDate = new Date(start);
				let endDate = new Date(end);
				let taskRegDt = startDate.toISOString(); // taskRegDt를 startDate로 설정
				let taskCompDt = endDate.toISOString(); // taskExCompDt를 endDate로 설정
				let data={
					taskId:task.id,
					taskRegDt:taskRegDt,
					taskCompDt:taskCompDt
				};
				let body=JSON.stringify(data);
				
				console.log("DATA",data)
				

				fetch("${pageContext.request.contextPath}/project/gantt/${project.proId}/date",{
					method:"POST",
					headers:{
						"Accept":"application/json",
						"Content-Type":"application/json",
						[getCsrfHeader()]: getCsrfToken()
					},body:body
				}).then(resp=>{
					if(resp.ok){
						return resp.text();
					}else{
						throw new Error(`상태코드 ${resp.status} 수신`,{cause:resp})
					}
				}).then(text=>{
					console.log(text)
				}).catch(err=>{
					console.error(err);
				})
			})
	}
	document.addEventListener('hidden.bs.modal', event => {
		location.reload();
	})
	</script>