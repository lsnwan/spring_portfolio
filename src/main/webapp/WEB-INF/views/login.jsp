<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="include/include.jsp" %>	
	<!-- link -->
	<link rel="stylesheet" href="/resources/css/custom.css">
</head>

<body>

<div class="wrap">
	<%@ include file="include/header.jsp" %>
	<div class="content">
		<div class="container">
			<form action="/login" method="post">
				<div class="login_form" style="margin-top: 7%;">
					<div class="card">
						<div class="card-header">
							<div class="row justify-content-sm-center">
								<div class="col-sm-8" style="text-align: center">
									<h3><strong>로그인</strong></h3>				
								</div>
							</div>
						</div>
						<div class="card-body">
							<div class="row justify-content-sm-center">
								<div class="col-sm-3" style="text-align: center; margin-top: 7px;">
									<p class="text_id">아이디				
								</div>
								<div class="col-sm-9">
									<input type="text" class="form-control" name="username" id="login_id" max="20" value="${userid }">
								</div>
							</div>
							<div class="row justify-content-sm-center">
								<div class="col-sm-3" style="text-align: center; margin-top: 7px;">
									<p class="text_pw">비밀번호				
								</div>
								<div class="col-sm-9">
									<input type="password" class="form-control" name="password" id="login_password" max="30" value="${password }">
								</div>
							</div>
							<div class="row justify-content-sm-center">
								<div class="col-sm-12 text-right">
									
									<small style="color: red;">${ERRORMSG }</small>
									
								</div>
							</div>
						</div>
						<div class="card-footer">
							<div class="row justify-content-sm-center">
								<div class="col-8" style="margin-top: 2px;">
									<small><a href="${path }/users/findPassword">비밀번호 찾기</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="${path }/users/findUserId">아이디 찾기</a></small>
								</div>
								<div class="col-4 text-right">
									<button type="submit" class="btn btn-dark btn-sm">로그인</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			</form>
		</div>
	</div>
	<!-- footer -->
	<%@ include file="include/footer.jsp" %>	
</div>

</body>
</html>