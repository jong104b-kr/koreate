<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>썸네일 이미지폼</title>
</head>
<body>
<h3>썸네일 이미지 폼 예제</h3>
	<form action="thumbnail.jsp" method="post" enctype="multipart/form-data">
	이미지 파일 : <input type="file" name="file1"><p>
	<input type="submit" value="전송">
	</form>
</body>
</html>