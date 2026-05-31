<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/js/common/aos/aos.css">
<script src="${pageContext.request.contextPath }/resources/js/common/aos/aos.js"></script>
    <!-- chat -->
	<div class="chat-box quick" id="chatBtn">
		<button class="chat-tit btn">
			<span class="sr-only">채팅</span>
		</button>
		  <!-- chat-conbox : s -->
        <div class="chat-conbox">
            <!-- 클래스나 아이디로 페이지 구분 -->
            <!-- chat_in : s -->
            <!-- 자리비움 설정 시 나와야함 -->
            <div class="chat_in chat_pw">
                <div class="chat_top point_bg">
                   <button class="btn close ">
                        <i class="icon left_arrow"></i>
                        <em class="sr-only">채팅숨기기</em>
                    </button>
                    <strong class="chat_tit">비밀번호 입력</strong>
                    <em class="chat_desc">설정하신 비밀번호를 입력해주세요.</em>
                </div>
                <div class="chat_middle">
                    <div class="input_pw">
                        <input type="password" title="PMS 비밀번호를 입력해주세요." placeholder="PMS 비밀번호를 입력해주세요."
                            class="form-control" id="password" name="password" autocomplete="off" required=""
                            aria-required="true">
                        <button type="submit" class="btn btn-custom chekPw">확인</button>
                    </div>
                </div>
            </div>
            <!-- 자리비움 설정 시 나와야함 -->
            <!-- chat_in : e -->
        </div>
        <!-- chat-conbox : e -->
	</div>
	<!-- chat -->
	<script src="<c:url value='/resources/mypage/js/chatLogin.js'/>" type="text/javascript"></script>
	<script src="<c:url value='/resources/js/index.js'/>"></script>
<style>
#transForm{}
#transForm .form-control-transin{height:100%}
#transForm .modal-body{flex-direction:column}
.trn_header{ height:40px}
.trn_body{height:65%}
.trn_footer{height: 10%; align-items: center;  justify-content: center;}
.trn_footer .btn{}

</style>
<!-- 번역 모달 -->                 
<form method="POST" id="transForm">
<!--    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#transmodal">번역모달</button> -->
   <div class="modal fade flexibleModal" id="transmodal" tabindex="-1" aria-labelledby="transModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg">
         <div class="modal-content">
            <div class="modal-header bg-primary text-white">
               <h5 class="modal-title" id="transModalLabel">NAVIMINE 번역</h5>
               <button type="button" class="btn-close w me-1" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body d-flex w100">
                  <div class="row mb-3 trn_header w100">
                     <div class="col-md-6">
                        <select class="form-select" name="source" id="fromLanguage">
                           <option value="ko">한국어</option>
                           <option value="en">영어</option>
                           <option value="ja">일본어</option>
                           <option value="zh-CN">중국어간체</option>
                           <option value="zh-TW">중국어번체</option>
                           <option value="vi">베트남어</option>
                           <option value="th">태국어</option>
                           <option value="id">인도네시아어</option>
                           <option value="fr">프랑스어</option>
                           <option value="es">스페인어</option>
                           <option value="ru">러시아어</option>
                           <option value="de">독일어</option>
                           <option value="it">이탈리아어</option>
                           <option value="pt">포르투갈어</option>
                           <option value="hi">힌디어</option>
                        </select>
                     </div>
                     <div class="col-md-6">
                        <select class="form-select" name="target" id="toLanguage">
                           <option value="en">영어</option>
                           <option value="ko">한국어</option>
                           <option value="ja">일본어</option>
                           <option value="zh-CN">중국어간체</option>
                        </select>
                     </div>
                  </div>
                  <div class="row mb-3 trn_body w100 my-3">
                     <div class="col-md-6">
                        <label for="inputText" class="form-label sr-only"></label>
                        <textarea class="form-control-transin form-control" name="text" id="inputText" placeholder="번역하고자하는 내용을 입력하세요.(문자 입력시 자동으로 언어를 파악합니다.)"></textarea>
                     </div>
                     <div class="col-md-6">
                        <label for="outputText" class="form-label sr-only"></label>
                        <textarea class="form-control-transin form-control" id="outputText" placeholder="번역된 내용이 나옵니다."></textarea>
                     </div>
                  </div>
                  <a onclick="transAuto()">자동</a>
                  <div class="text-center trn_footer w100 mt-2 d-flex">
                     <button type="button" class="btn btn-primary" id="transBtn">번역하기</button>
                  </div>
            </div>
          <!--   <div class="modal-footer">
               <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            </div> -->
         </div>
      </div>
   </div>
</form>  
<script>
function transAuto(){
	$(inputText).val("꿈을 위해 노력하는 나")
}
</script>
<!-- AI 이미지 생성 모달 -->
   <div class="modal fade" id="imagemodal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg">
         <div class="modal-content">
            <div class="modal-header text-white bg-primary">
               <h5 class="modal-title" id="imageModalLabel">AI 생성형 이미지</h5>
               <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="card">
            <div class="card-body">
            	<em>작성하는 법 : 구체적인 묘사, 표현을 사용해 영문으로 작성</em>
            </div>
            </div>
            <div class="modal-body">
            <img src="${pageContext.request.contextPath }/resources/images/layout/spinner_UI.gif" width="566" height="420" id="loading" style="display: none;"></img>
            <img src="http://192.168.141.27:5000/static/{{obj.src}}" id="myimg" width="566" height="420"style="display: none;"/>
                  <div class="card-body">
                     <div class="card-footer d-flex justify-content-between border-0 py-0">
                        <label for="inputText" class="form-label"></label>
                        <input type="text" class="form-control mb-3" name="prompt" placeholder="생성 할 이미지의 제시어를 '영어'로 입력해주세요!">
                     </div>
                  </div>
                  <div class="text-center mb-3">
                     <button type="button" class="btn btn-primary" id="imageBtn">이미지 생성하기</button>
                     
                  </div>
                  <div id="output" class="mt-3"></div>
            </div>
         </div>
      </div>
   </div>
<!-- ai 이미지 생성 script -->

<script type="text/javascript">
$(document).ready(function(){
	$(imageBtn).on("click",function(){

	if($("#myimg").css("display") != "none"){
		$("#myimg").hide();
	}
	$("#loading").show();
	
	
	$.ajax({
       type: 'GET',
       url: 'http://192.168.141.27:5000/karlo?prompt='+$("input[name='prompt']").val(),
       dataType : 'JSON',
       contentType: "application/json",
	       success: function(res){
	    	   $("#loading").hide();
	    	   $("#myimg").show();
	    	   console.log(res);
		    	  var image_name = res.image_name;
		          var obj = document.getElementById("myimg");
		          obj.src = "http://192.168.141.27:5000/static/"+image_name;
		          // 다운로드 링크의 href 속성 업데이트

		          // 다운로드 시 사용될 파일 이름 설정 (옵션)
		          // '새로운_AI_이미지.png'라는 기본값 대신 실제 이미지 이름을 사용하려면 아래 코드 활용
		       },
			complete:function(){
				$("#loading").hide();
				
			} 
	   });
	});
});
</script>
 
<script>
$(document).ready(function(){
    $("#fromLanguage").on("mousedown", function(e) {
        e.preventDefault();
    });
    $("#fromLanguage").on("keydown", function(e) {
        e.preventDefault();
    });
	let typingTimeout;
	 function getCsrfToken(){
	      return document.querySelector('meta[name="_csrf"]').getAttribute('content');
	   }
	   function getCsrfHeader(){
	      return document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
	   }
	$(transBtn).on("click",function(){
		let formData = new FormData(transForm);
		let qs = new URLSearchParams(formData);
		fetch(document.body.dataset.contextPath+"/trans?"+qs,{
			method:"GET",
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
		}).then(jsonObj=>{
			data = JSON.parse(jsonObj.body);
			let trans=data["message"]["result"]["translatedText"];
			$(outputText).val(trans)
		}).catch(err=>{
			console.error(err);
			$(outputText).val("해당 언어의 번역기가 존재하지 않습니다.")
		})
		
	})
	function handleInput() {
		fetch(document.body.dataset.contextPath+"/lang?text="+$(inputText).val(),{
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
			console.log(jsonObj["body"])
				data = JSON.parse(jsonObj["body"]);
				console.log(data)
				 $(fromLanguage).val(data.langCode);
		}).catch(err=>{
			console.error(err);
		})
	}
	$(inputText).on("blur",()=>{
		console.log(1111)
		clearTimeout(typingTimeout);
		typingTimeout = setTimeout(handleInput, 300);
	})
	
})
</script>    
                       
    

    
<!-- QUICK -->
    	<%-- quick --%>
	<div class="quick-box" id="qickScroll">
		<ul class="ul quick-conbox clearfix">
		  <li>
			<a href="#" data-bs-toggle="modal" data-bs-target="#imagemodal" class="btn btn1">
			  <span class="icon imageAPI"></span><span class="txt">이미지</span>
			</a>
		  </li>
		  <li>
			<a href="#" data-bs-toggle="modal" data-bs-target="#transmodal" class="btn btn2">
			  <span class="icon translation"></span><span class="txt">번역</span>
			</a>
		  </li>
		  
		  <li>
			<a href="${pageContext.request.contextPath}/quick/cert" class="btn btn3">
			  <span class="icon license"></span><span class="txt">자격증</span>
			</a>
		  </li>
		  
<!-- 		  <li> -->
<!-- 			<a href="javascript:void(0);" class="btn btn3" onclick="openCertModal()">  -->
<!-- 			<span class="icon license"></span><span class="txt">자격증</span> -->
<!-- 			</a> -->
<!-- 		  </li> -->
		  
		  <li>
			<a href="${pageContext.request.contextPath}/quick/book" class="btn btn4">
			  <span class="icon book"></span><span class="txt">도서</span>
			</a>
		  </li>
		  <li>
			<a href="${pageContext.request.contextPath}/quick/news" class="btn btn5">
			  <span class="icon news"></span><span class="txt">뉴스</span>
			</a>
		  </li>
		  <li>
			<a href="${pageContext.request.contextPath}/quick/vac" class="btn btn6">
			  <span class="icon tourplace"></span
			  ><span class="txt">휴양지</span>
			</a>
		  </li>
		  <li>
			<a href="${pageContext.request.contextPath}/quick/food" class="btn btn7">
			  <span class="icon food"></span><span class="txt">음식</span>
			</a>
		  </li>
			<!-- 프로그램가이드 -->
			<li>
				<a href='${pageContext.request.contextPath }/prog' class="btn btn11" target="_blank" title="새창열림"> <span class="icon prog"></span><span
		class="txt">프로그램<br>가이드</span>
				</a>
			</li>
			<!-- 프로그램가이드 -->
		 
		</ul>
	  </div>
	<%-- quick --%>
    
    
<%-- footer --%>
    <footer id="footer" class="footer clearfix">
        <div class="footer-inner d-flex">
            <div class="box left">
                <em class="footer_logo">
                    삼국지
                </em>
           <ul class="footer_ul clearfix">
                    <li class="li">
                    	<a href="">유길상</a>
                    	<div class="roleTooltip">
                    		백엔드 종결자, 길상이와 어른들
                    	</div>
                    </li>
                    <li class="li">
                    	<a href="">이상철</a>
                    	<div class="roleTooltip">
                    		발표 종결자, 상철이와 어른들 
                    	</div>
                    </li>
                    <li class="li">
                    	<a href="">정민지</a>
                    	<div class="roleTooltip">
                    		만능키, 그냥 다 잘해...엄청 똑똑해요!
                    	</div>
                    </li>
                    <li class="li">
                    	<a href="">김태은</a>
                    	<div class="roleTooltip">
                    	 	하기나 해  p.s gray shake it! 
                    	</div>
                    </li>
                    <li class="li">
                   		 <a href="">우민규</a>
                   		 <div class="roleTooltip">
                    		노력 종결자, 미래유망주
                    	</div>
                    </li>
                     <li class="li">
                   		 <a href="<c:url value='/resources/pptFile/ppt.pdf'/>" download>발표자료</a>
                    </li>
                </ul> 
                <p class="copyright">Copyright 2024 SKJ.All Rights Reserved.</p>
            </div>

            <div class="box right">
                <ul class="footer_ul clearfix">
                    <li class="li"><span class="icon python">
                        <span class="sr-only">python</span>
                    </span></li>
                    <li class="li"><span class="icon java">
                        <span class="sr-only">java</span>
                    </span></li>
                    <li class="li"><span class="icon js">
                        <span class="sr-only">node JS</span>
                    </span></li>
                 
                </ul>
              
        </div>
    </footer>
    <script src="${pageContext.request.contextPath}/resources/js/footer.js"></script>
    
<%-- footer --%>