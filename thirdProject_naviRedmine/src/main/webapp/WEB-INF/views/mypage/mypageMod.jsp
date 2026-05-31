<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!-- retreive -->
<div class="">

	<!-- form -->
	<form:form class="commonForm" method="post" modelAttribute="modEmp" enctype="multipart/form-data">
		<fieldset>
			<legend>
				<span class="sr-only">개인정보 수정</span>
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
								<img src="${pageContext.request.contextPath}/resources/images/prog/navi.jpg" alt="프로필이미지">
							</c:if>
							<c:if test="${not empty vo.base64Img}">
								<img src="data:image/*;base64,${vo.base64Img }" alt="프로필이미지">
							</c:if>
						</div>
					</div>
					<div class="file block">
						<span class="filebtn btn btn-secondary">파일첨부</span>
						<input class="fileInput" id="profilFile" name="bpAttchFile" type="file">
					</div>
				</div>
				<!-- profil script -->
				<script>
					function profilImg() {
						// 첨부 input 변수 가져오기
						let addfile = document.querySelector("#profilFile");
						// 첨부된 이미지 요소
						let imgPath = document.querySelector(".profil_img img");

						addfile.addEventListener("change", (event) => {
							let thisTarget = event.target;
							let fileType = thisTarget.files[0].type;

							// 마임 타입이 이미지가 아니면 종료
							if (!fileType.match(/image\//)) {
								alert("이미지 파일을 첨부해주세요.");
								return;
							}

							// 파일 리더 생성
							let reader = new FileReader();

							// 파일을 읽었을 때의 이벤트 처리
							reader.onload = function () {
								// 이미지 경로 설정
								imgPath.src = reader.result;
							};

							// 파일을 읽기 시작
							reader.readAsDataURL(thisTarget.files[0]);
						});
					}

					profilImg();
					</script>
				<!-- profil script -->
			</div>
			<!-- 프로필 -->

			<!-- 이름 -->
			<div class="row text">
				<div class="label col-sm-3">
					<label for="disabledTextInput" class="form-label">성명</label>
				</div>
				<div class="form_content col-sm-6">
					<input type="text" name="empName" value="${vo.empName }" class="form-control" readonly>
				</div>
			</div>
			<!-- 이름 -->
			<!-- 비밀번호 -->
			<div class="row text">
				<div class="label col-sm-3">
					<label for="disabledTextInput" class="form-label">비밀번호</label>
				</div>
				<div class="form_content col-sm-9">
					<input type="text" name="empPass" value="${vo.empPass }" class="form-control">
				</div>
			</div>
			<!-- 비밀번호 -->
			<!-- 나이 -->
			<div class="row text">
				<div class="label col-sm-3">
					<label for="disabledTextInput" class="form-label">나이</label>
				</div>
				<div class="form_content col-sm-9">
					<input type="text" name="age" value="${vo.empAge }" class="form-control" readonly>
				</div>
			</div>
			<!-- 나이 -->
			<!-- 성별 -->
			<div class="row text">
				<div class="label col-sm-3">
					<label for="disabledTextInput" class="form-label">성별</label>
				</div>
				<div class="form_content col-sm-9">
					<input type="text" name="empGenStr" value="${vo.empGenStr }" class="form-control" readonly>
				</div>
			</div>
			<!-- 성별 -->
			<!-- 부서 -->
			<div class="row select">
				<div class="label col-sm-3">
					<label for="disabledTextInput" class="form-label">부서</label>
				</div>
				<div class="form_content col-sm-9 d-flex">
					<div class="input col-sm-3 mx-1">
						<select id="selectBox" class="form-select"
							aria-label="Default select example" title="부서를 선택해주세요">
							<c:forEach var="dept" items="${deptList}">
								<c:choose>
									<c:when test="${dept.deptName eq vo.deptName}">
										<option value="${dept.deptName}" selected>${dept.deptName}</option>
									</c:when>
									<c:otherwise>
										<option value="${dept.deptName}">${dept.deptName}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<!-- 부서 -->
			<!-- 직급 -->
			<div class="row select">
				<div class="label col-sm-3">
					<label for="disabledTextInput" class="form-label">직급</label>
				</div>
				<div class="form_content col-sm-9 d-flex">
					<div class="input col-sm-3 mx-1">
						<select id="selectBox1" class="form-select"
							aria-label="Default select example" title="직급을 선택해주세요">
							<c:forEach var="position" items="${positionList}">
								<c:choose>
									<c:when test="${position.psName eq vo.psName}">
										<option value="${position.psName}" selected>${position.psName}</option>
									</c:when>
									<c:otherwise>
										<option value="${position.psName}">${position.psName}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<!-- 직급 -->
			<!-- 핸드폰 -->
			<div class="row tel">
				<div class="label col-sm-3">
					<label for="disabledTextInput" class="form-label">휴대폰번호</label>
				</div>
				<div class="form_content col-sm-9 d-flex">
					<div class="input col-sm-3">
						<select id="selectBox2" class="form-select" aria-label="Default select example" title="첫번째 전화번호를 선택해주세요" name="phoneFirst">
							<option value="010" ${phoneFirst == '010' ? 'selected' : ''}>010</option>
							<option value="063" ${phoneFirst == '011' ? 'selected' : ''}>011</option>
							<option value="042" ${phoneFirst == '018' ? 'selected' : ''}>018</option>
						</select>
					</div>
					<span class="entity">-</span>
					<div class="input col-sm-3">
						<input type="text" class="form-control" title="두번째 전화번호를 입력해주세요" name="phoneMiddle" value="${phoneMiddle}" readonly>
					</div>
					<span class="entity">-</span>
					<div class="input col-sm-3">
						<input type="text" class="form-control" title="3번째 전화번호를 입력해주세요" name="phoneLast" value="${phoneLast}" readonly>
					</div>
				</div>
			</div>
			<!-- 핸드폰 -->
			<!-- 주민번호 -->
			<div class="row identifyNum">
				<div class="label col-sm-3">
					<label for="disabledTextInput" class="form-label">주민번호</label>
				</div>
				<div class="form_content col-sm-6 d-flex">
					<div class="input col-sm-6">
						<input type="text" class="form-control" name="rrnoFirst" value="${rrnoFirst}" readonly>
					</div>
					<span class="entity">-</span>
					<div class="input col-sm-6">
						<input type="text" class="form-control" name="rrnoLast" value="${rrnoLast}" readonly>
					</div>
				</div>
			</div>

			<!-- 주민번호 -->
			<!-- 이메일 -->
			<div class="row email">
				<div class="label col-sm-3">
					<label for="disabledTextInput" class="form-label">이메일</label>
				</div>
				<div class="form_content col-sm-9 d-flex">
					<div class="input col-sm-3">
						<input type="text" class="form-control" name="userName" value="${userName }">
					</div>
					<span class="entity">@</span>
					<div class="input col-sm-4">
						<input type="text" class="form-control" name="domain" value="${domain }" readonly>
					</div>
				</div>
			</div>
			<!-- 이메일 -->
			<!-- 주소 -->
			<div class="row address">
				<div class="label col-sm-3">
					<label for="disabledTextInput" class="form-label">주소</label>
				</div>
				<div class="form_content col-sm-9">
					<div class="input col-sm-6  d-flex mb-1">
						<input type="text" class="form-control" id="sample6_postcode" placeholder="우편번호" name="empZip" value="${vo.empZip }">
							<input type="button" class="btn btn-secondary ms-1" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
					</div>
					<div class="input col-sm-9">
						<input type="text" class="form-control col-sm-6" id="sample6_address" name="empAddr" value="${vo.empAddr }" placeholder="주소" readonly>
					</div>
					<div class="input col-sm-9">
						<input type="text" class="form-control" id="sample6_detailAddress" name="empAddr2" value="${vo.empAddr2 }" placeholder="상세주소">
					</div>
				</div>
			</div>
			<!-- 주소 -->
			<!-- 입사일 -->
			<div class="row text">
				<div class="label col-sm-3">
					<label for="disabledTextInput" class="form-label">입사일</label>
				</div>
				<div class="form_content col-sm-9">
					<input type="text" name="empCmpYmdStr" value="${vo.empCmpYmdStr}" class="form-control" readonly>
				</div>
			</div>
			<!-- 입사일 -->
			<!-- 경력 -->
			<div class="row text">
				<div class="label col-sm-3">
					<label for="disabledTextInput" class="form-label">경력</label>
				</div>
				<div class="form_content col-sm-9">
					<input type="text" name="empCareer" value="${vo.empCareer}" class="form-control" readonly>
				</div>
			</div>
			<!-- 경력 -->
			<div class="row select">
				<div class="label col-sm-3">
					<label for="disabledTextInput" class="form-label">도서관심분야</label>
				</div>
				<div class="form_content col-sm-9 d-flex">
					<div class="input col-sm-3 mx-1">
						<select id="selectBox3" class="form-select"
							aria-label="Default select example" title="관심분야를 선택해주세요">
							<c:forEach var="book" items="${bookList}">
								<c:choose>
									<c:when test="${book.bkId eq vo.empBkId}">
										<option value="${book.bkId}" selected>${book.bkNm}</option>
									</c:when>
									<c:otherwise>
										<option value="${book.bkId}">${book.bkNm}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
		</fieldset>
		<div class="btn-box clearfix mt-4">
			<div class="right float-end">
				<button type="submit" class="btn btn-primary" onclick="eventLogic()">완료</button>
			</div>
		</div>
</form:form>
</div>
<!-- form -->
<!-- retreive -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = ''; // 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다
                if (data.userSelectedType === 'R') { 
                	// 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { 
                	// 사용자가 지번 주소를 선택했을 경우
                    addr = data.jibunAddress;
                }

                // 우편번호와 주소 정보를 해당 필드에 입력
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
    
    document.getElementById("selectBox").disabled = true;
    document.getElementById("selectBox1").disabled = true;
    document.getElementById("selectBox2").disabled = true;
    document.getElementById("selectBox3").disabled = true;

    function eventLogic() {
        document.getElementById("selectBox").removeAttribute("disabled"); 
        document.getElementById("selectBox1").removeAttribute("disabled"); 
        document.getElementById("selectBox2").removeAttribute("disabled"); 
        document.getElementById("selectBox3").removeAttribute("disabled"); 
    }
</script>