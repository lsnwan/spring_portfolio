<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="../include/include.jsp" %>	
	<!-- link -->
	<link rel="stylesheet" href="/resources/css/custom.css">
	<script src="/resources/ckeditor/ckeditor.js"></script>    
</head>

<body>
	<div class="wrap">
	
		<%@ include file="../include/header.jsp" %>
		
		<div class="content">
			<div class="container">
				<form action="/photo/modify" method="post" onsubmit="return check()" name="fr">
					<div class="row">
						<div class="col-md-12">
							<input type="text" class="form-control" name="title" placeholder="제목" value="${photo.title }">
						</div>
					</div>
				
					<div class="dropdown-divider"></div>
					
					<div class="row">
						<div class="col-md-12">
							<textarea id="description" name="description" rows="5" cols="80" placeholder="내용을 입력하세요">${photo.content }</textarea>
							<script type="text/javascript">
								CKEDITOR.replace("description", {
									height: 500,
									extraPlugins : 'confighelper',
									filebrowserUploadUrl: '<c:url value="/photo/imageUpload?num=${photo.num}"/>&${_csrf.parameterName}=${_csrf.token}'
								});
							</script>
						</div>
					</div>
					
					<div class="dropdown-divider"></div>
					
					<div class="row">
						<div class="col-md-12 text-center">
							<button type="submit" class="btn btn-dark btn-sm">수정하기</button>
						</div>
					</div>
					<input type="hidden" name="num" value="${photo.num }">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				</form>
			</div>
		</div>
		
		<%@ include file="../include/footer.jsp" %>		
		
	</div>
	

	<script type="text/javascript">
		
		function check() {
			
			var str = CKEDITOR.instances.description.getData();
			
			if(fr.title.value == "") {
				alert("제목을 입력해 주세요");
				fr.title.focus();
				return false;
			} else if (str == "") {
				alert("내용을 입력해 주세요");
				fr.description.focus();
				return false;
			} else if (str.indexOf("<img") == -1) {
				alert("이미지를 추가해 주세요");
				return false;
			} else {
				return true;
			}
		}
	</script>
</body>
</html>