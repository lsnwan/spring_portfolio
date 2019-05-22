<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../include/include.jsp" %>	
	<!-- link -->
	<link rel="stylesheet" href="/resources/css/custom.css">
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
							<div class="card">
								<div class="card-body">
									<h4 class="card-title">아이디 찾기</h4>
									<br>
									<div class="row">
										<div class="col-sm-12">
											<h6>회원님의 아이디는 아래와 같습니다.</h6>
										</div>
									</div>
									<br>
									<div class="row">
										<div class="col-sm-3">
											<div class="userUpdateName">
												<strong>아이디</strong>
											</div>
										</div>
										<div class="col-sm-9">
											<div class="userUpdateSelect">
												<p>${findid }</p>
											</div>
										</div>
									</div>
									<br>
									<div class="row" style="margin-top: 50px; text-align: right;">
										<div class="col-sm-12">
											<a class="btn btn-dark" href="/users/findPassword">비밀번호 찾기</a>
										</div>
									</div>
								</div>
							</div>
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