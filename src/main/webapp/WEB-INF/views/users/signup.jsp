<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<head>
	<%@include file="../include/include.jsp" %>	
	<!-- link -->
	<link rel="stylesheet" href="/resources/css/custom.css">
	<script type="text/javascript" src="/resources/js/signcheck.js"></script>
</head>

<body>
	<div class="wrap">
		
		<%@ include file="../include/header.jsp" %>
		
		<div class="content">
			<div class="container">			
				<form role="form" action="/users/signupAction" method="post" name="signForm">
					<div class="card">
						<div class="card-header">
							<div class="row justify-content-sm-center" style="text-align: right">
								<div class="col-sm-8" style="text-align: center">
									<h3><strong>회원가입</strong></h3>				
								</div>
							</div>
						</div>
						<div class="card-content" style="padding: 20px;">
							<div class="row justify-content-sm-center">
								<div class="col-sm-8">
									<strong><spring:message code="userid"/></strong><strong style="color: red;">*</strong>
									<input type="text" class="form-control" name="userid" id="userid" maxlength="15" onkeyup="idCheck();">
									<small id="userIdCheckMessage" style="float: right;"></small>
									<br>
								</div>
							</div>
							<div class="row justify-content-sm-center">
								<div class="col-sm-8">
									<strong><spring:message code="passwd"/></strong><strong style="color: red;">*</strong>
									<input type="password" class="form-control" name="password" id="password" maxlength="25">
									<br>
								</div>
							</div>
							<div class="row justify-content-sm-center">
								<div class="col-sm-8">
									<strong><spring:message code="passwordConfirm"/></strong><strong style="color: red;">*</strong>
									<input type="password" class="form-control" name="passwordConfirm" id="passwordConfirm" maxlength="25" onkeyup="passwordCheckFunction();">
									<small id="userPasswordCheckMessage" style="float: right;"></small>
									<br>
								</div>
							</div>
							<div class="row justify-content-sm-center">
								<div class="col-sm-8">
									<strong><spring:message code="nickname"/></strong><strong style="color: red;">*</strong>
									<input type="text" class="form-control" name="nickname" id="nickname" maxlength="10" onkeyup="nicknameCheck();">
									<small id="nickNameCheck" style="float: right;"></small>
									<br>
								</div>
							</div>
							<div class="row justify-content-sm-center">
								<div class="col-sm-8">
									<strong>생년월일</strong>
									<div class="row">
										<div class="col-sm-4">
											<div class="row">
												<div class="col-md-10">
													<select id="year" name="year" class="form-control"></select>						
												</div>
												<div class="col-md-2">
													<div class="text_year" style="margin-top: 7px;">
														<strong>년</strong>													
													</div>
												</div>
											</div>
										</div>
										<div class="col-sm-4">
											<div class="row">
												<div class="col-md-10">
													<select id="month" name="month" class="form-control"></select>	
												</div>
												<div class="col-md-2">
													<div class="text_month" style="margin-top: 7px;">
														<strong>월</strong> 
													</div>
												</div>
											</div>
										</div>
										<div class="col-sm-4">
											<div class="row">
												<div class="col-md-10">
													<select id="day" name="day" class="form-control"></select>	
												</div>
												<div class="col-md-2">
													<div class="text_day" style="margin-top: 7px;">
														<strong>일</strong> 
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row justify-content-sm-center" style="margin-top: 10px;">
								<div class="col-sm-8">
									<strong><spring:message code="email"/></strong><strong style="color: red;">*</strong>
									<input type="email" class="form-control" name="email" id="email" maxlength="50" onkeyup="emailCheck();">
									<small id="emailCheck" style="float: right; color: green;">이메일은 비밀번호 및 아이디 찾기에 사용 됩니다.</small>
									<br><br>
								</div>
							</div>
						</div>
						<div class="card-footer">
							<div class="row justify-content-sm-center">
								<div class="col-sm-12 text-right">
									<button type="button" class="btn btn-dark" onclick="signupReset();">다시쓰기</button>
									<button type="button" class="btn btn-dark" onclick="isSubmit();">가입하기</button>
								</div>
							</div>
						</div>
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
					</div>
				</form>
			</div>
		</div>
		
		<%@ include file="../include/footer.jsp" %>
		
	</div>

</body>
</html>