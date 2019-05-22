/**
 * 회원가입 유효성 및 중복 체크
 */

// 회원가입 Submit 체크 객체
var submitCheck = {
        isIdCheck : false,
        isPasswordCheck : false,
        isNameCheck : false,
        isEmailCheck : false,
         
        allCheck : function() {
            var result = false;
            if(this.isIdCheck == true && this.isPasswordCheck == true && this.isNameCheck == true &&
                    this.isEmailCheck == true)
                result = true;
            return result;
        }
};

var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");


//회원가입 비밀번호 체크
function passwordCheckFunction() {
    var userPassword1 = $('#password').val();
    var userPassword2 = $('#passwordConfirm').val();
    var regExp = /([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,-])|([!,@,#,$,%,^,&,*,?,_,~,-].*[a-zA-Z0-9])/;
     
    if(userPassword1.trim() == "" || userPassword2.trim() == ""){
        $('#userPasswordCheckMessage').css('color', 'red');
        $('#userPasswordCheckMessage').html('비밀번호를 모두 입력해 주세요.');
        submitCheck.isPasswordCheck = false;
    } else {        
        if(userPassword1.trim().length < 8 || userPassword2.trim().length < 8){
            $('#userPasswordCheckMessage').css('color', 'red');
            $('#userPasswordCheckMessage').html('비밀번호는 특수문자 포함 8자 이상 입력해 주세요.');        
            submitCheck.isPasswordCheck = false;
        } else {
            if(userPassword1.trim() != userPassword2.trim()){
                $('#userPasswordCheckMessage').css('color', 'red');
                $('#userPasswordCheckMessage').html('비밀번호가 일치하지 않습니다.');
                submitCheck.isPasswordCheck = false;
            } else {
                if(regExp.test(userPassword1) && regExp.test(userPassword2)){
                    $('#userPasswordCheckMessage').css('color', 'green');
                    $('#userPasswordCheckMessage').html('사용가능한 비밀번호 입니다.'); 
                    submitCheck.isPasswordCheck = true;
                }else {
                    $('#userPasswordCheckMessage').css('color', 'red');
                    $('#userPasswordCheckMessage').html('비밀번호는 특수문자가 포함 되어야 합니다.');     
                    submitCheck.isPasswordCheck = false;
                }               
            }               
        }
    }
}

// 아이디 체크
function idCheck() {
	var userId = $('#userid').val();
	var regExp = /^[a-z]+[a-z0-9]{4,5}/g;
	
	if(userId.trim() == "") {
		$('#userIdCheckMessage').css('color', 'red');
		$('#userIdCheckMessage').html('');
		submitCheck.isIdCheck = false;
		return;
	}
	
	if(!regExp.test(userId)) {
		$('#userIdCheckMessage').css('color', 'red');
		$('#userIdCheckMessage').html('아이디는 영문자로 시작하는 5자 이상 영문 또는 숫자이어야 합니다.');
		submitCheck.isIdCheck = false;
		return;
	}

	$.ajax({
		type: 'post',
		url: '/users/duplicationIdCheck',
		data: { userId : userId },
		beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);
        },
		success: function(result) {
			if(result == 1){
				$('#userIdCheckMessage').css('color', 'green');
				$('#userIdCheckMessage').html('사용 가능한 아이디 입니다.');
				submitCheck.isIdCheck = true;
			} else if(result == 0){
				$('#userIdCheckMessage').css('color', 'red');
				$('#userIdCheckMessage').html('사용할 수 없는 아이디 입니다.');                       
				submitCheck.isIdCheck = false;
			} 
		}
	});		
}

// 닉네임(이름) 체크
function nicknameCheck() {
	var nickname = $('#nickname').val();
	var regExp = /^[\w\Wㄱ-ㅎㅏ-ㅣ가-힣]{2,20}$/;
	
	if(nickname.trim() == "") {
		$('#nickNameCheck').html('');
		submitCheck.isNameCheck = false;
		return;
	}
	
	if(!regExp.test(nickname)) {
		$('#nickNameCheck').css('color', 'red');
		$('#nickNameCheck').html('이름은 2~20자로 입력해 주세요');
		submitCheck.isNameCheck = false;
		return;
	} 

	$.ajax({
		type: 'post',
		url: '/users/duplicationNicknameCheck',
		data: { nickname : nickname },
		beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);
        },
		success: function(result) {
			if(result == 1){
				$('#nickNameCheck').css('color', 'green');
				$('#nickNameCheck').html('사용 가능한 이름 입니다.');
				submitCheck.isNameCheck = true;
			} else if(result == 0){
				$('#nickNameCheck').css('color', 'red');
				$('#nickNameCheck').html('사용할 수 없는 이름 입니다.');                       
				submitCheck.isNameCheck = false;
			} 
		}
	});		
}

// 이메일 체크
function emailCheck() {
	var email = $('#email').val();
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
		url: '/users/duplicationEmailCheck',
		data: { email : email },
		beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);
        },
		success: function(result) {
			if(result == 1){
				$('#emailCheck').css('color', 'green');
				$('#emailCheck').html('사용 가능한 이메일 입니다.');
				submitCheck.isEmailCheck = true;
			} else if(result == 0){
				$('#emailCheck').css('color', 'red');
				$('#emailCheck').html('사용할 수 없는 이메일 입니다.');                       
				submitCheck.isEmailCheck = false;
			} 
		}
	});		
}


$(document).ready(function() {
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth()+1;
	var day = date.getDate();
	var selectDay;
	
	for(var i=year; i>(year-70); i--) {
		if((year)==i) {
			$("#year").append("<option value='" + i + "' selected>" + i + "</option>");			
		}else {
			$("#year").append("<option value='" + i + "'>" + i + "</option>");						
		}
	}
	
	for(var i=1; i<=12; i++) {
		if((month)==i) {
			$("#month").append("<option value='" + i + "' selected>" + i + "</option>");			
		}else {
			$("#month").append("<option value='" + i + "'>" + i + "</option>");						
		}
	}
	
	for(var i=1; i<=31; i++) {
		if(day==i) {
			$("#day").append("<option value='" + i + "' selected>" + i + "</option>");			
		}else {
			$("#day").append("<option value='" + i + "'>" + i + "</option>");						
		}
	}
	
});

//회원가입 폼 서브밋
function isSubmit() {
    if(submitCheck.allCheck()){
        document.signForm.submit();
    } else {
        alert('입력한 내용을 다시 확인해 주세요');
        return false;
    }
}

// 리셋
function signupReset() {
	
	$('#userid').val('');
	$('#password').val('');
	$('#passwordConfirm').val('');
	$('#nickname').val('');
	$('#email').val('');
	
	$('#userPasswordCheckMessage').css('color', 'red');
    $('#userPasswordCheckMessage').html('');
    submitCheck.isPasswordCheck = false;
    
	$('#userIdCheckMessage').css('color', 'red');
	$('#userIdCheckMessage').html('');
	submitCheck.isIdCheck = false;
	
	$('#nickNameCheck').html('');
	submitCheck.isNameCheck = false;
	
	$('#emailCheck').css('color', 'green');
	$('#emailCheck').html('이메일은 비밀번호 및 아이디 찾기에 사용 됩니다.');
	submitCheck.isEmailCheck = false;
}

// 테스트
function test() {
	alert("아이디체크: " + submitCheck.isIdCheck + "\n" + 
			"비밀번호체크: " + submitCheck.isPasswordCheck + "\n" + 
			"이름체크: " + submitCheck.isNameCheck + "\n" + 
			"이메일체크: " + submitCheck.isEmailCheck);
}