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
										<div class="col-md" style="margin-bottom: 10px;">
											<button class="btn btn-danger btn-sm" id="deleteMessage">삭제</button>
											
											&nbsp;<small>total: ${total }</small>
										</div>
										<div class="col-md-5 text-right">
											<form action="/message/tomelist?type=${type }&keyword=${keyword}" onsubmit="return frCheck();" name="fr" method="get">
												<div class="input-group md-3">
													<input type="text" class="form-control form-control-sm" name="keyword" id="keyword" placeholder="Search" value="${keyword }">												
													<div class="input-group-append">
														<input type="submit" class="btn btn-secondary btn-sm" value="검색">
													</div>
												</div>
											</form>
										</div>
									</div>
									<br>
									
									<div class="row">
										<table class="table" style="font-size: 12px; text-align: center;">
											<thead class="sendTableProper">
												<tr>
													<th>
														<input type="checkbox" id="allCheckBox">
													</th>
													<th class="messageFromuser">
														받는사람
													</th>
													<th class="messageContent">
														내용
													</th>
													<th class="messageDate">
														날짜
													</th>
												</tr>
											</thead>
											<tbody>
												<c:choose>
													<c:when test="${empty list }">
														<tr>
															<td colspan="4">쪽지가 없습니다.</td>
														</tr>
													</c:when>
													<c:otherwise>
														<c:forEach items="${list }" var="message">
														<c:set var="isRead" value="${message.readnum }"/>
														<c:set var="isToAvail" value="${message.toavailable }"/>
														<c:set var="isSendCancel" value="${message.sendcancel }"/>
														<tr>
															<td><input type="checkbox" id="checkbox" value="${message.no }" onclick="check(this)"></td>
															<td class="messageFromuser">
																<small style="color: gray; font-size: 12px">
																	${message.touser }
																</small>																
															</td>
															<td class="messageContenttd">
																<span class="messageText">
																	<a href="/message/tomeRead?no=${message.no }" style="color: gray;">
																		${message.content }
																	</a>																
																</span>
															</td>
															<td class="messageDate">
																<c:set value="${message.regdate }" var="regdate" />
																<span style="color: gray;">${fn:substring(regdate,0,10) }</span>
															</td>
														</tr>
														
														</c:forEach>
													</c:otherwise>
												</c:choose>
												
											</tbody>
										</table>
									</div>
									<div class="dropdown-divider"></div><br>
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
			
		</div>
		
				
		<%@ include file="../include/footer.jsp" %>		
	</div>
	

	<script type="text/javascript">
	
	// 검색 form 전송 체크
	function frCheck() {
		
		if(fr.type.value == "-") {
			alert("검색 유형을 선택해 주세요");
			return false;
		} else if (fr.keyword.value.trim() == "") {
			alert("검색할 단어를 작성해 주세요");
			
			$("input[name='keyword']").val("");
			fr.keyword.focus();
			return false;
		} else {
			return true;
		}
		
	}
	
	// 페이징 번호 이동
	function page(idx) {
		var pagenum = idx;
		
		var type = "${type}";
		var keyword = "${keyword}";
		
		if(type == "" && keyword == "") {
			location.href = "${path}/message/tomelist?&pagenum=" + pagenum;
		} else {
			location.href = "${path}/message/tomelist?&pagenum=" + pagenum + "&type=" + type + "&keyword=" + keyword;			
		}
		
	}
	
	$(document).ready(function(){
		
		// 삭제 버튼
		$("#deleteMessage").click(function() {

			var values = []
			
			$("input[id='checkbox']:checked").each(function() {
				
				values.push($(this).val()); 
				
			});
			
			if(values.length == 0) {
				alert("삭제할 쪽지를 선택 하세요.");
			} else {
				if(confirm("메시지를 삭제 하시겠습니까?")) {
					
					
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					
					$.ajax({
						type: 'post',
						url: '/message/tomedelete',
						traditional : true,
						data: {values: values},
						beforeSend: function(xhr) {
				            xhr.setRequestHeader(header, token);
				        },
						success: function(result) {
							if (result == "success") {
								location.href = "/message/tomelist";
							} else {
								alert("쪽지를 삭제하지 못했습니다.");
							}
						}
	
					});
				}
			}
		});
		 
		// 답장하기 버튼
		$("#reSend").click(function() {
			var l = $("input:checkbox[id='checkbox']:checked");
			
			if(l.length == 1) {
				
				$("input[id='checkbox']:checked").each(function() {
					var no = $(this).val(); 
	
					location.href = "/message/reSend?no="+no;
	
				});

			} else if (l.length == 0){
				alert("답장 보낼 쪽지를 선택해 주세요.");
			} else {
				alert("하나만 선택해 주세요");
			}

			
		});
		
		
	    //전체선택 체크박스 클릭
		$("#allCheckBox").click(function(){
		
			//만약 전체 선택 체크박스가 체크된상태일경우
			if($("#allCheckBox").prop("checked")) {
				$("input[type=checkbox]").prop("checked",true);
			
				
			} else { // 전체선택 체크박스가 해제된 경우
				$("input[type=checkbox]").prop("checked",false);
			}
		});
	    
	    
	});
	
	// 체크박스 전체 선택시 thead 체크박스 자동 선택
	function check(box) {
		var l = $("input:checkbox[id='checkbox']:checked").length; // 체크된 개수
		var totalL = $("input[id='checkbox']").length; // 화면 체크박스의 총 개수
		
		if(box.checked == true) {
			if( l == totalL ) {
				$("#allCheckBox").prop("checked",true);
			} 
		} else {
			if (l < totalL) {
				$("#allCheckBox").prop("checked",false);
			}
		}
	}
	
	
	
	</script>
</body>
</html>