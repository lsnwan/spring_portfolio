/**
 * 	비밀번호 변경 페이지 JS
 */

var updatePasswordCheck = {
        isPasswordCheck : false,
         
        allCheck : function() {
        	var result = false;
            if(this.isPasswordCheck == true) result = true;
            return result;
        }
};

function updateSubmit() {
	if(updatePasswordCheck.allCheck()){
        document.updateForm.submit();
    } else {
        alert('입력한 내용을 다시 확인해 주세요');
        return false;
    }
}

function passwordCheck() {
	var userPassword1 = $('#userpw').val();
    var userPassword2 = $('#userpwConfirm').val();
    
    var regExp = /([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,-])|([!,@,#,$,%,^,&,*,?,_,~,-].*[a-zA-Z0-9])/;
     
    if(userPassword1.trim() == "" || userPassword2.trim() == ""){
        $('#updatePasswordCheckMessage').css('color', 'black');
        $('#updatePasswordCheckMessage').html('비밀번호를 모두 입력해 주세요');
        updatePasswordCheck.isPasswordCheck = false;
    } else {        
        if(userPassword1.trim().length < 8 || userPassword2.trim().length < 8){
            $('#updatePasswordCheckMessage').css('color', 'red');
            $('#updatePasswordCheckMessage').html('비밀번호는 특수문자 포함 8자 이상 입력해 주세요.');        
            updatePasswordCheck.isPasswordCheck = false;
        } else {
            if(userPassword1.trim() != userPassword2.trim()){
                $('#updatePasswordCheckMessage').css('color', 'red');
                $('#updatePasswordCheckMessage').html('비밀번호가 일치하지 않습니다.');
                updatePasswordCheck.isPasswordCheck = false;
            } else {
                if(regExp.test(userPassword1) && regExp.test(userPassword2)){
                    $('#updatePasswordCheckMessage').css('color', 'green');
                    $('#updatePasswordCheckMessage').html('사용가능한 비밀번호 입니다.'); 
                    updatePasswordCheck.isPasswordCheck = true;
                }else {
                    $('#updatePasswordCheckMessage').css('color', 'red');
                    $('#updatePasswordCheckMessage').html('비밀번호는 특수문자가 포함 되어야 합니다.');     
                    updatePasswordCheck.isPasswordCheck = false;
                }               
            }               
        }
    }
}

