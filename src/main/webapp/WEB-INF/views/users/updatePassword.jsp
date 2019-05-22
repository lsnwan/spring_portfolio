<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../include/include.jsp" %>	
	<!-- link -->
	<link rel="stylesheet" href="/resources/css/custom.css">
	<script type="text/javascript" src="/resources/js/updatePassword.js"></script>
</head>

<body>
	
	<div class="wrap">
		<%@ include file="../include/header.jsp" %>
		
		<div class="content">
			<div class="container">
				<div class="row">
					<div class="col-md-3">
						<div class="card">
							<div class="card-body">
								<div class="userUpdateLink">
									<div class="card-text">
										<a href="${path }/users/updateUser" class="card-link"><i class="fas fa-circle" style="width: 10px; height: 10px; margin-bottom: 2px;"></i>&nbsp;&nbsp;회원정보변경</a>
									</div>
									<div class="card-text" style="margin-top: 10px;">
										<a href="${path }/users/updatePasswordCheck" class="card-link"><i class="fas fa-circle" style="width: 10px; height: 10px; margin-bottom: 2px;"></i>&nbsp;&nbsp;비밀번호변경</a>
									</div>
									<div class="card-text" style="margin-top: 10px;">
										<a href="${path }/users/updateProfile" class="card-link"><i class="fas fa-circle" style="width: 10px; height: 10px; margin-bottom: 2px;"></i>&nbsp;&nbsp;프로필변경</a>
									</div>
									<div class="card-text" style="margin-top: 10px;">
										<a href="${path }/users/deleteUser" class="card-link"><i class="fas fa-circle" style="width: 10px; height: 10px; margin-bottom: 2px;"></i>&nbsp;&nbsp;회원탈퇴</a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-9">
						<div class="userUpdateContent">
							<form action="updatePassword" method="post" name="updateForm">
								<div class="card">
									<div class="card-body">
										<h4 class="card-title">비밀번호변경</h4>
										<br>
										<div class="row">
											<div class="col-sm-12">
												<h6>변경할 비밀번호를 입력하세요.</h6>
											</div>
										</div>
										<br>
										<div class="row">
											<div class="col-sm-3">
												<div class="userUpdateName">
													<strong>비밀번호</strong>
												</div>
											</div>
											<div class="col-sm-9">
												<div class="userUpdateSelect">
													<input type="password" class="form-control" name="password" id="userpw" onkeyup="passwordCheck()">
												</div>
											</div>
										</div>
										<br>
										<div class="row">
											<div class="col-sm-3">
												<div class="userUpdateName">
													<strong>비밀번호확인</strong>
												</div>
											</div>
											<div class="col-sm-9">
												<div class="userUpdateSelect">
													<input type="password" class="form-control" name="passwordConfirm" id="userpwConfirm" onkeyup="passwordCheck()">
													<small id="updatePasswordCheckMessage" style="float: right; margin-top: 5px;">비밀번호를 모두 입력해 주세요</small>
												</div>
											</div>
										</div>
										<div class="row" style="margin-top: 50px; text-align: right;">
											<div class="col-sm-12">
												<button type="button" class="btn btn-dark" onclick="updateSubmit();">변경하기</button>
											</div>
										</div>
									</div>
								</div>
								<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<%@ include file="../include/footer.jsp" %>
		
	</div>
	

	<script type="text/javascript">
		
	</script>
</body>
</html>