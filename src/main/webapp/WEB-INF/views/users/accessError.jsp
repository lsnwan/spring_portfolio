<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="../include/include.jsp" %>	
	<!-- link -->
	<link rel="stylesheet" href="/resources/css/custom.css">
</head>

<body>
	
	<div class="wrap">
		<%@ include file="../include/header.jsp" %>
		
		<div class="content">
			<div class="container">
				<div class="card bg-danger text-white text-center">
					<div class="card-body">
						<i class="fas fa-ban" style="width: 80px; height: 80px;"></i> <p class="accessErrorMsg">${msg }</p>
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