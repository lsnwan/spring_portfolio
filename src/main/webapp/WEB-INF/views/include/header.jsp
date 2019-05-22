<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<sec:authentication property="principal" var="prinfo"/>

<!DOCTYPE html>
<html>
<head>
</head>
<body>

<nav class="navbar navbar-expand-md bg-white navbar-white fixed-top" style="border-bottom: 1px solid black;">
	<div class="container">
		<a class="navbar-brand" href="${path }/"><Strong style="font-size: 30px; font-family: 'Lobster', cursive;">Project</Strong></a>
		<input id="menuicon" class="navbar-toggler navbar-toggler-right" type="checkbox" data-toggle="collapse" data-target="#collapsibleNavbar">
			<label for="menuicon">
				<span></span>
				<span></span>
				<span></span>
			</label>
		
		<div class="collapse navbar-collapse" id="collapsibleNavbar">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item"><a class="nav-link" href="#">INFO</a></li>
				<li class="nav-item"><a class="nav-link" href="${path }/photo/list">PHOTO</a></li>
				<li class="nav-item"><a class="nav-link" href="${path }/board/list?type=&keyword=&pagenum=1&contentnum=10">BOARD</a></li>
			</ul>
			
			<ul class="navbar-nav my-2 my-lg-0">
			<sec:authorize access="isAnonymous()">
				<li class="nav-item"><a class="nav-link default" href="${path }/users/signup"><i class="fas fa-user-plus"></i> SignUp</a></li>
				<li class="nav-item"><a class="nav-link" href="${path }/login"><i class="fas fa-sign-in-alt"></i> LogIn</a></li>
			</sec:authorize>
			<c:set var="isError" value="${error }" scope="session" />
			<c:if test="${isError eq true }">
				<li class="nav-item"><a class="nav-link default" href="${path }/users/signup"><i class="fas fa-user-plus"></i> SignUp</a></li>
				<li class="nav-item"><a class="nav-link" href="${path }/login"><i class="fas fa-sign-in-alt"></i> LogIn</a></li>			
			</c:if>	
			<sec:authorize access="isAuthenticated()">
				<li class="nav-item">
					<div class="dropdown" style="color: black;">
						<a class="dropdown-toggle" data-toggle="dropdown" style="cursor: pointer;">
							
							<c:if test="${prinfo.profile eq '' }">
								<img class="rounded-circle" width="35" height="35" src="/resources/images/noProfile.png">								
							</c:if>
							
							<c:if test="${prinfo.profile ne '' }">
								<img class="rounded-circle" width="35" height="35" src="/resources/profile/${prinfo.userid }/s_${prinfo.profile}">															
							</c:if>
						</a>
						<div class="dropdown-menu" style="left: -110px;">
							<h5 class="dropdown-header"><sec:authentication property="principal.nickname"/> 님 환영합니다.</h5>
							<a class="dropdown-item" href="${path }/users/updateUser">회원정보 수정</a>
							<a class="dropdown-item" href="${path }/message/tolist">쪽지함</a>

							<c:if test="${prinfo.autho eq 'ROLE_ADMIN' }">
								<a class="dropdown-item" href="${path }/admin/admin">관리자 페이지</a>
							</c:if>

							<div class="dropdown-divider"></div>
							<form action="/logout" method="post">
								<input class="dropdown-item" type="submit" value="로그아웃" />
								<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
							</form>							
						</div>
					</div>
				</li>
				<li>
					
				</li>
			</sec:authorize>
			</ul>			
		</div>
	</div>
</nav>


</body>
</html>
