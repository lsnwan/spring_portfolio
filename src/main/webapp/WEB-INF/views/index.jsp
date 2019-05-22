<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="include/include.jsp" %>	
	<!-- link -->
	<link rel="stylesheet" href="/resources/css/custom.css">
</head>

<body style="position: relative; " data-spy="scroll" data-target="navbar-example" data-offset="25">
	
	<div class="wrap">
		<%@ include file="include/header.jsp" %>
		
		<div class="jumbotron jumbotron-fluid" style="margin-top: 72px; background-image: url('resources/images/back.jpg'); background-size: cover; height: 300px; color: white;">
		  <div class="container">
		    <h1 style="text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;">안녕하세요</h1>      
		    <br>
		    <p style="text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;">이곳은 자바 스프링 프레임워크 공부하기 위해 제작 중인 사이트 입니다.</p>
		  </div>
		</div>
		
		<div class="content" style="margin-top: -40px;">
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
						<div class="card">
							<div class="card-body">
								<div class="row">
									<div class="col-sm">
										<p style="font-weight: bold;">[ PHOTO ]</p>								
									</div>
								</div>
								<div class="row" style="margin-top: -10px;">
									
									<c:set var="photoList" value="${photo }"/>
									<c:set var="i" value="0"/>
									
									<c:forEach begin="1" end="4" step="1">
										
										<c:if test="${i < photoList.size() }">
										
											<div class="col-lg-3" style="margin-top: 8px;">
												<div class="card">
													<img class="card-img-top" src="${photoList[i].filename }" height="180" data-toggle="modal" data-target="#myModal" onclick="showImages(${photoList[i].num});"  style="cursor: pointer;">
													<div class="card-body">
														<div class="row">
															<div class="col-6">
																<p class="card-text">${photoList[i].nickname }</p>
															</div>
															<div class="col-6 text-right">
																<p class="card-text">
																	<c:set value="${photoList[i].regdate }" var="regdate" />
																	${fn:substring(regdate,5,10) }
																</p>
															</div>
														</div>
														<div class="row">
															<div class="col-sm">
																<div class="photo_title">
																	<p class="card-text"><small><a href="/photo/get?num=${photoList[i].num }">${photoList[i].title }</a></small></p>
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
							</div>
						</div>
					</div>
				</div>
				<br>
				<div class="row" style="margin-top: -13px;">
					<div class="col-lg-12">
						<div class="card">
							<div class="card-body">
								<div class="row text-center">
									
									<div class="col-lg-4" style="margin-top: 8px;">
										<p style="text-align: left; font-weight: bold;">[ BOARD ]</p>
										<table class="table table-hover">
											<tr>
												<th>번호</th>
												<th>제목</th>
											</tr>
											<c:forEach items="${list }" var="board">
											<tr>
												<td><c:out value="${board.num }" /></td>
												<td>
													<div class="index_board_title">
														<a href="/board/get?num=${board.num }&type=&keyword=&pagenum=1&contentnum=10"><c:out value="${board.title }"/></a>
													</div>
												</td>
											</tr>
											</c:forEach>	
										</table>
									</div>
										
									<% for(int i=0; i<2; i++) { %>
										<div class="col-lg-4" style="margin-top: 8px;">
											<p style="text-align: left; font-weight: bold;">[ TEST<%= i+1 %> ]</p>
											<table class="table table-hover">
												<tr>
													<th>번호</th>
													<th>제목</th>
												</tr>
												<tr>
													<td>1</td>
													<td style="text-align: left;"><a href="#">1번 테스트 최근 게시글</a></td>
												</tr>							
												<tr>
													<td>2</td>
													<td style="text-align: left;"><a href="#">2번 테스트 최근 게시글</a></td>
												</tr>							
												<tr>
													<td>3</td>
													<td style="text-align: left;"><a href="#">3번 테스트 최근 게시글</a></td>
												</tr>							
											</table>
										</div>
									<%} %>
								</div>
							</div>
						</div>
					</div>
				</div>
				
			</div>
		</div>
		
		<%@ include file="include/footer.jsp" %>		
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
	function showImages(num) {
		
		$.getJSON("/photo/showImages/" + num + ".json", function(images) {
			
			var imageHTML = $(".modal-body");
			var str = "";
			
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

			imageHTML.html(str);
		});
		
	}
	</script>
</body>
</html>