<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../include/include.jsp" %>	
	<!-- link -->
	<link rel="stylesheet" href="/resources/css/custom.css">
</head>

<body>

	<div class="wrap" style="margin-top: 20px;">

		<div class="col-md-9">
			<div class="card">
				<div class="card-body">
					<form action="/message/windowSend" method="post" onsubmit="return check()" name="fr">
						<div class="row">
							<div class="col">받는사람</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<input type="text" class="form-control" name="toUser" value="${nick }" readonly="readonly">
							</div>
						</div>

						<div class="row" style="margin-top: 8px;">
							<div class="col">
								<textarea class="form-control" maxlength="1000" rows="5" name="toContent" style="height: 200px;">${toContentr }</textarea>
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
						<input type="hidden" name="${_csrf.parameterName }"
							value="${_csrf.token }">
					</form>
				</div>
			</div>
		</div>
	</div>





	<script type="text/javascript">
		// Submit 체크 함수
		function check() {

			var contentLength = fr.toContent.value.length; // 내용의 길이

			if (fr.toUser.value == "") {
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

			var content = $("textarea[name='toContent']");

			// 1000자 확인
			content.keyup(function() {
				var str = content.val();
				$(".thousand").html(str.length + " / 1000 자");
			});

		});
	</script>
</body>
</html>