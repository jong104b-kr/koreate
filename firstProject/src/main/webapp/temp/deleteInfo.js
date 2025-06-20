/* delUserInfo.jsp 에서 참조하는 스크립트 */
function deleteInfo(){
	if(user_id.value == ""){
		alert("아이디를 입력하세요.");
		user_id.focus();
		return false;
	}
	if(user_pw.value == ""){
		alert("비밀번호를 입력하세요.");
		return false;
	}
	if(user_pw.value != user_pw2.value){
		alert("비밀번호를 확인하세요.");
		return false;
	}
	if(user_name.value == ""){
		alert("이름을 입력하세요.");
		return false;
	}
	if(user_email.value == ""){
		alert("이메일을 입력하세요.");
		return false;
	}
	if(user_mobile.value == ""){
		alert("휴대전화번호를 입력하세요.");
		return false;
	}
	if(user_zipcode.value == ""){
		alert("우편번호를 입력하세요.");
		return false;
	}
}
