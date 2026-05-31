<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!-- retreive -->
<div class="">
	<!-- form -->
	<form class="commonForm" action="">
		<fieldset>
			<legend>
				<span class="sr-only">개인정보 조회</span>
			</legend>

			<!-- 프로필 -->
			<div class="row profil">
				<div class="label col-sm-3">
					<label for="profilFile" class="form-label">프로필</label>
				</div>
				<div class="form_content col-sm-6">
					<div class="profil_img block">
						<div class="img-in">
							<c:if test="${empty vo.base64Img}">
								<img src="${pageContext.request.contextPath}/resources/images/prog/navi.jpg"
									alt="프로필이미지">
							</c:if>
							<c:if test="${not empty vo.base64Img}">
								<img src="data:image/*;base64,${vo.base64Img }" alt="프로필이미지">
							</c:if>
						</div>
					</div>
				</div>
			</div>
			<!-- 프로필 -->
			<!-- 이름 -->
			<div class="row text">
				<div class="label col-sm-3">
					<label for="disabledTextInput" class="form-label">성명</label>
				</div>
				<div class="form_content col-sm-6">
					<span>${vo.empName}</span>
				</div>
			</div>
			<!-- 이름 -->
			<!-- 비밀번호 -->
			<div class="row text">
				<div class="label col-sm-3">
					<label for="disabledTextInput" class="form-label">비밀번호</label>
				</div>
				<div class="form_content col-sm-6">
					<span>${vo.empPass}</span>
				</div>
			</div>
			<!-- 비밀번호 -->
			<!-- 나이 -->
			<div class="row text">
				<div class="label col-sm-3">
					<label for="disabledTextInput" class="form-label">나이</label>
				</div>
				<div class="form_content col-sm-6">
					<span>${vo.empAge} 살</span>
				</div>
			</div>
			<!-- 나이 -->
			<!-- 성별 -->
			<div class="row text">
				<div class="label col-sm-3">
					<label for="disabledTextInput" class="form-label">성별</label>
				</div>
				<div class="form_content col-sm-6">
					<span>${vo.empGenStr}</span>
				</div>
			</div>
			<!-- 성별 -->
			<!-- 부서 -->
			<div class="row text">
				<div class="label col-sm-3">
					<label for="disabledTextInput" class="form-label">부서</label>
				</div>
				<div class="form_content col-sm-9">
					<span>${vo.deptName}</span>
				</div>
			</div>
			<!-- 부서 -->
			<!-- 직급 -->
			<div class="row text">
				<div class="label col-sm-3">
					<label for="disabledTextInput" class="form-label">직급</label>
				</div>
				<div class="form_content col-sm-9">
					<span>${vo.psName}</span>
				</div>
			</div>
			<!-- 직급 -->
			<!-- 핸드폰 -->
			<div class="row tel">
				<div class="label col-sm-3">
					<label for="disabledTextInput" class="form-label">휴대폰번호</label>
				</div>
				<div class="form_content col-sm-9 d-flex">
					<span>${vo.empPhone}</span>
				</div>
			</div>
			<!-- 핸드폰 -->
			<!-- 주민번호 -->
			<div class="row identifyNum">
				<div class="label col-sm-3">
					<label for="disabledTextInput" class="form-label">주민등록번호</label>
				</div>
				<div class="form_content col-sm-6 d-flex">
					<span>${vo.empRrno}</span>
				</div>
			</div>
			<!-- 주민번호 -->
			<!-- 이메일 -->
			<div class="row email">
				<div class="label col-sm-3">
					<label for="disabledTextInput" class="form-label">이메일</label>
				</div>
				<div class="form_content col-sm-9 d-flex">
					<span>${vo.empMail}</span>
				</div>
			</div>
			<!-- 이메일 -->
			<!-- 주소 -->
			<div class="row address">
				<div class="label col-sm-3">
					<label for="disabledTextInput" class="form-label">주소</label>
				</div>
				<div class="form_content col-sm-9">
					<span>${vo.empZip} ${vo.empAddr} ${vo.empAddr2}</span>
				</div>
			</div>
			<!-- 주소 -->
			<!-- 입사일 -->
			<div class="row address">
				<div class="label col-sm-3">
					<label for="disabledTextInput" class="form-label">입사일</label>
				</div>
				<div class="form_content col-sm-9">
					<span>${vo.empCmpYmdStr}</span>
				</div>
			</div>
			<!-- 입사일 -->
			<!-- 경력 -->
			<div class="row address">
				<div class="label col-sm-3">
					<label for="disabledTextInput" class="form-label">경력</label>
				</div>
				<div class="form_content col-sm-9">
					<span>${vo.empCareer} 년</span>
				</div>
			</div>
			<!-- 경력 -->
			<div class="row select">
				<div class="label col-sm-3">
					<label for="disabledTextInput" class="form-label">도서관심분야</label>
				</div>
				<div class="form_content col-sm-9 d-flex">
					<div class="input col-sm-3 mx-1">
						<select class="form-select" aria-label="Default select example"
							title="관심분야를 선택해주세요" disabled>
							<option selected>관심분야선택</option>
							<option value="${vo.empBkId}" selected>${bkNm}</option>
						</select>
					</div>
				</div>
			</div>
		</fieldset>
	</form>
	<!-- form -->
	<div class="btn-box clearfix mt-4">
		<div class="right float-end">
			<a href="${pageContext.request.contextPath }/mypage/verification"><button
					class="btn btn-primary">수정</button></a>
		</div>
	</div>
</div>
<!-- retreive -->