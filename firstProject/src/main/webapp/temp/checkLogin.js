/* index.jsp 에서 참조하는 js파일 */
function checkLogin() {
	if(user_id.value == ""){
		alert("아이디를 입력하세요.");
		user_id.focus();
		return false;
	}
	if(user_pw.value == ""){
		alert("비밀번호를 입력하세요.");
		user_pw.focus();
		return false;
	}
}

function checkLoginIndex() {
		alert("로그인 후 이용하세요.");
		user_id.focus();
		return false;
}

/* list.jsp 에서 글쓰기 클릭 시 로그인 여부를 확인하는 함수 */
function checkWrite() {
	alert("로그인을 하셔야 글을 쓸 수 있습니다.");
	result = confirm("로그인을 하시겠습니까?");
	if(result == true) {
		location.href = '/';
	}
}