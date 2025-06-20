<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="/css/cscoffee.css">
<link rel="stylesheet" href="/css/styledform.css">
</head>
<body>
	<h1>시골커피 회원가입</h1>
    <h2>아래 양식을 채운 후, “가입하기” 버튼을 클릭하세요</h2>
    <form action="#" method="post">
    	<fieldset>
		<legend>회원가입</legend>
		<div class="tableRow">
			<label for="id">아이디:</label>
			<input type="text" id="id" name="id" value="" placeholder="아이디" required> 
		</div>
		<div class="tableRow">
			<label for="passwd">비밀번호:</label>
			<input type="password" id="passwd" name="passwd" value="" placeholder="비밀번호" required> 
		</div>
		<div class="tableRow">
			<label for="passwdCk">비밀번호 확인:</label>
			<input type="password" id="passwdCk" name="passwdCk" value="" placeholder="비밀번호 확인" required> 
		</div>
		<div class="tableRow">
			<label for="name">이름:</label>
			<input type="text" id="name" name="name" value="" placeholder="회원명" required> 
		</div>
		<div class="tableRow">
			<label for="phone">전화번호:</label>
			<input type="tel" id="phone" name="phone" value="" placeholder="010-0000-0000 입력요망" required>
		</div>
		<div class="tableRow">
			<label for="email">이메일:</label>
			<input type="email" id="email" name="email" value="" placeholder="nickname@domain.com" required>
		</div>
		<div class="tableRow">
			<label for="zip">주소:</label>
			<input type="text" id="sample4_postcode" name="zipcode" placeholder="우편번호">
			<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" id="sample4_roadAddress" name="addressNew" placeholder="도로명주소">
			<input type="text" id="sample4_jibunAddress" name="addressOld" placeholder="지번주소"><br>
			<span id="guide" style="color:#999;display:none"></span>
			<input type="text" id="sample4_detailAddress" name="addressDetail" placeholder="상세주소">
			<input type="text" id="sample4_extraAddress" name="addressRef" placeholder="참고항목">
		</div>
		<div class="tableRow">
			<label for="comments">하고싶은 말:</label>
            <textarea id="comments" name="comments"></textarea>
		</div>
		<div class="tableRow">
			<label></label>
			<input type="submit" value="가입하기">
		</div>
	</fieldset>
    </form>
</body>
</html>