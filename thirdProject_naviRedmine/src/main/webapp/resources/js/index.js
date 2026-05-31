document.addEventListener("DOMContentLoaded", () => {
	//인증
	function getCsrfToken(){
		return document.querySelector('meta[name="_csrf"]').getAttribute('content');
	}
	function getCsrfHeader(){
		return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
	}
		
	AOS.init();
	

	$("a[data-go-link]").each(function(index, atag) {
		const contextPath = $("body").data("contextPath");
		//console.log(contextPath);
		let fullUrl = contextPath + $(atag).data("goLink");
		$(atag).attr("href", fullUrl);
	});

	header.classList.remove("sub");
	window.addEventListener('scroll', function(event) { // 스크롤시
	  	let header = document.querySelector("#header");
		let section1 = document.querySelector(".sc1");

		if(window.pageYOffset > 0 && window.pageYOffset <=section1.offsetHeight){
			header.classList.remove("sub");
			header.classList.add("fixed");
		
		}else if (window.pageYOffset > section1.offsetHeight) {
	        header.classList.add("bg");// 변경
	        //console.log("투명해져라");
    	}else{
	
			header.classList.remove("fixed");
			header.classList.remove("bg");
		}
			
	
	});



	function commonBtn(eventBtn) {
	  let parentSelector = "#" + eventBtn;
	  let container = document.querySelector(parentSelector);
	  let btn = container.querySelector(".btn");
	
	  btn.addEventListener("click", (event) => {
	
		    let thisBtn = event.target;
		    //console.log("thisBtn", thisBtn.classList);
		   // console.log("container", container.id);
			let quickBox = thisBtn.parentNode;
			//console.log(quickBox);
		  	if (!quickBox.classList.contains('active')) {
		      quickBox.classList.add('active');
		      quickBox.style.zIndex = 900;
		    } else {
		      quickBox.classList.remove("active");
		     quickBox.removeAttribute('style');
		    }
		});
	}

	commonBtn("chatBtn");

	//메인 프로젝트 현황 차트
	
	let cPath = document.body.dataset.contextPath;
	//console.log(cPath);
	//data 비동기로 받아올 데이터
	function projectChart(data,chartId) {
		//console.log("data",data)
	    /*chart*/
	    let chartArea = document.getElementById(chartId);
	    // 차트 instance 생성
	    let labels = []; 
		let graphData = [];
		//labels에 data이 데이터 추가하기	: {}객체로 받았기때문에 forEach반복문을 사용해서 조회해야함
		//sort()를 통해 순차정렬함
		  Object.keys(data).sort().forEach(key => {
			// 라벨은 객체의 해당 월 :data[key].month
			// chart의 labels에 전달할 값 넣기
		        labels.push(data[key].month); 
				graphData.push(data[key].proCnt);

				 if (labels.length > 12) {//1월~12월 넘어가면  앞의 데이터부터 자르기
			        labels.shift();
			        graphData.shift();
			    }
		   });
			// chart 생성
			let datas={
				  labels: labels,
				  datasets: [{
				  // label: '프로젝트계약현황',
				    data: graphData,
				    backgroundColor: [
					 'rgba(153, 102, 255, 0.3)',//보라 //1
					  'rgba(255, 99, 132, 0.3)',//2
					  'rgba(255, 159, 64, 0.3)',//3
					  'rgba(255, 205, 86, 0.3)',//4
					  'rgba(75, 192, 192, 0.3)',//5
					  'rgba(54, 162, 235, 0.3)',//6
					  'rgba(153, 102, 255, 0.3)',//7
						'rgba(201, 203, 207,1)'//8
				      
				    ],
				    borderColor: [
				      'rgba(153, 102, 255)',//보라 //1
					  'rgba(255, 99, 132)',//2
					  'rgba(255, 159, 64)',//3
					  'rgba(255, 205, 86)',//4
					  'rgba(75, 192, 192)',//5
					  'rgba(54, 162, 235)',//6
					  'rgba(153, 102, 255)',//7
						'rgba(201, 203, 207)'//8
				      
				    ],
				    borderWidth: 1
				  }]
				};
			
		
			let mixedChart = new Chart(chartArea, {
			   type: 'bar',
				  data: datas,
				  options: {
				    scales: {
				      y: {
				        beginAtZero: true
				      }
				    }
					,			
					 plugins: {
						title: {
				            display: true,
				            text: '프로젝트계약현황',
							font: {
								family:'GmarketSans',
		                        size: 20
		                    }
				        },
			            legend: {
							display:false,
			                labels: {
			                    font: {
									family:'GmarketSans',
			                        size: 18
			                    }
			                }
			            }
					  }
				  }
			});


			// chart 생성완료

	}	
	// chart end	
	//프로젝트 현황 비동기 요청
	function proAsyn() {
	    let url = `${cPath}/index.do/project`;
	    //console.log("url", url);
	    fetch(url, {
			method:"POST",
	        headers: {
				"Accept": "application/json",//로드될 때 클라이언트 측에서 보내는 데이터요청타입
	            "Content-Type": "application/json",//서버가 보내는 데이터타입
	            [getCsrfHeader()]: getCsrfToken()
	        }
	    }).then(resp => {
	        if (resp.ok) {
	            //console.log("성공", resp);
	            return resp.json(); // json 반환
	        } else {
	            throw new Error(`상태코드 ${resp.status} 수신`, { cause: resp });
	        }
	    }).then(JsonObj => {
			//console.log("총 데이",JsonObj.length)
		    //1. 등록일 2.프로젝트의 총 개수
		    let dataSize = JsonObj.length; // 데이터의 길이
		  
 			// 필요한 데이터: 프로젝트의 등록일의 연도와 월 & 매 월 등록된 프로젝트의 총 수
		    let proData = {}; // 월별 데이터를 담을 객체
		    for (let i = 0; i < dataSize; i++) {
				//등록일
		        let proPartOfDate = JsonObj[i].proRegDtStr;
				//console.log("proPartOfDate",proPartOfDate)
				//라벨이름
		        let month = proPartOfDate.substring(2, 7); // YYYY-MM-DD 형식에서YY-MM 부분 추출' 24-02
  				//console.log("month",month)
		        let key = month; // 해당 월의 이름을 가져옴
				//console.log("key",key)
		        // 해당 월의 데이터가 아직 없으면 초기화
		        if (!proData[key]) {
		            proData[key] = { month: key, proCnt: 0, regDates: [] };
		        }
		        // 총 개수 증가 -> 해당월에 따른 프로젝트의 총 개수
		        proData[key].proCnt++;
		        // 등록일 추가 -> 빈 등록일에 해당 조건에 만족하면 등록일 추가
		        proData[key].regDates.push(proPartOfDate);
		    }
			//Object.values() 메서드는 객체의 속성 값들을 배열로 반환
		    //console.log("월별 데이터", Object.values(proData));
			
			//여기서 차트 실행 :전달할 데이터와, 차트영역
			projectChart(proData,'projectContract');
			
			
	    }).catch(err => {
	        console.error(err);
	    });
	    //fetch end
	}
	
	 proAsyn();	
//DomEnd	
});