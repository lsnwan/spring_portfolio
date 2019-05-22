<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
		
				<div class="row">
					<div class="col-md-3">
						<div class="card">
							<div class="card-body">
								<div class="card-text" style="margin-bottom: 5px;">
									<a class="btn btn-secondary btn-block" href="/message/send">
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
									<a class="btn btn-outline-secondary btn-block" href="/message/tomelist">
										내게 쓴 쪽지함
									</a>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-9">
						<div class="card">
							<div class="card-body">
								<form action="/message/send" method="post" onsubmit="return check();" name="fr">
									<div class="row">
										<div class="col">
											받는사람
										</div>
										<div class="col text-right">
											<input type="checkbox" class="form-check-input" name="tomeCheck" id="tomeCheck">내게쓰기
										</div>
									</div>
									<div class="row">
										<div class="col-sm-12">
											<input type="text" class="form-control" name="toUser" value="${toUserr }">
										</div>
									</div>
															
									<div class="row" style="margin-top: 8px;">
										<div class="col">
											<textarea class="form-control" maxlength="1000" rows="5" name="toContent" style="height: 300px;">${toContentr }</textarea>
										</div>
									</div>
									
									<div class="row" style="margin-top: 8px;">
										<div class="col">
											<p class="thousand">0 / 1000 자</p>
										</div>
										
										<div class="col text-right">
											<button type="submit" class="btn btn-secondary">보내기</button>
										</div>
									</div>
									<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
								</form>
							</div>
						</div>
					</div>
				</div>
			
		
			</div>
			
		</div>
		
				
		<%@ include file="../include/footer.jsp" %>		
	</div>
	

	<script type="text/javascript">
	
	// Submit 체크 함수
	function check() {
		
		var contentLength = fr.toContent.value.length; // 내용의 길이
		
		if(fr.toUser.value == "") {
			alert("보내는 사람(닉네임)을 입력해 주세요");
			fr.toUser.focus();
			return false;
		} else if (contentLength == 0) {
			alert("내용을 입력하세요");
			fr.toContent.focus();
			return false;
		} else if (contentLength < 5) {
			alert("5자 이상 입력해 주세요");
			fr.toContent.focus();
			return false;
		} else {
			return true;
		}
	}
	
	$(document).ready(function() {
		
		var toUser = $("input[name='toUser']"); // 받는사람 input
		var content = $("textarea[name='toContent']");
		
		var errorMessage = "<c:out value='${errorMessage}'/>";
		
		if(errorMessage == "toError") {
			alert("받는사람을 확인해 주세요");
			fr.toUser.focus();
			errorMessage = "";
		}
		
		// 내게쓰기 체크 이벤트
		$("#tomeCheck").change(function(){
	        if($("#tomeCheck").is(":checked")){
	        	toUser.val("<c:out value='${to}'/>");
	        	toUser.attr("readonly", "readonly");
	        }else{
	        	toUser.val("");
	        	toUser.removeAttr("readonly");
	        }
	    });
		
		// 1000자 확인
		content.keyup(function() {
			var str = content.val();
			$(".thousand").html(str.length + " / 1000 자");
		});
		
		
	
	});
	


	</script>
</body>
</html>