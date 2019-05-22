<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="../include/include.jsp" %>	
	<!-- link -->
	<link rel="stylesheet" href="/resources/css/custom.css">
	<style type="text/css">
		#us {
			text-align: right;
			vertical-align: bottom;
			padding-right: 20px;
		}
	</style>
</head>

<body>

<div class="wrap">
	<div class="content">
		<div class="container">
			<div class="row">
				<table style="width: 100%;">
					<tr>
						<td style="margin-top: 4px; padding-left: 20px; vertical-align: bottom;"><h3><a href="/">PROJECT</a></h3></td>
						<td id="us"><h6>[ <a href="/users/signup">SIGNUP</a> | <a href="/login">LOGIN</a> ]</h6></td>
					</tr>
				</table>
			</div>
			
			<div class="card">
				<div class="card-header text-center">
					<h2>ERROR PAGE</h2>
				</div>
				<div class="card-body text-center">
					<div class="row">
						<div class="col-md-4 text-right">
							<img width="200" height="200" src="/resources/images/danger.png">
						</div>
						<div class="col-md-8 text-left">
							<br>
							<p>잘못된 요청 입니다.(400)</p>
							<p>관리자에게 문의해 주시기 바랍니다.</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../include/footer.jsp" %>
</div>


<script type="text/javascript">
/* 
	$(document).ready(function() {
		
		$(".col-md-4").mouseup(function(){
			var windowWidth = $( window ).width();
			if(windowWidth < 751) {
				$(".col-md-4").attr('class', 'col-md-4');
			} else {
				$(".col-md-4").attr('class', 'col-md-4 text-right');
			}
		});
		
		
		
	});
 */	
	$(window).resize(function() {
		var windowWidth = $( window ).width();
		if(windowWidth < 751) {
			$(".col-md-4").attr('class', 'col-md-4');
		} else {
			$(".col-md-4").attr('class', 'col-md-4 text-right');
		}
	});
	
</script>
</body>
</html>