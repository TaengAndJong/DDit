<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main class="container-fluid">

<div class="container">
    <div id="myCarousel" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#myCarousel" data-slide-to="1"></li>
        </ol>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="resorces/images/2.jpg" class="d-block w-100" alt="Image 1">
            </div>
            <div class="carousel-item">
                <img src="resorces/images/1.jpg" class="d-block w-100" alt="Image 2">
            </div>
        </div>
        <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
</div>

<div class="container mt-4">
    <div class="jumbotron">
        <div class="container">
            <h4 class="pb-2">프로젝트 요구사항</h4>
            <ol class="customUl">
                <li><span class="tit"></span> 사용자 인증/인가 시스템은 구현하지 않고,<br>
                    &nbsp;각 서비스는 해당 사용자가 이미 인증 및 인가된 상태임을 가정하고 구현
                </li>
                <li><span class="tit"></span>사용자는 학생, 교수, 교직원으로 가정</li>
                <li><span class="tit"></span>교수는 자신의 강의 조회 가능</li>
                <li><span class="tit"></span>교수는 자신의 강의를 수강하는 학생조회 가능</li>
                <li><span class="tit"></span>교수는 자신의 강의를 수강하는 학생들의 학점을 관리 가능</li>
                <li><span class="tit"></span>교직원은 교수와 학생 정보 관리가능</li>
                <li><span class="tit"></span>학생은 개설된 강의 수강신청이 가능하며, 본인 학점조회 가능</li>
                <li><span class="tit"></span>학생 정보 상세 조회 시, 해당 학생의 수강 과목과 해당 과목의 학점을 함께 조회</li>
            </ul>
        </div>
    </div>
</div>


</main>

<!-- <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"></script> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script> -->
<script src="${pageContext.request.contextPath}/resources/js/app/index.js"></script>

<footer>
	<div class="footer-info">
		
	
	</div>
</footer>
