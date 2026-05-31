<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form"  prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags"  prefix="spring"%>

									
			
			<div class="mypage">
			<div class="box">

				<div class="mypage-login">
					<strong class="tit">인증로그인</strong>
					<div class="imgbox">
						<div class="img-in">
							<img src="./resources/images/prog/navi.jpg" alt="작성자프로필이미지">
							<!-- <img src="./resources/images/prog/TA.png" alt="작성자프로필이미지"> -->
						</div>
					</div>

					<div class="input-info">
						<div class="mb-1">

							<input type="text" title="사원번호를 입력해주세요." placeholder="사원번호를 입력해주세요." class="form-control" id="id"
								name="id" autocomplete="off" required="" aria-required="true">
						</div>
						<div class="mb-1">
							<input type="password" title="비밀번호를 입력해주세요." placeholder="비밀번호를 입력해주세요." class="form-control"
								id="password" name="password" autocomplete="off" required="" aria-required="true">
						</div>
						<button type="submit" class="btn btn-login btn-custom">로그인</button>
					</div>

				</div>

			</div>
		</div>	
			
									
								