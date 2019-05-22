<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="../include/include.jsp" %>	
	<!-- link -->
	<link rel="stylesheet" href="/resources/css/custom.css">
	
	<style>
	  /* Make the image fully responsive */
	  .carousel-inner img {
	      width: 100%;
	      height: 100%;
	  }
	</style>
</head>

<body>
	
	<div class="wrap">
		<%@ include file="../include/header.jsp" %>
		
		<div class="content">
			<div class="container">
				
				<div class="card">
					<div class="card-body">
						<h4 class="card-title">이미지게시판</h4>
						<br>
						<div class="row">
							<div class="col-sm-12 text-right">
								<a class="btn btn-secondary btn-sm" href="/photo/list">처음으로</a>
								<a class="btn btn-secondary btn-sm" href="/photo/write">글쓰기</a>
							</div>
						</div>
						<div class="dropdown-divider"></div><br>
						<div class="row">
							<div class="col-sm-12">
								
								<c:set var="photo" value="${list }" />
								<c:set var="i" value="0" />
								
								<c:forEach begin="1" end="3" step="1">
									
									<div class="row">
									
									<c:forEach begin="1" end="4" step="1">
										
										<c:if test="${i < list.size() }">
											<div class="col-md-3" style="margin-bottom: 10px;">
												<div class="card">
													<img class="card-img-top" src="${photo[i].filename }" height="180" data-toggle="modal" data-target="#myModal" onclick="showImages(${photo[i].num});" style="cursor: pointer;">
													<div class="card-body">
														<div class="row">
															<div class="col-6">
																<p class="card-text">${photo[i].nickname }</p>
															</div>
															<div class="col-6 text-right">
																<p class="card-text">
																	<c:set value="${photo[i].regdate }" var="regdate" />
																	${fn:substring(regdate,5,10) }
																</p>
															</div>
														</div>
														<div class="row">
															<div class="col-sm">
																<div class="photo_title">
																	<p class="card-text"><a href="/photo/get?num=${photo[i].num }"><small>${photo[i].title }</small></a></p>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</c:if>
										
										<c:set var="i" value="${i+1 }"/>
									</c:forEach>
									
									</div>
									<br>
									
								</c:forEach>
								
								<div class="dropdown-divider"></div>
								<br>
								<div class="row">
									<div class="col-sm-12">
										<ul class="pagination pagination-sm justify-content-center">
											 <c:if test="${page.isPrev() }">
												  <li class="page-item"><a class="page-link" href="javascript:page(${page.getStartpage()-1 });"><i class="fas fa-angle-left"></i></a></li>												  	
											  </c:if>
											  <c:forEach begin="${page.getStartpage() }" end="${page.getEndpage() }" var="idx">
												  <li class="page-item ${pagenum eq idx? 'active' : null }" id="activeCheck"><a class="page-link" href="javascript:page(${idx });">${idx }</a></li>												  	
											  </c:forEach>
											  <c:if test="${page.isNext() }">
												  <li class="page-item"><a class="page-link" href="javascript:page(${page.getEndpage()+1 })"><i class="fas fa-angle-right"></i></a></li>
											  </c:if>
										</ul>
									</div>
								</div>
							</div>
						</div>
						
					</div>
				</div>
				
			</div>
		</div>
		
		<%@ include file="../include/footer.jsp" %>		
		
	</div>
	
	<!-- Modal -->
	<div class="modal fade" id="myModal">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content">
			
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">사진 보기</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				
				<!-- Modal body -->
				<div class="modal-body">
				</div>
				
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
				</div>
			
			</div>
		</div>
	</div>

	<script type="text/javascript">
	function page(idx) {
		var pagenum = idx;

		location.href = "${path}/photo/list?&pagenum=" + pagenum + "&contentnum=12";
	}
	
	function showImages(num) {
		
		$.getJSON("/photo/showImages/" + num + ".json", function(images) {
			
			var imageHTML = $(".modal-body");
			var str = "";
			
			console.log("가져온 images 길이: " + images.length);
		
			str += '<div id="showImage" class="carousel slide" data-ride="carousel">';
			str += '<ul class="carousel-indicators">';
			
			for(var i=0; i<images.length; i++) {
				if(i == 0) {
					str += '<li data-target="#showImage" data-slide-to="' + i + '" class="active"></li>';									
				} else {
					str += '<li data-target="#showImage" data-slide-to="' + i + '"></li>';
				}
			}
			
			str += '</ul>';
			
			str += '<div class="carousel-inner">';
			
			for(var i=0; i<images.length; i++) {
				if(i == 0) {
					str += '<div class="carousel-item active">';
					str += '<img src="/resources/photo/' + num + '/' + images[i] + '" width="1100" height="500">';
					str += '</div>';
				} else {
					str += '<div class="carousel-item">';
					str += '<img src="/resources/photo/' + num + '/' + images[i] + '" width="1100" height="500">';
					str += '</div>';					
				}
			}
			
			str += '</div>';
			
			str += '<a class="carousel-control-prev" href="#showImage" data-slide="prev">';
			str += '<span class="carousel-control-prev-icon"></span>';
			str += '</a>';
			str += '<a class="carousel-control-next" href="#showImage" data-slide="next">';
			str += '<span class="carousel-control-next-icon"></span>';
			str += '</a>';
			str += '</div>';

			console.log(str);
			imageHTML.html(str);
		});
		
		
	}
	
	</script>
</body>
</html>