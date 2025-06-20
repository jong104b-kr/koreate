<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="/css/cscoffee.css">
<link rel="stylesheet" href="/css/styledform.css">
</head>

<body>
	<h1>시골커피 로그인</h1>
    <h2>아래 양식을 채운 후, “로그인” 버튼을 클릭하세요</h2>
    <form action="login" method="post">
    	<fieldset>
		<legend>로그인</legend>
		<div class="tableRow">
			<label for="id">아이디:</label>
			<input type="text" id="id" name="id" value="" placeholder="아이디" required autofocus> 
		</div>
		<div class="tableRow">
			<label for="passwd">비밀번호:</label>
			<input type="password" id="passwd" name="passwd" value="" placeholder="비밀번호" required> 
		</div>
		<div class="tableRow">
			<label></label>
			<input type="submit" value="로그인">
		</div>
	</fieldset>
    </form>
</body>
</html>