/**
 *  회원정보변경 JS
 */

var submitCheck = {
        isEmailCheck : true,
         
        allCheck : function() {
        	var result = false;
            if(this.isEmailCheck == true) result = true;
            return result;
        }
};

var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

function selectEmail() {
	var email = $("#email").val();
	var userEmail = $("#userEmail").val();
	
	var regExp = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	
	if(email.trim() == "") {
		$('#emailCheck').css('color', 'green');
		$('#emailCheck').html('이메일은 비밀번호 및 아이디 찾기에 사용 됩니다.');
		submitCheck.isEmailCheck = false;
		return;
	}
	
	if(!regExp.test(email)) {
		$('#emailCheck').css('color', 'red');
		$('#emailCheck').html('이메일 형식을 지켜주세요');
		submitCheck.isEmailCheck = false;
		return;
	}
	
	$.ajax({
		type: 'post',
		url: '/users/updateEmailCheck',
		data: { email : email, userEmail : userEmail },
		beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);
        },
		success: function(result) {
			if(result == 1){
				$('#emailCheck').css('color', 'green');
				$('#emailCheck').html('사용 가능한 이메일 입니다.');
				submitCheck.isEmailCheck = true;
			} else if(result == 0){
				$('#emailCheck').html('');                       
				submitCheck.isEmailCheck = true;
			} else if(result == -1) {
				$('#emailCheck').css('color', 'red');
				$('#emailCheck').html('사용할 수 없는 이메일 입니다.');                       
				submitCheck.isEmailCheck = false;
			}
		}
	});		
}
function updateSubmit() {
    if(submitCheck.allCheck()){
        document.updateForm.submit();
    } else {
        alert('입력한 내용을 다시 확인해 주세요');
        return false;
    }
}

$(document).ready(function() {
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth()+1;
	var day = date.getDate();
	var selectDay;
	
	for(var i=year; i>(year-70); i--) {
		if(userYear==i) {
			$("#year").append("<option value='" + i + "' selected>" + i + "</option>");			
		}else {
			$("#year").append("<option value='" + i + "'>" + i + "</option>");						
		}
	}
	
	for(var i=1; i<=12; i++) {
		if(userMonth==i) {
			$("#month").append("<option value='" + i + "' selected>" + i + "</option>");			
		}else {
			$("#month").append("<option value='" + i + "'>" + i + "</option>");						
		}
	}
	
	for(var i=1; i<=31; i++) {
		if(userDay==i) {
			$("#day").append("<option value='" + i + "' selected>" + i + "</option>");			
		}else {
			$("#day").append("<option value='" + i + "'>" + i + "</option>");						
		}
	}
});

