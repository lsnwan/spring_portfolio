<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../include/include.jsp" %>	
	<!-- link -->
	<link rel="stylesheet" href="/resources/css/custom.css">
	<script type="text/javascript" src="/resources/js/updateProfile.js"></script>
	
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
							<div class="card">
								<div class="card-body">
									<h4 class="card-title">프로필 변경</h4>
									<br>
									<form action="deleteProfile" method="post" id="deleteForm">
										<div class="row justify-content-sm-center">
											<div class="col-sm-12 text-center">
												<div style="margin:0 auto; position: relative; width: 250px; height: 250px;">
													
													<img src="/resources/images/noProfile.png" class="rounded-circle" id="img" style="width: 250px; height: 250px;">

													<div style="position: absolute; top: 5px; right: 5px;">
														<a id="deleteProfile" style="cursor: pointer;">
															<i class="far fa-times-circle" style="width: 30px; height: 30px;"></i><!-- 프로필 지우기 버튼 -->													
														</a>
													</div>
												</div>
											</div>
										</div>
										<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
									</form>
									<form action="updateProfileAction" method="post" id="updateForm" enctype="multipart/form-data">
										<div class="row justify-content-sm-center">
											<div class="col-sm-8" style="margin-top: 20px;">
												<input type="file" class="form-control" aria-describedby="basic-addon1" name="file" id="input_img">
											</div> 
										</div>
										<br>
										<div class="row justify-content-sm-center">
											<div class="col-sm-8 text-right">
												<button type="button" class="btn btn-dark" id="updateProfile">변경하기</button>
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
		</div>
		
		<%@ include file="../include/footer.jsp" %>
		
	</div>
	
	<script type="text/javascript">
		
		$("#deleteProfile").click(function(e) {
			e.preventDefault();
			if(!confirm('프로필을 초기화 하시겠습니까?')) return;
			$('#deleteForm')[0].submit();
		});
		
		$("#updateProfile").click(function() {
			
			if($("#input_img").val()=="") {
				alert('선택된 이미지가 없습니다.');
				return;
			}
			$("#updateForm")[0].submit();
		});
				
        
	    var sel_file;
	    
	    $(document).ready(function() {
	    	
		    var profile = "s_${prinfo.profile}";

		    if(profile == 's_') {
	    		$("#img").attr("src", "/resources/images/noProfile.png");
	    	} else {
	    		$("#img").attr("src", "/resources/profile/${prinfo.userid}/s_${prinfo.profile}");
	    	}
	    	
	    	
	        $("#input_img").on("change", handleImgFileSelect);
	        
	    }); 
	
	    function handleImgFileSelect(e) {
	        var files = e.target.files;
	        var filesArr = Array.prototype.slice.call(files);
	
	        filesArr.forEach(function(f) {
	            if(!f.type.match("image.*")) {
	                alert("확장자는 이미지만 가능합니다.");
	                $("#input_img").val('');
	                return;
	            }
	
	            sel_file = f;
	
	            var reader = new FileReader();
	            reader.onload = function(e) {
	                $("#img").attr("src", e.target.result);
	            }
	            reader.readAsDataURL(f);
	        });
	    }
	    
	</script>
</body>
</html>