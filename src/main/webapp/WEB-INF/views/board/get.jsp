<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<meta name="_csrf" content="${_csrf.token}"/>
	<meta name="_csrf_header" content="${_csrf.headerName}"/>
<head>
	<%@include file="../include/include.jsp" %>	
	<!-- link -->
	<link rel="stylesheet" href="/resources/css/custom.css">
	<link href="/resources/summernote/summernote-bs4.css" rel="stylesheet">
    <script src="/resources/summernote/summernote-bs4.js"></script>
    <script src="/resources/js/reply.js"></script>
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
								<h4>${board.title }</h4>
							</div>
							<div class="col-sm-2 text-right" style="margin-top: 20px;">
													
							</div>
						</div>
						<br>
						<div class="row">
							<div class="col-sm">
								<c:if test="${board.profile eq '' }">
									<img class="rounded-circle" width="35" height="35" src="/resources/images/noProfile.png">&nbsp;&nbsp;
									
									<div class="dropdown" style="margin-top: -30px; margin-left: 40px;">
										<a data-toggle="dropdown" style="cursor: pointer;"><c:out value="${board.nickname }"/></a>
										<small>&nbsp;${fn:substring(board.regdate,0,4) }-${fn:substring(board.regdate,5,7) }-${fn:substring(board.regdate,8,10) } ${fn:substring(board.regdate,11,13) }:${fn:substring(board.regdate,14,16) }</small>
										<div class="dropdown-menu">
											<sec:authorize access="isAnonymous()">
												<a class="dropdown-item" href="#" onclick="loginCheck();">쪽지 보내기</a> 
											</sec:authorize>
											<sec:authorize access="isAuthenticated()">
												<a class="dropdown-item" href="javascript:void(window.open('/message/windowSend?nick=${board.nickname }', '쪽지 보내기','location=no, directories=no, resizable=no, scrollbars=no, width=500, height=400, top=100, left=100'))">쪽지 보내기</a> 
												
											</sec:authorize>
										</div>
									</div> 						
									
								</c:if>
								
								<c:if test="${board.profile ne '' }">
									<img class="rounded-circle" width="35" height="35" src="/resources/profile/${board.userid }/s_${board.profile}">&nbsp;&nbsp;
									
									<div class="dropdown" style="margin-top: -30px; margin-left: 40px;">
										<a data-toggle="dropdown" style="cursor: pointer;"><c:out value="${board.nickname }"/></a>
										<small>&nbsp;${fn:substring(board.regdate,0,4) }-${fn:substring(board.regdate,5,7) }-${fn:substring(board.regdate,8,10) } ${fn:substring(board.regdate,11,13) }:${fn:substring(board.regdate,14,16) }</small>
										<div class="dropdown-menu">
											<sec:authorize access="isAnonymous()">
												<a class="dropdown-item" href="#" onclick="loginCheck();">쪽지 보내기</a> 
											</sec:authorize>
											<sec:authorize access="isAuthenticated()">
												<a class="dropdown-item" href="javascript:void(window.open('/message/windowSend?nick=${board.nickname }', '쪽지 보내기','location=no, directories=no, resizable=no, scrollbars=no, width=500, height=400, top=100, left=100'))">쪽지 보내기</a> 
												
											</sec:authorize>
										</div>
									</div> 
																							
								</c:if>
								
							</div>
							<div class="col-sm text-right">
								<h6>조회수: ${board.views }</h6>	
							</div>
						</div>
						<div class="dropdown-divider"></div>
						<br>
						<div class="row">
							<div class="col-sm text-right">
								
								<div class="dropdown">
									<button type="button" class="btn btn-light btn-sm dropdown-toggle" data-toggle="dropdown">
										첨부파일
									</button>
									<div class="dropdown-menu">
										 <c:if test="${upload.size() eq '0' }">
											<div class="row">
												<div class="col text-center">
													<p> 첨부파일이 없습니다. </p>	
												</div>
											</div>
										</c:if>
										<c:if test="${upload.size() ne '0' }">
											<sec:authorize access="isAnonymous()">
												<div class="row">
													<div class="col text-center">
														<p>로그인을 해주세요</p>
													</div>
												</div>
											</sec:authorize>
											<sec:authorize access="isAuthenticated()">
												<c:forEach items="${upload }" var="upload">
													<a class="dropdown-item" href="/board/download?num=${board.num }&fileName=${upload.filename}"><small>${upload.subFileName }&nbsp;&nbsp;&nbsp;&nbsp; ${upload.filesize }KB</small></a>
												</c:forEach>
											</sec:authorize>
										</c:if>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm">
								${board.content }
								<br><br>
							</div>
						</div>
						<div class="dropdown-divider"></div>
						<div class="row">
							<div class="col-sm text-right">
								<a class="btn btn-light btn-sm" href="/board/list?type=${type }&keyword=${keyword}&pagenum=${pagenum}&contentnum=${contentnum}">돌아가기</a>
								
								<sec:authorize access="isAuthenticated()">
									<c:if test="${board.userid eq prinfo.userid }">
										<a class="btn btn-light btn-sm" href="/board/modify?num=${board.num }&type=${type}&keyword=${keyword}&pagenum=${pagenum}&contentnum=${contentnum}">수정</a>
										
										<button type="submit" class="btn btn-light btn-sm" onclick='deleteBoard("${board.num }");'>삭제</button>
									</c:if>
								</sec:authorize>
								
								<a class="btn btn-light btn-sm" href="/board/reply?num=${board.num }&type=${type }&keyword=${keyword }&pagenum=${pagenum }&contentnum=${contentnum}">답변</a>
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
						</div>						
						<!-- 댓글 표시 end -->

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
					<button type="button" class="btn btn-success" id="modalButton" onclick="modalPro();">수정하기</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
				</div>
			      
			</div>
		</div>
	</div>
	
		
	<script type="text/javascript">
		$(document).ready(function() {
			
			var bno = '<c:out value="${board.num}"/>'; // 게시글 번호
			var replyUL = $(".chat");	// 댓글표시부분 div
			var rno = ''; // 댓글 번호 변수
			var updateIsReply = ''; // 모달창 수정,답글 중 어떤 작업할 지 체크할 변수
			
			// 모달 정보
			var modal = $(".modal");
			var modalTextArea = modal.find("textarea[name='reply']");
			var modalTitle = modal.find("h1[class='modal-title']");
			var modalButton = modal.find("button[id='modalButton']");
			
			// 댓글 총 개수
			var totalCnt = $("#totalCnt");
			
			// 페이징 변수
			var pageNum = 1;
			var replyPageFooter = $(".panel-footer");
			
			// 목록 생성
			showList(1);
			
			// 댓글 쓰기 함수
			$("#replyWrite").click(function() {
				
				var replyContent = $("#reply_content").val();	// 댓글 내용
				
				// 댓글 정보 객체
				var reply = {
						reply: replyContent,
						num:bno
				};
				
				// 댓글 최소 글자수
				if(replyContent.length < 3) {
					alert("3자 이상 입력해 주세요");
					return;					
				}
				
				replyService.add(reply,	function(result) {
						$("#reply_content").val("");
						pageNum = 1;
						showList(1);
					}
				);
			});
			
			// 페이징 처리 함수
			function showReplyPage(replyCnt) {
				
				//               반올림
				var endNum = Math.ceil(pageNum / 10.0) * 10;
				var startNum = endNum - 9;
				
				var prev = startNum != 1; // 시작번호가 1이 아니면 true(11 이상일 때), 1 이면 false(11 이하일 때)
				var next = false;
				
				// 페이징 수(백단위)가 전체 댓글수 보다 크면 
				if(endNum * 10 >= replyCnt) {
					endNum = Math.ceil(replyCnt / 10.0);
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
			
			// 페이지를 눌렀을 때 해당 번호의 댓글을 다시 보여줌
			replyPageFooter.on("click", "li a", function(e) {
				e.preventDefault();
				
				var targetPageNum = $(this).attr("href");
				
				pageNum = targetPageNum;
				
				showList(pageNum);
			});
			
			// 쪽지 보내기 로그인 체크
			loginCheck = function() {
				if(confirm("로그인을 해주세요")) {
					location.href = "/login";
				}
			}
			
			windowMessageSend = function(nick) {
				window.open("/message/windowSend?nick=" + nick,"쪽지 보내기","top=100, left=100, width=500, height=400, directories='no', location=no, menubar=no, resizable=no, status=yes, toolbar=no");
			}
			
			// 목록 가져오기 함수
			function showList(page) {
				
				// 댓글 리스트 목록 가져오기
				replyService.getList({num:bno, page:page||1}, function(replyCnt, list) {
					
					totalCnt.text(replyCnt);
					
					// 맨뒤로 보내기
					if(page == -1) {
						pageNum = Math.ceil(replyCnt/10.0);
						showList(pageNum);
						return;
					}
					
					var str = "";
					
					if(list == null || list.length == 0) {
						str += '<div class="row"> <div class="col-sm-12 text-center"> <strong>댓글이 없습니다.</strong> </div> </div><div class="dropdown-divider"></div>';
						replyUL.html(str);
						return;
					}
					
					for(var i=0, len = list.length||0; i<len; i++) {
						
						console.log(list[i]);
						
						if(list[i].available == 1) {
							
							str += '<div class="row">';
							str += '<div class="col-sm-7">';
							
							if(list[i].depth > 0) {
								for(var j=0; j < list[i].depth; j++) {
									str += '&nbsp;&nbsp;&nbsp;&nbsp;';
									if(j == (list[i].depth-1)) {
										str += '<img src="/resources/images/replyImg.png">&nbsp;';
									}
								}
							}
							
							if(list[i].profile != "") {
								str += '<img class="rounded-circle" data-toggle="dropdown" width="30" height="30" data-rno=' + list[i].rno + ' src="/resources/profile/' + list[i].userid + '/s_' + list[i].profile + '" style="cursor: pointer;">&nbsp;' + list[i].replyer;
								
								str += '<div class="dropdown">';
							    str += '<small>' + list[i].replyDate.substr(0,10) + '</small>';
							    str += '<div class="dropdown-menu">';
							    str += '<sec:authorize access="isAnonymous()">';
							    str += '<a class="dropdown-item" href="#" onclick="loginCheck();">쪽지 보내기</a> ';
							    str += '</sec:authorize>';
							    str += '<sec:authorize access="isAuthenticated()">';
							    str += '<a class="dropdown-item" href="#" onclick="windowMessageSend(\'' + list[i].replyer + '\');">쪽지 보내기</a> ';
							    str += '</sec:authorize>';
							    str += '</div>';
							    str += '</div>';
								
							} else {
								str += '<img class="rounded-circle" data-toggle="dropdown" width="30" height="30"  data-rno=' + list[i].rno + ' src="/resources/images/noProfile.png" style="cursor: pointer;"> &nbsp;'+ list[i].replyer;
								str += '<div class="dropdown">';
							    str += '<small>' + list[i].replyDate.substr(0,10) + '</small>';
							    str += '<div class="dropdown-menu">';
							    str += '<sec:authorize access="isAnonymous()">';
							    str += '<a class="dropdown-item" href="#" onclick="loginCheck();">쪽지 보내기</a> ';
							    str += '</sec:authorize>';
							    str += '<sec:authorize access="isAuthenticated()">';
							    str += '<a class="dropdown-item" href="#" onclick="windowMessageSend(\'' + list[i].replyer + '\');">쪽지 보내기</a> ';
							    str += '</sec:authorize>';
							    str += '</div>';
							    str += '</div>';
							}
							
							//str += '<small>' + list[i].replyDate.substr(0,10) + '</small>';
							str += '</div>';
							str += '<div class="col-sm-5 text-right">';
							str += '<sec:authorize access="isAuthenticated()">';
							
							var replyid = list[i].userid;
							var userid = '<c:out value="${prinfo.userid}"/>';
							
							if(replyid == userid) {
								str += '<button type="button" class="btn btn-outline-secondary btn-sm" data-toggle="modal" data-target="#myModal" onclick="updateReply(' + list[i].rno + ')">수정</button> ';
								str += '<button type="button" class="btn btn-outline-secondary btn-sm" onclick="removeReply(' + list[i].rno + ')">삭제</button> ';							
							}
							
							str += '<button type="button" class="btn btn-outline-secondary btn-sm" data-toggle="modal" data-target="#myModal" onclick="replyReply(' + list[i].rno + ')">답변</button>';
							str += '</sec:authorize>';
							str += '</div>';
							str += '</div>';
							str += '<div class="row">';
							
							if(list[i].depth > 0) {
								var left = 50;
								for(var c=0; c < list[i].depth; c++) {
									left+=(30-(c*10));
								}								
								str += '<div class="col-sm-12" style="padding-left: ' + left + 'px;">';																
							}else {
								str += '<div class="col-sm-12" style="padding-left: 50px;">';								
							}						
							
							str += '<p>' + list[i].reply + '</p>';
							str += '</div>';
							str += '</div>';
							str += '<div class="dropdown-divider"></div>';
						} else {
							str += '<div class="row"> <div class="col-sm-12"> <strong>삭제된 댓글 입니다.</strong> </div> </div><div class="dropdown-divider"></div>';
						}
					}
					
					replyUL.html(str);
					
					showReplyPage(replyCnt);
				});
			}
			
			// 댓글 삭제
			removeReply = function(rno) {
				if(confirm("해당 댓글을 삭제 하시겠습니까?")) {
					replyService.remove(rno, function(result) {
						alert("댓글이 삭제 되었습니다.");
						showList(1);
					});					
				}
			}
			
			// 댓글 수정, 답변글 달기 (모달창에서 최종 처리)
			modalPro = function() {
				if(updateIsReply == 'update') {
					var updateContent = modalTextArea.val();
					
					if(updateContent.length < 3) {
						alert('3자 이상 작성해 주세요.');
						return;
					}
					
					console.log("rno: " + rno + " / updateContent: \n" + updateContent);
					replyService.update({
						rno : rno,
						reply : updateContent
					}, function(result) {
						if(result == "success") {
							alert("댓글이 수정 되었습니다.");
							modal.modal("hide");
							showList(1);
						}
					});
				} else {
					// 답변달기 최종 작업
					replyService.getReply(rno, function(getReply) {
						
						var replyContent = $("#reply_content").val();	// 댓글 내용
						
						var newReply = {
							num : getReply.num,
							pos : getReply.pos,
							ref : getReply.ref,
							depth : getReply.depth,
							reply : modalTextArea.val()
						};
						
						replyService.reply(newReply, function(result) {
							if(result == 'success') {
								alert('댓글 달기에 성공 했습니다.');
								modal.modal("hide");
								showList(1);
							} else {
								alert('댓글 달기에 실패 했습니다.');
							}
						}
					);
						
					});
				}
			}
			
			
			// 댓글 원본내용 가져오기(게시글에서 수정하기버튼)
			updateReply = function(getRno) {
				modalTitle.html("수정하기");
				modalButton.html("수정하기");
				updateIsReply = 'update';
				
				replyService.getReply(getRno, function(getReply) {
					rno = getReply.rno;
					modalTextArea.val(getReply.reply);
				});
			}
			
			// 댓글에 답변달기 (게시글에서 답변달기 버튼)
			replyReply = function(getRno) {
				rno = getRno;
				modalTitle.html("답변달기");
				modalButton.html("답변달기");
				modalTextArea.val("");
				updateIsReply = 'reply';
				
			}
			
			
		}); // end document.ready
		
	
		// 게시글 삭제 함수
		function deleteBoard(num) {
			var isDelete = confirm("게시글을 삭제 하시겠습니까?");
			if(isDelete == true) {
				$.ajax({
					type: 'POST',
					url: '/board/delete',
					data: { num : num },
					beforeSend : function(xhr) {   
		                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		            },
					success: function(result) {
						if(result == 1){
							alert("게시글이 삭제 되었습니다.");
							location.href="/board/list?type=&keyword=&pagenum=1&contentnum=10";
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
		
		
	</script>
</body>
</html>