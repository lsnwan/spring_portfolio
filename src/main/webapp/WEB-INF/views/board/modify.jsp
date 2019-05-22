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
    			height: 400
    		});
    	});
    </script>
    
</head>

<body>
	<div class="wrap">
	
		<%@ include file="../include/header.jsp" %>
		
		<div class="content">
			<div class="container">
				<form action="/board/modify" method="post" enctype="multipart/form-data">
					<div class="row">
						<div class="col-sm">
							<input type="text" class="form-control" name="title" id="title" placeholder="제목" value="${board.title }">
						</div>								
					</div>
					
					<br>
					
					<div class="row">
						<div class="col-sm">
							<textarea id="description" name="content">${board.content }</textarea>
						</div>
					</div>
					
					<br>
					<div class="dropdown-divider"></div>
					<br>
					
					<div class="row">
						<div class="col-sm text-left">
							<button type="button" class="btn btn-dark btn-sm" id="addbtn">파일추가</button>
						</div>
					</div>
						
					<div id="uploadfile">
						<c:if test="${upload.size() ne '0' }">
							<c:forEach items="${upload }" var="upload" varStatus="status">
								<div class="uploadFile${status.index }" style="width: 100%;">
									<div class="row" style="margin-top: 5px; margin-left: 1px;">
										<div class="col-10">
											<input type="text" class="form-control" value="${upload.subFileName }" disabled="disabled">
										</div>
										<div class="col-2">
											<i class="far fa-times-circle" style="cursor:pointer; width: 20px; height: 20px; margin-top: 8px" onclick='deleteUploadfile("${upload.filename}", "${num }", "${status.index }")'></i>										
										</div>
									</div>
								</div>
							</c:forEach>
						</c:if>
					</div>
						
					<div id="fileAdd">
					</div>
					
					<br>
					
					<div class="row">
						<div class="col-sm text-center">
							<button type="button" class="btn btn-dark" onclick="javascript:history.back();">돌아가기</button>
							<button type="submit" class="btn btn-dark">수정하기</button>
						</div>
					</div>				
					<input type="hidden" name="num" value="${num }">
					<input type="hidden" name="type" value="${type }">
					<input type="hidden" name="keyword" value="${keyword }">
					<input type="hidden" name="pagenum" value="${pagenum }">
					<input type="hidden" name="contentnum" value="${contentnum }">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				</form>
			</div>
		</div>

		<%@ include file="../include/footer.jsp" %>		
		
	</div>
	

	<script type="text/javascript">
		var countlist = "${uploadCount}";
		
		$("#addbtn").click(function(){
			countlist++;
			
			if(countlist > 5) {
				alert("파일 업로드는 최대 5개까지만 가능 합니다.");
				countlist = 5;
				
			} else {
				$("#fileAdd").append('<div class="fileline' + countlist + '"><div class="row" style="margin-top: 5px;"><div class="col-10"><input type="file" id="files' + countlist + '" name="files" class="form-control" onchange="uploadCheck(' + countlist + ')"></div><div class="col-1"><i class="far fa-times-circle" style="cursor:pointer; width: 20px; height: 20px; margin-top: 8px" onclick="deletefile(' + countlist + ');"></i></div></div></div>');				
			}
		});
		
		function deletefile(count) {
			$(".fileline"+count).remove();
			countlist--;
		}
		
		function deleteUploadfile(filename, num, index) {
			
			
			if(confirm("해당 파일을 삭제 하시겠습니까?")) {
				var userid = "${board.userid}";

				$.ajax({
					type: 'POST',
					url: '/board/fileDelete',
					data: { filename : filename, userid : userid, num : num },
					beforeSend : function(xhr) {   
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                    },
					success: function(result) {
						if(result == 1){
							$(".uploadFile"+index).remove();
							countlist--;
							alert("파일이 삭제 되었습니다.");
						} else if(result == 0){
							alert("파일 삭제에 실패 했습니다.");
						} else {
							alert("파일이 존재하지 않습니다.");
						}
					}
				});	
			}
			
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