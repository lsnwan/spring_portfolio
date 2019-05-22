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
										<a href="${path }/users/findPassword" class="card-link"><i class="fas fa-circle" style="width: 10px; height: 10px; margin-bottom: 2px;"></i>&nbsp;&nbsp;비밀번호 찾기</a>
									</div>
									<div class="card-text" style="margin-top: 10px;">
										<a href="${path }/users/findUserId" class="card-link"><i class="fas fa-circle" style="width: 10px; height: 10px; margin-bottom: 2px;"></i>&nbsp;&nbsp;아이디 찾기</a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-9">
						<div class="userUpdateContent">
							<form action="findUserId" method="post">
								<div class="card">
									<div class="card-body">
										<h4 class="card-title">아이디 찾기</h4>
										<br>
										<div class="row">
											<div class="col-sm-12">
												<h6>가입시 입력한 이메일을 입력해 주세요.</h6>
											</div>
										</div>
										<br>
										<div class="row">
											<div class="col-sm-3">
												<div class="userUpdateName">
													<strong>이메일</strong>
												</div>
											</div>
											<div class="col-sm-9">
												<div class="userUpdateSelect">
													<input type="email" class="form-control" name="email">
												</div>
											</div>
										</div>
										<br>
										<div class="row" style="margin-top: 50px; text-align: right;">
											<div class="col-sm-12">
												<input type="submit" class="btn btn-dark" value="아이디 찾기"/>
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