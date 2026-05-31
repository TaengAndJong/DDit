<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form"  prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags"  prefix="spring"%>

<!-- 어드민 사원의 subMenu_empMenu 타일즈 -->
<div class="header-title select">
	<h2>
		<strong class="title-name">${mainTitle}</strong>
	</h2>
</div>

<!-- 사원 분류별 숫자를 보여주는 container -->
  <div class="container">
      <h5 class="my-4"></h5>
      <div class="row">
        <div class="col-lg-3">
          <div class="card emp">
            <div class="card-body d-flex ">
              <div>
                <p class="card-text mb-2">전체사원</p>
                <h4>${empTotal}</h4>
              </div>
            </div>
          </div>
        </div>
        
        <div class="col-lg-3">
          <div class="card pms">
            <div class="card-body d-flex ">
              <div>
                <p class="card-text mb-2">PMS사원</p>
                <h4>${pmsTotal }</h4>
              </div>
            </div>
          </div>
        </div>
        
        <div class="col-lg-3">
          <div class="card pl">
            <div class="card-body d-flex ">
              <div>
                <p class="card-text mb-2">프로젝트관리자</p>
                <h4>${plTotal }</h4>
              </div>
            </div>
          </div>
        </div>
        
        <div class="col-lg-3">
          <div class="card block">
            <div class="card-body d-flex ">
              <div>
                <p class="card-text mb-2">차단회원</p>
                <h4>${blockTotal }</h4>
              </div>
            </div>
          </div>
        </div>
        
      </div>
    </div>