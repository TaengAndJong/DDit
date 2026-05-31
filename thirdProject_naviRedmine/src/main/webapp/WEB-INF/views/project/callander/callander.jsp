<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<style>
.sub_navi{}
.sub_navi .nav{width:100%;}
.sub_navi .nav-link{width:calc(100% / 8)}
.todolistModal  .modal-dialog{max-width: calc(100% - 50px);}
/* 오늘의 일정 모달 */
.todolistModal .modal-body{height:calc(100% - 140px)}
.tdList-Modal_table{overflow-y: scroll;margin-top: 20px;}

</style>
<!-- <link rel="stylesheet" -->
<%-- 	href='<c:url value="/resources/css/todayList/todayList.css"/>'> --%>
<link rel="stylesheet" href='<c:url value="/resources/css/project/callander.css"/>'>
<script
	src='${pageContext.request.contextPath }/resources/lib/fullcalendar-6.1.10/dist/index.global.min.js'></script>
	<div class="modal fade flexibleModal"
	 id="exampleModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header bg-primary text-white">
				<strong class="modal-title" id="exampleModalLabel">일감 조회</strong>
			</div>
			<div class="modal-body">
				<!-- modal top -->
				<div class="tdList-Modal_table scrollY">

					<ul class="cal-today_list d-flex align-items-center">
						<li class="my-2"><span class="category new">일감</span> <span
							class="totalNum fw-bold" id="totl"></span><span>건</span></li>
						<li class="my-2"><span class="category emergency ">긴급</span>
							<span class="num text-danger fw-bold" id="danger"> 7</span> <span>건</span></li>
						<li class="my-2"><span class="category ordinary">일반</span> <span
							class="num fw-bold" id="gener"> 8</span> <span>건</span></li>
					</ul>
				</div>
				<!-- modal top -->
				<!-- modal bottom -->
				<div class="cal-Modal_table scrollY">

					<table class="tdList-Modal_table scrollY">
						<caption class="sr-only">프로젝트 목록 테이블입니다.</caption>

						<colgroup>
							<col style="width: 10%;">
							<col style="width: 10%;">
							<col style="width: auto;">
							<col style="width: 10%;">
							<col style="width: 8%;">
							<col style="width: 8%;">
						</colgroup>

						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">상태</th>
								<th scope="col">제목</th>
								<th scope="col">담당자</th>
								<th scope="col">등록일</th>
								<th scope="col">마감일</th>
							</tr>
						</thead>
						<tbody id="modalCon" class="list" >
						</tbody>

					</table>

					<!-- page -->

					<!-- page -->
				</div>
				<!-- modal bottom -->
			</div>
			<div class="modal-footer justify-content-center">
				<button type="button" class="btn btn-light btn-outline-secondary"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<script>
  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
    	height: 'auto'
      ,initialView: 'dayGridMonth'
      , initialDate:'${nowStr}'
      , events: '${pageContext.request.contextPath }/project/calendar/${proId}/data'
   	  , eventClick: function(info) {
      	    //console.log('Event: ' + info.event.title);
      	   // console.log('Coordinates: ' + info.jsEvent.pageX + ',' + info.jsEvent.pageY);
      	   // console.log('View: ' + info.view.type);
      	    info.el.style.borderColor = 'red';
      	    info.jsEvent.preventDefault();
      	    //console.log("event : ",info.event.id)
      	    fetch("${pageContext.request.contextPath}/project/calendar/${proId}/"+info.event.id+"/json",{
				method:"GET",
				headers:{
					"Accept":"application/json"
				}
			}).then(resp=>{
				if(resp.ok){
					return resp.json();
				}else{
					throw new Error(`상태코드 ${resp.status} 수신`,{cause:resp})
				}
			}).then(jsonObj=>{
				console.log(jsonObj)
				let txt="";
				if(jsonObj==null){
					txt+=`<tr>
						<td class="text-center" colspan="7">분배된 일감이 없습니다</td>
						</tr>`;
				}else{
					let dangerCnt=0;
					let generCnt=0;
					jsonObj.forEach(item=>{
						console.log(item)
						let st='ordinary';
						let tsId= item.tsVO.tsId;
						if(tsId=='T00003'){
							st='emergency';
							dangerCnt+=1;
						}else{
							generCnt+=1;
						}
						txt+=`<tr class="tr">
							<th scope="row">`+item.taskId+`</th>
							<td><span class="category `+st+` ">`+item.tsVO.tsName+`</span></td>
							<td class="text-start"><a href="${pageContext.request.contextPath}/project/task/${project.proId}/`+item.taskId +`" class="text-link d-flex">
									<em class="text-elipsis"  style="text-size:5px; ">`+item.taskTitle +`</em>
							</a></td>
							<td>`+item.empName+`</td>
							<td>`+item.taskRegDtStr+`</td>
							<td>`+item.taskCompDtStr+`</td>
						</tr>`
					})
					$("#danger").html(dangerCnt)
					$("#gener").html(generCnt)
					$("#totl").html(dangerCnt+generCnt)
					modalCon.innerHTML=txt;
				}
				
			}).catch(err=>{
				console.error(err);
			})
//       	    location.href = `${pageContext.request.contextPath}\${info.event.url}`;   
      	}
      ,eventContent: function(arg) {
          // 이벤트 요소의 컨텐츠를 만듭니다.
          var eventTitle = arg.event.title; // 이벤트 제목
          var eventDate = arg.event.start; // 이벤트 시작 날짜
          var eventLabel = document.createElement('div'); // 새로운 div 요소 생성
          eventLabel.innerHTML = arg.event.title;
          return { domNodes: [eventLabel] }; // 이벤트 레이블을 반환
          console.log(eventTitle)
          console.log(eventDate)
          console.log(eventLabel)
        }
    });
    calendar.render();
  });
</script>
<div id='calendar' class="w-70"></div>



