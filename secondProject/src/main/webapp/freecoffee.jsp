<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커피시음 무료쿠폰</title>
<link rel="stylesheet" href="/css/cscoffee.css">
<link rel="stylesheet" href="/css/styledform.css">
</head>
<body>
    <h1>시골커피 무료쿠폰</h1>
    <h2>아래 양식을 채운 후, “신청” 버튼을 클릭하세요</h2>
    <form action="#" method="post">
	<fieldset>
		<legend>주문내역</legend>
		<div class="tableRow">
			<label for="beans">커피를 선택하세요:</label>
			<input type="text" id="coffee" name="coffee" value="하우스 블렌드">
		</div>
		<div class="tableRow">
			<label for="bags">상품 개수:</label>
			<input type="number" id="bags" name="bags" value="1" disabled>
		</div>
		<div class="tableRow">
			<label for="id">신청인 아이디:</label>
			<input type="text" name="id" value="">
		</div>
		<div class="tableRow">
			<label for="date">수령일자:</label>
			<input type="date" name="date" value="">
		</div>
		<div class="tableRow">
			<label></label>
			<input type="submit" value="신청">
		</div>
	</fieldset>
    </form>
</body>
</html>