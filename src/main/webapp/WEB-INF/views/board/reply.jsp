<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="../include/include.jsp" %>	
	<!-- link -->
	<link rel="stylesheet" href="/resources/css/custom.css">
	<link href="/resources/summernote/summernote-bs4.css" rel="stylesheet">
    <script src="/resources/summernote/summernote-bs4.js"></script>
    <script type="text/javascript">
    	$(function(){
    		$("#description").summernote({
    			height: 400,
    			placeholder: "내용",
    		});
    	});
    </script>
    
</head>

<body>
	<div class="wrap">
	
		<%@ include file="../include/header.jsp" %>
		
		<div class="content">
			<div class="container">
				<form action="/board/reply" method="post" enctype="multipart/form-data">
					<div class="row">
						<div class="col-sm">
							<input type="text" class="form-control" name="title" id="title" placeholder="제목">
						</div>								
					</div>
					
					<br>
					
					<div class="row">
						<div class="col-sm">
							<textarea id="description" name="content"></textarea>
						</div>
					</div>
					
					<br>
					
					<div class="row">
						<div class="col-sm text-left">
							<button type="button" class="btn btn-dark btn-sm" id="addbtn">파일추가</button>
						</div>
					</div>
						
					<div id="fileAdd">

					</div>
					
					<br>
					
					<div class="row">
						<div class="col-sm text-center">
							<button type="button" class="btn btn-dark">돌아가기</button>
							<button type="submit" class="btn btn-dark">답변달기</button>
						</div>
					</div>
					<input type="hidden" name="type" value="${type }">
					<input type="hidden" name="keyword" value="${keyword }">
					<input type="hidden" name="pagenum" value="${pagenum }">
					<input type="hidden" name="contentnum" value="${contentnum }">
					<input type="hidden" name="ref" value="${board.getRef() }">
					<input type="hidden" name="pos" value="${board.getPos() }">
					<input type="hidden" name="depth" value="${board.getDepth() }">
					
					
					
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				</form>
			</div>
		</div>

		<%@ include file="../include/footer.jsp" %>		
		
	</div>
	

	<script type="text/javascript">
		var countlist = 0;
		$("#addbtn").click(function(){
			countlist++;
			if(countlist > 5) {
				alert("파일 업로드는 최대 5개까지만 가능 합니다.");
				countlist = 5;
			} else {
				$("#fileAdd").append('<div class="fileline' + countlist + '"><div class="row" style="margin-top: 5px;"><div class="col-10"><input type="file" id="files' + countlist + '" name="files" class="form-control" onchange="uploadCheck(' + countlist + ')"></div><div class="col-1"><i class="far fa-times-circle" style="width: 20px; height: 20px; margin-top: 8px" onclick="deletefile(' + countlist + ');"></i></div></div></div>');				
			}
		});
		
		function deletefile(count) {
			$(".fileline"+count).remove();
			countlist--;
		}
		
		function uploadCheck(count) {
			
			limitSize = 20971520;
			var fileSize  = $('#files'+count)[0].files[0].size;
			 
			if(fileSize > limitSize) {
				alert("파일 사이즈는 " + (20971520/1024)/1024 + "MB까지만 등록 가능 합니다.");
			
				$('#files'+count).val('');
				return;
			}
			
			if($('#files'+count).val() != '') {
				
				var ext = $('#files'+count).val().split(".").pop().toLowerCase();

				if($.inArray(ext, ["jsp","java","class","js"]) != -1){
	                alert("해당 파일은 업로드할 수 없습니다.");
	                $('#files'+count).val('');
	                return;
	            }				
			}
		
		}
		
	</script>
</body>
</html>