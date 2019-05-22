<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<head>
	<%@ include file="../include/include.jsp" %>	
	<!-- link -->
	<link rel="stylesheet" href="/resources/css/custom.css">
	<script>
		var userYear = "${year}";
		var userMonth = "${month}";
		var userDay = "${day}";
	</script>
	<script type="text/javascript" src="/resources/js/userUpdate.js"></script>
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
							<form role="form" action="/users/userUpdate" method="POST" name="updateForm">
								<div class="card">
									<div class="card-body">
										<h4 class="card-title">회원정보변경</h4>
										<br>
										<div class="row">
											<div class="col-sm-3">
												<div class="userUpdateName">
													<strong>아이디</strong>
												</div>
											</div>
											<div class="col-sm-9">
												<div class="userUpdateSelect">
													<p>${userid }</p>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-sm-3">
												<div class="userUpdateName">
													<strong>닉네임</strong>
												</div>
											</div>
											<div class="col-sm-9">
												<div class="userUpdateSelect">
													<p>${nickname }</p>
												</div>
											</div>
										</div>
										
										<div class="row">
											<div class="col-sm-3">
												<div class="userUpdateEmail">
													<strong>생년월일</strong>
												</div>
											</div>
											<div class="col-sm-9">
												<div class="row">
													<div class="col-sm-4">
														<div class="row">
															<div class="col-sm-8">
																<select class="form-control" name="year" id="year"></select>						
															</div>
															<div class="col-sm-4">
																<div style="margin-top: 5px;">
																	<strong>년</strong>													
																</div>
															</div>
														</div>
													</div>
													<div class="col-sm-4">
														<div class="row">
															<div class="col-sm-8">
																<select class="form-control" name="month" id="month"></select>						
															</div>
															<div class="col-sm-4">
																<div style="margin-top: 5px;">
																	<strong>월</strong>													
																</div>
															</div>
														</div>
													</div>
													<div class="col-sm-4">
														<div class="row">
															<div class="col-sm-8">
																<select class="form-control" name="day" id="day"></select>		
															</div>
															<div class="col-sm-4">
																<div style="margin-top: 5px;">
																	<strong>일</strong>													
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
										
										<div class="row" style="margin-top: 15px;">
											<div class="col-sm-3">
												<div class="userUpdateEmail">
													<strong>이메일</strong>
												</div>
											</div>
											<div class="col-sm-9">
												<div class="userUpdateSelect">
													<input type="email" class="form-control" name="email" id="email" value="${email }" maxlength="50" onkeyup="selectEmail();">
													<input type="hidden" name="userEmail" id="userEmail" value="<sec:authentication property="principal.email"/>">
													<label id="emailCheck" style="float: right;"></label>
												</div>
											</div>
										</div>
										
										<div class="row" style="margin-top: 50px; text-align: right">
											<div class="col-sm-12">
												<button type="button" class="btn btn-dark" id="updateBtn" onclick="updateSubmit();">수정하기</button>
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