<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<style>
/* .sub_navi{} */
/* .sub_navi .nav{width:100%;} */
/* .sub_navi .nav-link{width:calc(100% / 8)} */
</style>

<link rel="stylesheet" href='<c:url value="/resources/css/project/dashboard.css"/>'>
<style>
#myProgress {
  width: 100%;
  background-color: grey;
}

#myBar {
  width: 1%;
  height: 30px;
  background-color: #5346db;
    text-align: center; /* To center it horizontally (if you want) */
  line-height: 30px; /* To center it vertically */
  color: white;
}
#project-info{
	width:100%;
}
</style>
<!-- dashboard-->
<div class="box dashboard clearfix" id="ani">
	<div id="project-info">
		<div class="p-2">
			<div class="p-2">
				<strong class="h4 GmarketSans bold mb-0">프로젝트 진행률</strong>
				<div id="myProgress">
				  <div id="myBar">1%</div>
				</div>
			</div>
			<div class="p-2">
				<strong class="h4 GmarketSans bold mb-0">프로젝트 설명</strong>
				<div class="view_content info_box red mb-5">${project.proDesc }</div>
			</div>
		</div>
	</div>
		<!-- chart -->
		<div class="box_inner chart_box">
		
			<div class="p-2 right">
				<strong class="h5 GmarketSans">일감 진행 현황</strong>
				<canvas id="ingChart"></canvas>
			</div>
			<div class="p-2 left">
				<strong class="h5 GmarketSans">일감상태 현황</strong>
				<canvas id="taskChart"></canvas>
			</div>
			<div class="p-2 middle">
				<strong class="h5 GmarketSans">이슈상태 현황</strong>
				<canvas id="roleChart"></canvas>
			</div>
			
		
		</div>
		<!-- chart -->

		<!-- table -->
		
		<div class="box_inner table_box">

			<strong class="h4 GmarketSans bold mb-0">최신 이슈테이블</strong>
			<table class="table text-center mt-4">
				<caption class="sr-only">이슈 테이블</caption>

				<colgroup>
					<col style="width: 8%;">
					<col style="width: 8%;">
					<col style="width: 5%;">
					<col style="width: 5%;">
					<col style="width: auto;">
					<col style="width: 8%;">
					<col style="width: 8%;">

				</colgroup>

				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">이슈ID</th>
						<th scope="col">분류</th>
						<th scope="col">상태</th>
						<th scope="col">이슈명</th>
						<th scope="col">작성자</th>
						<th scope="col">등록일</th>
						<!-- <th scope="col">중요도</th> -->
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${issueList }" var="issue" begin="0" end="2">
						<!-- 1 -->
						<tr>
							<td scope="row">${issue.rnum }</td>
							<td>${issue.issueId }</td>
							<%--
								<span class="category ordinary">안정</span>	
								<span class="category emergency">긴급</span>
								<span class="category project">신규</span>
							--%>
							 <td>
									<c:if test="${issue.impName eq '낮음'}">
										<span class="category ordinary">${issue.impName }</span>
									</c:if>
									<c:if test="${issue.impName eq '보통'}">
										<span class="category cate2">${issue.impName }</span>
									</c:if>
									 <c:if test="${issue.impName eq '높음'}">
										<span class="category project">${issue.impName }</span>
									</c:if>
									 <c:if test="${issue.impName eq '긴급'}">
										<span class="category emergency">${issue.impName }</span>
									</c:if>
									
								</td>
				 				 <td>
									<c:if test="${issue.stateName eq '해결'}">
										<span class="category cate2">${issue.stateName }</span>
									</c:if>
									<c:if test="${issue.stateName eq '보류'}">
										<span class="category emergency">${issue.stateName}</span>
									</c:if>
									 <c:if test="${issue.stateName eq '신규'}">
										<span class="category new">${issue.stateName}</span>
									</c:if>
									 <c:if test="${issue.stateName eq '진행'}">
										<span class="category cate3">${issue.stateName}</span>
									</c:if>
									 <c:if test="${issue.stateName eq '거절'}">
										<span class="category ordinary">${issue.stateName}</span>
									</c:if>
								</td>
							<%-- <td><span class="category ordinary">${issue.impName}</span></td>
							<td><span class="category ordinary">${issue.stateName}</span></td> --%>
							<td class="text-start">
							<a
									href="${pageContext.request.contextPath }/project/issue/detail/${proId }/${issue.issueId}"
									class="text-link d-flex new"> <span class="icon new_icon">
										<span class="sr-only">new</span>
									</span> <em class="text-elipsis">${issue.issueTitle}</em>
								</a>
							</td>
							<td>${issue.empName }</td>
							<td>${issue.issueRegDtStr}</td>
						</tr>
						<!-- 1 -->
					</c:forEach>
				</tbody>
			</table>

		</div>
		</div>
		<!-- table -->
	

<!-- dashboard-->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
window.addEventListener("DOMContentLoaded", function() {
	var i = 0;
	move();
	//프로젝트 진행률 스크립트
	function move() {
	  if (i == 0) {
	    i = 1;
	    var elem = document.getElementById("myBar");
	    var width = 10;
	    var id = setInterval(frame, 10);	//올라가는 시간 지연 용도
	    function frame() {
	      if (width >= ${project.proIng}) {
	        clearInterval(id);
	        i = 0;
	      } else {
	        width++;
	        elem.style.width = width + "%";
	        elem.innerHTML = width + "%";
	      }
	    }
	  }
	}
    const taskChart = document.getElementById('taskChart');
    const roleChart = document.getElementById('roleChart');
    const ingChart = document.getElementById('ingChart');

    function charFirst() {
    	//스크롤 이벤트 시, 기존에 차트가 존재하면 차트 초기화 
        if (ingChart !== null) {
            let chartStatus = Chart.getChart(ingChart);
            if (chartStatus !== undefined) {
                chartStatus.destroy();
            }
        }
	// 차트 instance 생성
        new Chart(ingChart, {
            type: 'doughnut',
            data: {
                labels: ${ing.labels},
                datasets: [{
                    label: ${ing.labels}, // 라벨과 , 차트 데이터 라벨 동일하게 지정
                    data: ${ing.data},
                    backgroundColor: [
                    	'rgb(255, 99, 132)',
                        'rgb(54, 162, 235)',
                        'rgb(255, 205, 86)',
                        'rgb(75, 192, 192)'
                    ],
                    hoverOffset: 4
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                },
                cutout: "50%",
                radius: "80%"
            }
        });
    }

    function charSecond() {
    	 if (taskChart !== null) {
             let chartStatus = Chart.getChart(taskChart);
             if (chartStatus !== undefined) {
                 chartStatus.destroy();
             }
         }

        new Chart(taskChart, {
            type: 'doughnut',
            data: {
                labels: ${chart.labels},
                datasets: [{
                    label: ${chart.labels},
                    data: ${chart.data},
                    backgroundColor: [
                        'rgb(54, 162, 235)',
                        'rgb(255, 205, 86)',
                    	'rgb(255, 99, 132)'
                    ],
                    hoverOffset: 4
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                },
                cutout: "50%",
                radius: "80%"
            }
        });
    }

    function chartThird() {
    	if (roleChart !== null) {
            let chartStatus = Chart.getChart(roleChart);
            if (chartStatus !== undefined) {
                chartStatus.destroy();
            }
        }
        new Chart(roleChart, {
            type: 'doughnut',
            data: {
                labels: ${team.labels},
                datasets: [{
                    label: ${team.labels},
                    data: ${team.data},
                    backgroundColor: [
                        'rgb(255, 99, 132)',
                        'rgb(54, 162, 235)',
                        'rgb(255, 205, 86)',
                        'rgb(75, 192, 192)',
                        'rgb(153, 102, 255)'
                    ],
                    hoverOffset: 4
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                },
                cutout: "50%",
                radius: "80%"
            }
        });
    }

    function handleScroll() {
        var aniBox = document.getElementById('ani').offsetTop;
        var scroll_Top = document.documentElement.scrollTop;

        //console.log(aniBox, scroll_Top);

        if (aniBox <= scroll_Top) {
            charFirst();
           	charSecond();
            chartThird(); 

            // 스크롤 이벤트 한 번만 실행 후 이벤트 리스너 제거
            window.removeEventListener('scroll', handleScroll);
        }
    }
    // 로드시 다시 등록
    window.addEventListener('scroll', handleScroll);
});


//즐겨찾기 버튼 클릭이벤트 
let kinBtn = document.querySelector(".kinBtn");
kinBtn.classList.remove("active");
kinBtn.addEventListener("click", function() {
   // console.log("?");
    this.classList.toggle("active");
});


</script>
