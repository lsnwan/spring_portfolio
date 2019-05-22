<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<head>
	<%@ include file="../include/include.jsp" %>	
	<!-- link -->
	<link rel="stylesheet" href="/resources/css/custom.css">
	
	
</head>

<body style="position: relative; " data-spy="scroll" data-target="navbar-example" data-offset="25">
	
	<div class="wrap">
		<%@ include file="../include/header.jsp" %>
		
		<div class="content">
		
			<div class="container">
		
				<div class="row" style="margin-bottom: 10px;">
					<div class="col-md-3">
						<div class="card">
							<div class="card-body">
								<div class="card-text" style="margin-bottom: 5px;">
									<a class="btn btn-outline-secondary btn-block" href="/message/send">
										쪽지 보내기
									</a>
								</div>
								<div class="card-text" style="margin-bottom: 5px;">
									<a class="btn btn-outline-secondary btn-block" href="/message/tolist">
										받은 쪽지함
									</a>
								</div>
								<div class="card-text" style="margin-bottom: 5px;">
									<a class="btn btn-outline-secondary btn-block" href="/message/sendlist">
										보낸 쪽지함
									</a>
								</div>
								<div class="card-text" style="margin-bottom: 5px;">
									<a class="btn btn-secondary btn-block" href="/message/tomelist">
										내게 쓴 쪽지함
									</a>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-9">
						<div class="card">
							<div class="card-body">
							
								<div class="card-text">
									<div class="row">
										<div class="col">
											<button class="btn btn-danger btn-sm" id="deleteMessage">삭제</button>
										</div>
										<div class="col text-right">
											<button class="btn btn-secondary btn-sm" onclick="javascript:history.back();">돌아가기</button>										
										</div>
									</div>
									<div class="dropdown-divider"></div>
									<div class="row">
										<div class="col">
											<small>보낸 사람 : ${message.fromuser }</small>
										</div>
									</div>
									<div class="row">
										<div class="col">
											<c:set value="${message.regdate }" var="regdate" />
											<small>받은 시간 : ${fn:substring(regdate,0,16) }</small>
										</div>
									</div>
									<div class="dropdown-divider"></div>
									<br>
									<div class="row">
										<div class="col">
											${message.content }
										</div>
									</div>
									<br>
									<div class="dropdown-divider"></div>
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
	
	$(document).ready(function(){
		
		// 삭제 버튼
		$("#deleteMessage").click(function() {
			
			if(confirm("쪽지를 삭제 할까요?")) {
				var no = "${message.no}";
				
				var token = $("meta[name='_csrf']").attr("content");
				var header = $("meta[name='_csrf_header']").attr("content");
				
				$.ajax({
					type: 'post',
					url: '/message/tomedelete',
					data: {no: no},
					beforeSend: function(xhr) {
			            xhr.setRequestHeader(header, token);
			        },
					success: function(result) {
						if (result == "success") {
							location.href = "/message/tomelist";
						} else {
							alert("쪽지 삭제를 실패 했습니다.");
						}
					}
				});
			}
			
		});
		
		// 답장 보내기 
		$("#reSend").click(function() {

			window.open('/message/windowSend?nick=${message.fromuser}', '쪽지 보내기','location=no, directories=no, resizable=no, scrollbars=no, width=500, height=400, top=100, left=100');
			
		});
		
		
	    
	    
	});
	
	</script>
</body>
</html>