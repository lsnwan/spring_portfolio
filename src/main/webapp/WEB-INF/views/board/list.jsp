<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="../include/include.jsp" %>	
	<!-- link -->
	<link rel="stylesheet" href="/resources/css/custom.css">
</head>

<body>
	
	<div class="wrap">
		<%@ include file="../include/header.jsp" %>
		
		<div class="content">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="userUpdateContent">
							<div class="card">
								<div class="card-body">
									<h4 class="card-title">자유게시판</h4>
									<br>
									<div class="row">
										<div class="col">
											<div class="form-group">
												<select class="form-control-sm" id="contentnum" name="contentnum" onclick="selectedItem();">
													<option value="10">10개 보기</option>
													<option value="20">20개 보기</option>
													<option value="30">30개 보기</option>
												</select>
											</div>									
										</div>
										<div class="col text-right">
											<sec:authorize access="isAnonymous()">
												<a class="btn btn-secondary btn-sm" href="${path }/board/list?type=&keyword=&pagenum=1&contentnum=10">처음으로</a>												
												<a class="btn btn-secondary btn-sm" id="write" href="#">글쓰기</a>
											</sec:authorize>
											<sec:authorize access="isAuthenticated()">
												<a class="btn btn-secondary btn-sm" href="${path }/board/list?type=&keyword=&pagenum=1&contentnum=10">처음으로</a>												
												<a class="btn btn-secondary btn-sm" href="/board/write?type=${type }&keyword=${keyword }&pagenum=${pagenum }&contentnum=${contentnum }">글쓰기</a>												
											</sec:authorize>
										</div>
									</div>
									
									<div class="row">
										<div class="col">
											<table class="table table-hover text-center">
												<thead class="lsitstyle">
													<tr>
														<td style="width: 12%;">번호</td>
														<td style="width: 46%;">제목</td>
														<td style="width: 15%;">글쓴이</td>
														<td style="width: 15%;">조회수</td>
														<td style="width: 12%;">날짜</td>
													</tr>
												</thead>
												
												<tbody class="lsitstyle">

													<c:forEach items="${list }" var="board">
														<tr>
															<td><c:out value="${board.num }"></c:out></td>
															<td style="text-align: left">
																<div class="titleCss">
																	<c:if test="${board.depth > 0 }">
																		<c:forEach begin="0" end="${board.depth }" varStatus="status">
																			&nbsp;&nbsp;
																			<c:if test="${status.index == board.depth-1 }">
																				<img src="/resources/images/replyImg.png">&nbsp; <small>답변:</small>
																			</c:if>
																		</c:forEach>
																	</c:if>
																
																	<a href="/board/get?num=${board.num }&type=${type }&keyword=${keyword }&pagenum=${pagenum}&contentnum=${contentnum}">${board.title }</a>
																</div>
															</td>
															<td>
																<div class="dropdown">
																	<a data-toggle="dropdown" style="cursor: pointer;"><c:out value="${board.nickname }"/></a>
																	<div class="dropdown-menu">
																		<sec:authorize access="isAnonymous()">
																			<a class="dropdown-item" href="#" onclick="loginCheck();">쪽지 보내기</a> 
																		</sec:authorize>
																		<sec:authorize access="isAuthenticated()">
																			<a class="dropdown-item" href="javascript:void(window.open('/message/windowSend?nick=${board.nickname }', '쪽지 보내기','location=no, directories=no, resizable=no, scrollbars=no, width=500, height=400, top=100, left=100'))">쪽지 보내기</a> 
																			
																		</sec:authorize>
																	</div>
																</div> 
															</td>
															<td><c:out value="${board.views }"></c:out></td>
															<td>
																<c:set value="${board.regdate }" var="regdate" />
																${fn:substring(regdate,0,10) }
															</td>
														</tr>
														
													</c:forEach>													

												</tbody>
											</table>								
										</div>
									</div>
									<div class="row">
										<div class="col-lg-4">
											<form action="/board/list?type=${type }&keyword=${keyword}&pagenum=${pagenum}&contentnum=${contentnum}" id="searchForm" method="get">
												<div class="row">
													<div class="col-3">
														<div class="form-group">
															<select class="form-control-sm" id="sel1" name="type">
																<option value="">검색</option>
																<option value="title" <c:out value="${type eq 'title'? 'selected': null }"/>>제목</option>
																<option value="content" <c:out value="${type eq 'content'? 'selected': null }"/>>내용</option>
																<option value="nickname" <c:out value="${type eq 'nickname'? 'selected': null }"/>>글쓴이</option>
															</select>
														</div>	
													</div>
													<div class="col-6">
														<input type="text" class="form-control form-control-sm" name="keyword" value='<c:out value="${keyword }"/>'>
													</div>
													<div class="col-3" style="left: -15px;">
														<button type="button" class="btn btn-secondary btn-sm">검색</button>
													</div>
												</div>
												<input type="hidden" name="pagenum" value="${pagenum }">
												<input type="hidden" name="contentnum" value="${contentnum }">
											</form>
										</div>
										
										<div class="col-lg-8">
											<ul class="pagination pagination-sm" style="float: right;">
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
		</div>
		
		<%@ include file="../include/footer.jsp" %>		
	</div>
	

	<script type="text/javascript">
		$(document).ready(function() {
			
			$('#write').click(function(){
				alert('로그인을 해주세요');
				location.href = "${path}/login";
			});
			
			var cnum = "${contentnum}";
			
			for(var i=0; i<3; i++) {
				var aa = $("#contentnum option:eq(" + i + ")").val();	
				
				if(cnum == aa) {
					$("#contentnum option:eq(" + i + ")").attr("selected", "selected");
				}
			}
			
			
			var sel1 = "${type}";
			for(var i=0; i<4; i++) {
				var type = $("#sel1 option:eq(" + i + ")").val();	
				
				if(sel1 == type) {
					$("#sel1 option:eq(" + i + ")").attr("selected", "selected");
					return;
				} else if (sel1 == null){
					$("#sel1 option:eq(" + 0 + ")").attr("selected", "selected");
				}
				
			}
			
		});
		
		
		function page(idx) {
			var pagenum = idx;
			var t = "${type}";
			var k = "${keyword}";
			var contentnum = $("#contentnum option:selected").val();

			location.href = "${path}/board/list?type=" + t + "&keyword=" + k + "&pagenum=" + pagenum + "&contentnum=" + contentnum;
		}
		
		$("#contentnum").on("change", function() {
			var contentnum = $(this).val();
			location.href = "${path}/board/list?type=&keyword=&pagenum=1&contentnum=" + contentnum;
		});
		
		var searchForm = $("#searchForm");
		
		$("#searchForm button").on("click", function(e) {
			if(!searchForm.find("option:selected").val()) {
				alert("검색종류를 선택하세요");
				return false;
			}
			
			if(!searchForm.find("input[name='keyword']").val()) {
				alert("키워드를 입력하세요");
				return false;
			}
			
			searchForm.find("input[name='pagenum']").val();
			e.preventDefault();
			
			searchForm.submit();
		});
		
		function loginCheck() {
			if(confirm("로그인을 해주세요")) {
				location.href = "/login";
			}
		}
		
	</script>
</body>
</html>