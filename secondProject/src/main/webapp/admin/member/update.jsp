<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/admin/include/headerPopup.jsp" %>

<!-- 스타일 시트 수정해야 함, 팝업관련 선생님 게시물 참조 -->
<script>
function checkInfo(){
	if(passwd.value!=passwdCk.value){
		alert("비밀번호를 확인하세요.");
		passwdCk.focus();
		return false;
	}
}
</script>

<body>
<h1>관리자 회원정보수정</h1>
<form action="update" method="post" onsubmit="return checkInfo()">
<fieldset>
	<legend>관리자 회원정보수정</legend>
	<div class="tableRow">
		<div class="tableRow">
			<label for="id">아이디:</label>
			<input type="text" id="id" name="id" value="${m.id }" placeholder="아이디" readonly> 
		</div>
		<div class="tableRow">
			<label for="passwd">비밀번호:</label>
			<input type="password" id="passwd" name="passwd" value="${m.passwd }" placeholder="비밀번호" required autofocus> 
		</div>
		<div class="tableRow">
			<label for="passwdCk">비밀번호 확인:</label>
			<input type="password" id="passwdCk" name="passwdCk" value="${m.passwd }" placeholder="비밀번호 확인" required> 
		</div>
		<div class="tableRow">
			<label for="name">이름:</label>
			<input type="text" id="name" name="name" value="${m.name }" placeholder="회원명" required> 
		</div>
		<div class="tableRow">
			<label for="phone">전화번호:</label>
			<input type="tel" id="phone" name="phone" value="${m.phone }" placeholder="010-0000-0000 입력요망" required>
		</div>
		<div class="tableRow">
			<label for="email">이메일:</label>
			<input type="email" id="email" name="email" value="${m.email }" placeholder="nickname@domain.com" required>
		</div>
		<div class="tableRow">
			<label for="comment">하고싶은 말:</label>
            <textarea id="comment" name="comment">${m.comment }</textarea>
		</div>
		<div class="tableRow">
			<label></label>
			<input type="submit" value="수정하기">
		</div>
	</div>
</fieldset>
</form>

<%@ include file="/admin/include/footer.jsp"%>