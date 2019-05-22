<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<meta name="_csrf" content="${_csrf.token}"/>
	<meta name="_csrf_header" content="${_csrf.headerName}"/>
<head>
	<%@include file="../include/include.jsp" %>	
	<!-- link -->
	<link rel="stylesheet" href="/resources/css/custom.css">
	<script src="/resources/ckeditor/ckeditor.js"></script> 
	<script src="/resources/js/photoReply.js"></script>
	<script src="/resources/js/photoReplyAndReply.js"></script>
</head>

<body>
	<div class="wrap">
	
		<%@ include file="../include/header.jsp" %>
		
		<div class="content">
			<div class="container">
				
				<div class="card">
					<div class="card-body">
						<div class="row">
							<div class="col-sm-10">
								<h4>${photo.title }</h4>
							</div>
							<div class="col-sm-2 text-right" style="margin-top: 20px;">
							
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-sm">
								<c:if test="${photo.profile eq '' }">
									<img class="rounded-circle" width="35" height="35" src="/resources/images/noProfile.png">
									<div class="dropdown" style="margin-top: -35px; margin-left: 45px;">
										<span data-toggle="dropdown" style="cursor: pointer;">${photo.nickname }</span>
										<div class="dropdown-menu">
											<sec:authorize access="isAnonymous()">
												<a class="dropdown-item" href="#" onclick="loginCheck();">쪽지 보내기</a> 
											</sec:authorize>
											<sec:authorize access="isAuthenticated()">
												<a class="dropdown-item" href="javascript:void(window.open('/message/windowSend?nick=${photo.nickname }', '쪽지 보내기','location=no, directories=no, resizable=no, scrollbars=no, width=500, height=400, top=100, left=100'))">쪽지 보내기</a> 
											</sec:authorize>
										</div>
									</div>					
								</c:if>
								
								<c:if test="${photo.profile ne '' }">
									<img class="rounded-circle" width="35" height="35" src="/resources/profile/${photo.userid }/s_${photo.profile}">
									<div class="dropdown" style="margin-top: -35px; margin-left: 45px;">
										<span data-toggle="dropdown" style="cursor: pointer;">${photo.nickname }</span>
										<div class="dropdown-menu">
											<sec:authorize access="isAnonymous()">
												<a class="dropdown-item" href="#" onclick="loginCheck();">쪽지 보내기</a> 
											</sec:authorize>
											<sec:authorize access="isAuthenticated()">
												<a class="dropdown-item" href="javascript:void(window.open('/message/windowSend?nick=${photo.nickname }', '쪽지 보내기','location=no, directories=no, resizable=no, scrollbars=no, width=500, height=400, top=100, left=100'))">쪽지 보내기</a> 
											</sec:authorize>
										</div>
									</div>																	
								</c:if>
								<div style="margin-top:-10px; margin-left: 35px;">
									<small>&nbsp;&nbsp; ${fn:substring(photo.regdate,0,4) }-${fn:substring(photo.regdate,5,7) }-${fn:substring(photo.regdate,8,10) } ${fn:substring(photo.regdate,11,13) }:${fn:substring(photo.regdate,14,16) }</small>								
								</div>
								
							</div>
							
							<div class="col-sm text-right">
								<h6>조회수: ${photo.views }</h6>	
							</div>
						</div>
						<div class="dropdown-divider"></div>
						<br>
						<div class="row">
							<div class="col-sm">
								${photo.content }
								<br><br>
							</div>
						</div>
						<div class="dropdown-divider"></div>
						<div class="row">
							<div class="col-sm text-right">
								<a class="btn btn-light btn-sm" href="/photo/list">돌아가기</a>
								
								<sec:authorize access="isAuthenticated()">
									<c:if test="${photo.userid eq prinfo.userid }">
										<a class="btn btn-light btn-sm" href="/photo/modify?num=${photo.num }">수정</a>
										
										<button type="submit" class="btn btn-light btn-sm" onclick='deletePhoto("${photo.num }");'>삭제</button>
									</c:if>
								</sec:authorize>
								
							</div>
						</div>
						
						<div class="dropdown-divider"></div>
						
						<div class="row">
							<div class="col-sm">
								<label style="font-weight: bold; margin-left: 10px;"><i class="far fa-comment"></i>&nbsp;<small><span class="badge badge-dark" id="totalCnt"></span></small></label>
							</div>
							<sec:authorize access="isAuthenticated()">
								<div class="col-sm text-right">
									<input type="hidden" value="${prinfo.nickname }" id="replynick">									
									<button type="button" class="btn btn-light btn-sm" id="replyWrite">댓글쓰기</button>
								</div>
							</sec:authorize>
						</div>
						
						
						<div class="row">
							<div class="col-sm-12">
								<sec:authorize access="isAuthenticated()">
									<textarea maxlength="1000" class="form-control" placeholder="댓글은 1000자까지 쓸 수 있습니다." id="reply_content" style="resize: none; height: 100px;"></textarea>								
								</sec:authorize>
								<sec:authorize access="isAnonymous()">
									<textarea maxlength="1000" class="form-control" placeholder="댓글을 쓰려면 로그인을 해주세요." disabled="disabled"  style="resize: none; height: 100px;"></textarea>	
								</sec:authorize>
							</div>
						</div>
						
						<div class="dropdown-divider"></div>
						
						<!-- 댓글표시 -->
						<div class="chat">
						
							<div class="row">
								<table class="table table-borderless" style="margin: 0 auto; width: 98%;">
									<tr>
										<td style="width: 40px; height: 40px;">
											<img alt="" src="/resources/images/noProfile.png" class="rounded-circle" width="30" height="30">
										</td>
										<td style="height: 15px; line-height: 0%; vertical-align: middle;">
											<p>아이디</p>
											<small>2019-05-11 17:07</small>
										</td>
									</tr>
								</table>
							</div>
							
							<div class="row justify-content-sm-center">
								<div class="col-sm-11">
									<p>댓글 내용 들어갈 자리 댓글 내용 들어갈 자리 댓글 내용 들어갈 자리 댓글 내용 들어갈 자리 댓글 내용 들어갈 자리 댓글 내용 들어갈 자리 댓글 내용 들어갈 자리 댓글 내용 들어갈 자리 댓글 내용 들어갈 자리 댓글 내용 들어갈 자리 
								</div>
							</div>
							
							<div class="row justify-content-sm-center">
								<table class="table table-borderless" style="margin: 0 auto; width: 98%;">
									<tr>
										<td><button class="btn btn-secondary btn-sm" id="replyView1">답글</button></td>
										<td style="text-align: right;">
											<button class="btn btn-secondary btn-sm" id="replyUpdate">수정</button>
											<button class="btn btn-secondary btn-sm" id="replyDelete">삭제</button>
										</td>
									</tr>
								</table>								
									

							</div>
							
							<div class="dropdown-divider"></div>
							
							<!-- 댓글 답글 div -->
							<div class="replyAndReplyPage" style="background-color: #F6F6F6; display: none;">
								
								<div class="row justify-content-sm-center">
									<table class="table table-borderless" style="margin: 0 auto; width: 90%;">
										<tr>
											<td style="width: 9px;">
												<img alt="" src="/resources/images/replyImg.png">
											</td>
											<td style="width: 30px; height: 30px;">
												<img alt="" src="/resources/images/noProfile.png" class="rounded-circle" width="30" height="30">
											</td>
											<td style="height: 15px; line-height: 0%; vertical-align: middle;">
												<p>아이디</p>
												<small>2019-05-11 17:77</small>
											</td>
										</tr>
									</table>
								</div>
								<div class="row justify-content-sm-center">
									<div class="col-sm-10">
										<p>댓글 내용 들어갈 자리 댓글 내용 들어갈 자리 댓글 내용 들어갈 자리 댓글 내용 들어갈 자리 댓글 내용 들어갈 자리 댓글 내용 들어갈 자리 댓글 내용 들어갈 자리 댓글 내용 들어갈 자리 댓글 내용 들어갈 자리 댓글 내용 들어갈 자리 
									</div>
								</div>

								<div class="row">
									<div class="col-sm-11 text-right">
										<button class="btn btn-secondary btn-sm" id="replyAndReplyUpdate">수정</button>
										<button class="btn btn-secondary btn-sm" id="replyAndReplyDelete">삭제</button>
									</div>
								</div>
								
								<div class="row justify-content-sm-center">
									<div class="col-sm-11">
										<div class="dropdown-divider"></div>									
									</div>
								</div>
								
								<div class="replyAndReplyFooter">
									<div class="row">
										<div class="col-sm-11">
											<ul class="pagination pagination-sm justify-content-center">
												<li class="page-item"><a class="page-link" href="#">&lt;</a></li>
												<li class="page-item"><a class="page-link" href="#">1</a></li>
												<li class="page-item"><a class="page-link" href="#">2</a></li>
												<li class="page-item"><a class="page-link" href="#">3</a></li>
												<li class="page-item"><a class="page-link" href="#">&gt;</a></li>
											</ul>
										</div>
									</div>
								</div>
								
								<div class="row justify-content-sm-center">
									<sec:authorize access="isAuthenticated()">
										<div class="col-sm-11">
											<table class="table table-borderless" style="margin: 0 auto; width: 100%;">
												<tr>
													<td>
														<textarea maxlength="1000" class="form-control" placeholder="댓글은 1000자까지 쓸 수 있습니다." id="replyAndReply_content"  style="resize: none; height: 40px;"></textarea>	
													</td>
													<td style="width: 120px;">
														<input type="hidden" value="${prinfo.nickname }" id="replyAndReplyNick">									
														<button type="button" class="btn btn-secondary" id="replyAndReplyWrite">댓글쓰기</button>
													</td>
												</tr>
											</table>
										</div>
									</sec:authorize>
									<sec:authorize access="isAnonymous()">
										<div class="col-sm-11">
											<table class="table table-borderless" style="margin: 0 auto; width: 100%;">
												<tr>
													<td>
														<textarea maxlength="1000" class="form-control" placeholder="댓글을 쓰려면 로그인을 해주세요" style="resize: none; height: 40px;" disabled="disabled"></textarea>	
													</td>
													<td style="width: 120px;">
														<button type="button" class="btn btn-secondary" disabled="disabled">댓글쓰기</button>
													</td>
												</tr>
											</table>
										</div>
									</sec:authorize>
								</div>
								
							</div>
							
						</div>						
						<!-- 댓글 표시 end -->
						<br>
						<!-- 댓글 페이지 표시 -->
						<div class="panel-footer">
						</div>
					</div>
				</div>

			</div>
		</div>

		<%@ include file="../include/footer.jsp" %>		
		
	</div>
	
	<!-- The Modal -->
	<div class="modal fade" id="myModal" style="margin-top: 10%;">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">
			    
				<!-- Modal Header -->
				<div class="modal-header">
					<h1 class="modal-title">댓글 수정</h1>
					<button type="button" class="close" data-dismiss="modal">×</button>
				</div>
				
				<!-- Modal body -->
				<div class="modal-body">
					<textarea maxlength="1000" class="form-control" name="reply" placeholder="댓글은 1000자까지 쓸 수 있습니다." style="height: 200px;"></textarea>	
				</div>
				
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-success" id="updateButton">수정하기</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
				</div>
			      
			</div>
		</div>
	</div>
	

	<script type="text/javascript">
	function deletePhoto(num) {
		var isDelete = confirm("게시글을 삭제 하시겠습니까?");
		if(isDelete == true) {
			$.ajax({
				type: 'POST',
				url: '/photo/delete',
				data: { num : num },
				beforeSend : function(xhr) {   
	                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	            },
				success: function(result) {
					if(result == 1){
						alert("게시글이 삭제 되었습니다.");
						location.href="/photo/list";
					} else if (result == -1) {
						alert("이미 삭제된 게시글 입니다.");
						history.back();
					} else {
						alert("게시글 삭제를 실패 했습니다.");
						history.back();
					}
				}
			});	
		}
	}
	
	// 쪽지 보내기 로그인 체크
	function loginCheck() {
		if(confirm("로그인을 해주세요")) {
			location.href = "/login";
		}
	}
	
	$(document).ready(function() {
		
		//===========  변수 ==========================
		var num = "${num}"; // 게시글 번호
		var replyNo = ""; // 댓글 수정 No
		var rarNo = ""; // 답글 수정 No
		
		var replyUL = $(".chat"); // 댓글 처리를 위한 div
		var replyPageFooter = $(".panel-footer"); // 페이지 처리를 위한 div
		
		var pageNum = 1; // 시작 페이지
		//var rPageNum = 1; // 답글 페이지 번호
		
		showList(1); // 댓글 보여주기 (1페이지)
	
		// 모달 정보
		var modal = $(".modal");
		var modalTextArea = modal.find("textarea[name='reply']");
		var modalTitle = modal.find("h1[class='modal-title']");
		var modalButton = modal.find("button[id='modalButton']");
		
		
		//============== 함수 =================================
		// 댓글 쓰기 버튼
		$("#replyWrite").click(function() {
			
			var replyContent = $("#reply_content").val();	// 댓글 내용
			
			// 댓글 정보 객체
			var reply = {
					content: replyContent,
					num:num
			};
			
			// 댓글 최소 글자수
			if(replyContent.length < 3) {
				alert("3자 이상 입력해 주세요");
				return;					
			}
			
			// 댓글 쓰기
			replyService.add(reply, function(result) {
				$("#reply_content").val("");
				if(result == "success") {
					alert("댓글쓰기 완료");
				} else {
					alert("댓글쓰기 실패");
				}
				showList(1);
			});
		});
		
		// 답글 쓰기 버튼
		replyAndReplyWrite = function(no, i) {
			var replyAndReplyContent = $("#replyAndReply_content"+i).val();
			
			// 댓글 정보 객체
			var reply = {
					content: replyAndReplyContent,
					num:num,
					no: no
			};
			
			// 댓글 최소 글자수
			if(replyAndReplyContent.length < 3) {
				alert("3자 이상 입력해 주세요");
				return;					
			}
			
			replyandReplyService.add(reply, function(result) {
				if(result == "success") {
					alert("답글쓰기 완료");
					$("#replyAndReply_content"+i).val("");
					replyShowList(1, no, i);
				} else {
					alert("답글쓰기 실패");
				}
			});
			
		}
		
		
		// 답글 보기 버튼 
		replyViewFunction = function(i, no) {
			if($(".replyAndReplyPage"+i).css("display") == "none"){   
		        jQuery('.replyAndReplyPage'+i).show();  
		        
		        replyShowList(1, no, i); // 답글 목록 보기
		        
		    } else {  
		        jQuery('.replyAndReplyPage'+i).hide();  
		    }  
		}
		
		
		// 수정 하기 모달 열기 버튼
		replyUpdate = function(no) {
			modalTitle.html("수정하기");
			
			replyService.getReply(no, function(getReply) {
				replyNo = getReply.no;
				modalTextArea.val(getReply.content);
			});
			
		}
		
		// 모달에서 최종 수정 버튼
		$("#updateButton").click(function() {
			
			var updateContent = modalTextArea.val();

			if(updateContent.length < 3) {
				alert('3자 이상 작성해 주세요.');
				return;
			}
			
			if(replyNo != "") {
				alert("댓글 수정");
				replyService.update({
					no : replyNo,
					content: updateContent
				}, function(result) {
					if(result == "success") {
						replyNo = "";
						alert("댓글이 수정 되었습니다.");
						modal.modal("hide");
						showList(1);
					}
				});
				return;
			}
			
			if (rarNo != "") {
				alert("답글 수정");
				 replyandReplyService.update({
					r_no : rarNo,
					content: updateContent
				}, function(result) {
					if(result == "success") {
						rarNo = "";
						alert("답글이 수정 되었습니다.");
						modal.modal("hide");
						showList(1);
					}
				});
				return;
			}
			
			
			
		});
		
		// 댓글 삭제하기 버튼
		replyDelete = function(no) {
			if(confirm("댓글을 삭제 하시겠습니까?")) {
				replyService.remove(no, function(result) {
					if(result == "success") {
						alert("댓글이 삭제 되었습니다.");
						showList(1);						
					} else {
						alert("댓글 삭제를 실패 했습니다.");
						showList(1);
					}
				});
			}
		}
		
		// 답글 삭제하기 버튼
		replyAndReplyDelete = function(r_no) {
			if(confirm(r_no + "번 답글을 삭제 하시겠습니까?")) {
				replyandReplyService.remove(r_no, function(result) {
					if(result == "success") {
						alert("답글이 삭제 되었습니다.");
						showList(1);						
					} else {
						alert("답글 삭제를 실패 했습니다.");
						showList(1);
					}
				});
			}
		}
		
		// 답글 수정 모달
		replyAndReplyUpdate = function(r_no) {
			replyandReplyService.getReply(r_no, function(getReply) {
				rarNo = r_no;
				modalTextArea.val(getReply.content);
			});
		}
		
		
		// 댓글 페이지 표시 함수
		function showReplyPage(replyCnt) {
			//                반올림
			var endNum = Math.ceil(pageNum / 10.0) * 10;
			var startNum = endNum - 9;
			
			var prev = startNum != 1; // 시작번호가 1이 아니면 true(11 이상일 때), 1 이면 false(11 이하일 때)
			var next = false;
			
			// 페이징 수(백단위)가 전체 댓글수 보다 크면 
			if(endNum * 10 >= replyCnt) {
				endNum = Math.ceil(replyCnt/10.0);
			}
			
			// 페이징 수(백단위)가 전체 댓글수 보다 작으면
			if(endNum * 10 < replyCnt) {
				next = true; // 다음 활성화
			}
			
			var str = '<ul class="pagination pagination-sm justify-content-center" style="margin-top: 15px;">';
			
			if(prev) {
				str += '<li class="page-item"><a class="page-link" href="' + (startNum - 1) + '"><i class="fas fa-angle-left"></i></a></li>';
			}
			
			for(var i=startNum; i<= endNum; i++) {
				var active = (pageNum == i) ? "active":"";
				
				str += '<li class="page-item ' + active + '"><a class="page-link" href="' + i + '">' + i + '</a></li>';
			}
			
			if(next) {
				str += '<li class="page-item"><a class="page-link" href="' + (endNum + 1) + '"><i class="fas fa-angle-right"></i></a></li>';
			}
			
			str += '</ul>';
			
			replyPageFooter.html(str);
			
		}
		
		// 답글 페이지 표시 함수
		function showReplyAndReplyPage(rPageNum, replyCnt, i) {
			//                반올림
			var endNum = Math.ceil(pageNum / 10.0) * 10;
			var startNum = endNum - 9;
			
			var prev = startNum != 1; // 시작번호가 1이 아니면 true(11 이상일 때), 1 이면 false(11 이하일 때)
			var next = false;
			
			// 페이징 수(백단위)가 전체 댓글수 보다 크면 
			if(endNum * 10 >= replyCnt) {
				endNum = Math.ceil(replyCnt/10.0);
			}
			
			// 페이징 수(백단위)가 전체 댓글수 보다 작으면
			if(endNum * 10 < replyCnt) {
				next = true; // 다음 활성화
			}
			
			var str = '<ul class="pagination pagination-sm justify-content-center" style="margin-top: 15px;">';
			
			if(prev) {
				str += '<li class="page-item"><a class="page-link" onclick="replyPageRe(' + i + ', ' + s + ')"  style="cursor: pointer;"><i class="fas fa-angle-left"></i></a></li>';
			}
			
			for(var s=startNum; s<= endNum; s++) {
				var active = (rPageNum == s) ? "active":"";
				
				str += '<li class="page-item ' + active + '"><a class="page-link" onclick="replyPageRe(' + i + ', ' + s + ')" style="cursor: pointer;">' + s + '</a></li>';
			}
			
			if(next) {
				str += '<li class="page-item"><a class="page-link" onclick="replyPageRe(' + i + ', ' + s + ')" style="cursor: pointer;"><i class="fas fa-angle-right"></i></a></li>';
			}
			
			str += '</ul>';
			
			$(".replyAndReplyFooter"+i).html(str);
			
		}
		
		// 페이지에 따른 답글 목록 갱신
		replyPageRe = function(i, n) {
			
			var parent = $(".profilediv"+i);
			var child = parent.find("img");
			var no = child.attr("data-no"); 
			
			replyShowList(n, no, i);
			
		}
		
		// 페이지에 따른 댓글 목록 갱신
		replyPageFooter.on("click", "li a", function(e) {
			e.preventDefault();
			
			var targetPageNum = $(this).attr("href");
			
			pageNum = targetPageNum;
			
			showList(pageNum);
		});
		
		// 답글 보여주는 함수
		function replyShowList(page, no, i) {
			
			var replyHTML = $(".replyAndReplyPage"+i);
			var ht = "";
			
			replyandReplyService.getList({num: num,	no: no,	page:page||1 }, function(rarCnt, replyList) {
				
				if(replyList == null || replyList.length == 0) {
					console.log("댓글 없음");					
					ht += '	<br>';
					ht += '	<div class="row">';
					ht += '		<div class="col-sm-12 text-center"> <strong>댓글이 없습니다.</strong> </div> </div><div class="dropdown-divider">';
					ht += '			<strong>댓글이 없습니다.</strong>';
					ht += '		</div>';
					ht += '	</div>';
					
				}
				
				for(var j=0, length = replyList.length||0; j<length; j++) {
					
					
						console.log("댓글있음");
						
						ht += '	<div class="row justify-content-sm-center">';
						ht += '		<table class="table table-borderless" style="margin: 0 auto; width: 90%;">';
						ht += '			<tr>';
						ht += '				<td style="width: 9px;">';
						ht += '					<img alt="" src="/resources/images/replyImg.png">';
						ht += '				</td>';
						ht += '				<td style="width: 30px; height: 30px;">';
						
						
						if(replyList[j].profile != "") {
							ht += '				<img class="rounded-circle" width="30" height="30" data-rno=' + replyList[j].r_no + ' src="/resources/profile/' + replyList[j].userid + '/s_' + replyList[j].profile + '">';							
						} else {
							ht += '				<img alt="" src="/resources/images/noProfile.png" data-rno=' + replyList[j].r_no + ' class="rounded-circle" width="30" height="30">';							
						}
						
						ht += '				</td>';
						ht += '				<td style="height: 15px; line-height: 0%; vertical-align: middle;">';
						ht += '					<p>' + replyList[j].nickname + '</p>';
						ht += '					<small>' + replyList[j].regdate.substr(0,16) + '</small>';
						ht += '				</td>';
						ht += '			</tr>';
						ht += '		</table>';
						ht += '	</div>';
						ht += '	<div class="row justify-content-sm-center">';
						ht += '		<div class="col-sm-10">';
						
						if(replyList[j].available == 1) {
						
							ht += '			<p>' + replyList[j].content + '</p>';
						
						} else {
							console.log("댓글 삭제 됨");
							ht += '			<small>삭제된 답글 입니다.</small>';
						}
						
						ht += '		</div>';
						ht += '	</div>';
						
						ht += '	<div class="row">';
						ht += '		<div class="col-sm-11 text-right">';
						ht += '			<sec:authorize access="isAuthenticated()">';
						
						var replyid = replyList[j].userid;
						var userid = '<c:out value="${prinfo.userid}"/>';
						
						if(replyid == userid) {
							if(replyList[j].available == 1) {
								ht += '			<button class="btn btn-secondary btn-sm" data-toggle="modal" data-target="#myModal" onclick="replyAndReplyUpdate(' + replyList[j].r_no + ')">수정</button>';
								ht += '			<button class="btn btn-secondary btn-sm" onclick="replyAndReplyDelete(' + replyList[j].r_no + ')">삭제</button>';									
							}
						}
						
						ht += '			</sec:authorize>';
						ht += '		</div>';
						ht += '	</div>';
						
						ht += '	<div class="row justify-content-sm-center">';
						ht += '		<div class="col-sm-11">';
						ht += '			<div class="dropdown-divider"></div>';
						ht += '		</div>';
						ht += '	</div>';
						
					 
				}
				
				ht += '	<div class="replyAndReplyFooter' + i + '">';
				ht += '	</div>';
				
				ht += '	<div class="row justify-content-sm-center">';
				ht += '		<sec:authorize access="isAuthenticated()">';
				ht += '			<div class="col-sm-11">';
				ht += '				<table class="table table-borderless" style="margin: 0 auto; width: 100%;">';
				ht += '					<tr>';
				ht += '						<td>';
				ht += '							<textarea maxlength="1000" class="form-control" placeholder="댓글은 1000자까지 쓸 수 있습니다." id="replyAndReply_content' + i  + '"  style="resize: none; height: 40px;"></textarea>';
				ht += '						</td>';
				ht += '						<td style="width: 120px;">';
				ht += '							<input type="hidden" value="${prinfo.nickname }" id="replyAndReplyNick' + i + '">';
				ht += '							<button type="button" class="btn btn-secondary" onclick="replyAndReplyWrite(' + no + ', ' + i + ')">답글쓰기</button>';
				ht += '						</td>';
				ht += '					</tr>';
				ht += '				</table>';
				ht += '			</div>';
				ht += '		</sec:authorize>';
				ht += '		<sec:authorize access="isAnonymous()">';
				ht += '			<div class="col-sm-11">';
				ht += '				<table class="table table-borderless" style="margin: 0 auto; width: 100%;">';
				ht += '					<tr>';
				ht += '						<td>';
				ht += '							<textarea maxlength="1000" class="form-control" placeholder="댓글을 쓰려면 로그인을 해주세요" style="resize: none; height: 40px;" disabled="disabled"></textarea>	';
				ht += '						</td>';
				ht += '						<td style="width: 120px;">';
				ht += '							<button type="button" class="btn btn-secondary" disabled="disabled">답글쓰기</button>';
				ht += '						</td>';
				ht += '					</tr>';
				ht += '				</table>';
				ht += '			</div>';
				ht += '		</sec:authorize>';
				ht += '	</div>';
				
				replyHTML.html(ht);
				showReplyAndReplyPage(page||1, rarCnt, i);
				
			});
			
		}
		
		// 댓글 목록 가져오기
		function showList(page) {
			
			replyService.getList({num:num, page:page||1}, function(replyCnt, list) {
				
				var str = "";
				
				if(list == null || list.length == 0) {
					str += '<div class="row"> <div class="col-sm-12 text-center"> <strong>댓글이 없습니다.</strong> </div> </div><div class="dropdown-divider"></div>';
					replyUL.html(str);
					return;
				}
				 
				for(var i=0, len = list.length||0; i<len; i++) {

					if(list[i].available == 1) {
						str += '<div class="row">';
						str += '	<table class="table table-borderless" style="margin: 0 auto; width: 98%;">';
						str += '		<tr>';
						str += '			<td style="width: 40px; height: 40px;">';
						
						if(list[i].profile != "") {
							str += '			<div class="profilediv' + i + '">';
							str += '				<img class="rounded-circle" width="30" height="30" data-no=' + list[i].no + ' src="/resources/profile/' + list[i].userid + '/s_' + list[i].profile + '">';							
							str += '			</div>';
						} else {
							str += '				<img alt="" src="/resources/images/noProfile.png" data-no=' + list[i].no + ' class="rounded-circle" width="30" height="30">';							
						}
						
						str += '			</td>';
						str += '			<td style="height: 15px; line-height: 0%; vertical-align: middle;">';
						str += '				<p>' + list[i].nickname + '</p>';
						str += '				<small>' + list[i].regdate.substr(0,16) + '</small>';
						str += '			</td>';
						str += '		</tr>';
						str += '	</table>';
						str += '</div>';
						
						str += '<div class="row justify-content-sm-center">';
						str += '	<div class="col-sm-11">';
						str += '		<p>' + list[i].content + '</p>';
						str += '	</div>';
						str += '</div>';
						
						str += '<div class="row justify-content-sm-center">';
						str += '	<table class="table table-borderless" style="margin: 0 auto; width: 98%;">';
						str += '		<tr>';
						str += '			<td><button class="btn btn-secondary btn-sm" onclick="replyViewFunction(' + i + ', ' + list[i].no + ')">답글</button></td>';
						str += '			<td style="text-align: right;">';
						str += '				<sec:authorize access="isAuthenticated()">';
						
						var replyid = list[i].userid;
						var userid = '<c:out value="${prinfo.userid}"/>';
						
						if(replyid == userid) {
							str += '				<button class="btn btn-secondary btn-sm" data-toggle="modal" data-target="#myModal" onclick="replyUpdate(' + list[i].no + ')">수정</button>';
							str += '				<button class="btn btn-secondary btn-sm" onclick="replyDelete(' + list[i].no + ')">삭제</button>';						
						}
						
						str += '				</sec:authorize>';
						str += '			</td>';
						str += '		</tr>';
						str += '	</table>';
						str += '</div>';
						str += '<div class="dropdown-divider"></div>';
						
						str += '<div class="replyAndReplyPage' + i + '" style="background-color: #F6F6F6; display: none;">';
						
							
						str += '</div>';
							
					} else {
						str += '<div class="row"> <div class="col-sm-12"> <strong>삭제된 댓글 입니다.</strong> </div> </div><div class="dropdown-divider"></div>';
					}
				}
				
				replyUL.html(str); // 댓글 목록 표시
				showReplyPage(replyCnt); // 페이징 표시

			});
		}
		
	});
	</script>
</body>
</html>