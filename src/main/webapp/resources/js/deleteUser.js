/**
 *	회원탈퇴 JS 
 */

var deleteUserCheck = {
        isPasswordCheck : false,
        isEmailCheck : false,
        
        allCheck : function() {
        	var result = false;
            if(this.isPasswordCheck == true && this.isEmailCheck == true)
            	result = true;
            return result;
        }
};

function deleteSubmit() {
	if(deleteUserCheck.allCheck()){
        document.deleteForm.submit();
    } else {
        alert('입력한 내용을 다시 확인해 주세요');
        return false;
    }
}