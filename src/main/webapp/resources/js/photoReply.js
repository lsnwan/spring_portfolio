/**
 * PHOTO 게시판 reply
 */

console.log("Reply Modul........");

var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");


var replyService = (function() {
	
	// 댓글 쓰기 Ajax
	function add(reply, callback, error) {
		console.log("댓글 쓰기 JS");
		
		$.ajax({
			type: 'post',
			url: '/photoReply/new',
			data: JSON.stringify(reply),
			beforeSend: function(xhr) {
	            xhr.setRequestHeader(header, token);
	        },
	        contentType : "application/json; charset=utf-8",
			success: function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error(er);
				}
			}
		});
	
	}
	
	// 댓글 리스트 가져오기
	function getList(param, callback, error) {
		var num = param.num;
		var page = param.page || 1;
		
		$.getJSON("/photoReply/pages/" + num + "/" + page + ".json", function(data) {
			if(callback) {
				callback(data.replyCnt, data.list);
			}
		}).fail(function(xhr, status, err) {
			if(error) {
				error();
			}
		});
	}
	
	// 특정 댓글 정보 가져오기
	function getReply(rno, callback, error) {
		
		$.getJSON("/photoReply/read/"+rno+".json", function(data) {
			if(callback) {
				callback(data);
			}
		}).fail(function(xhr, status, err) {
			if(error) {
				error();
			}
		});
	}
	
	// 삭제
	function remove(rno, callback, error) {
		$.ajax({
			type : 'delete',
			url : '/photoReply/' + rno,
			beforeSend: function(xhr) {
	            xhr.setRequestHeader(header, token);
	        },
	        success : function(deleteResult, status, xhr) {
	        	if(callback) {
	        		callback(deleteResult);
	        	}
	        },
	        error : function(xhr, status, er) {
	        	if(error) {
	        		error(er);
	        	}
	        }
		});
	}
	
	// 수정
	function update(reply, callback, error) {
		console.log("RNO: " + reply.no);
		
		$.ajax({
			type : 'put',
			url : '/photoReply/' + reply.no,
			data : JSON.stringify(reply),
			beforeSend: function(xhr) {
	            xhr.setRequestHeader(header, token);
	        },
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if(callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}
	
	return {
		add : add,
		getList : getList,
		remove : remove,
		update : update,
		getReply : getReply,
	};
})();