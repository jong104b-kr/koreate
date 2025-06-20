<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/common.jsp" %>

<%
request.setCharacterEncoding("utf-8"); // 한글깨짐방지

String id = request.getParameter("id");
String name = request.getParameter("name");
String email = request.getParameter("email");

// db에서 일치하는 정보 검색하는 쿼리구문
String sql_findPw = "select * from user where id='"+id+"' and name='"+name+"' and email='"+email+"'";

Connection con_findPw = DriverManager.getConnection(url, user, password);
Statement stmt_findPw = con_findPw.createStatement();
ResultSet rs_findPw = stmt_findPw.executeQuery(sql_findPw);

// 찾은 아이디를 입력할 문자열
String pw = "";
while(rs_findPw.next()){
	pw = rs_findPw.getString("pw");
}

rs_findPw.close();
stmt_findPw.close();
con_findPw.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
</head>
<script>
var str;
function popupClose(str) {
	window.opener.location.href="/index.jsp";
	self.close();
}
</script>

<body>
<form method="get">
	아이디 : <input name="id"><br>
	이름 : <input name="name"><br>
	이메일 : <input name="email"><br>
	<button>비밀번호찾기</button>
</form>

<%if(pw != null && !pw.equals("")){ %>
찾으시는 비밀번호는 : <%=pw %> 입니다.
<input type="button" value="닫기" onclick="popupClose()">
<%} %>
</body>
</html>