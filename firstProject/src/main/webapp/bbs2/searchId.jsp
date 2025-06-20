<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/common.jsp" %>

<%
request.setCharacterEncoding("utf-8"); // 한글깨짐방지

String name = request.getParameter("name");
String email = request.getParameter("email");

// db에서 일치하는 정보 검색하는 쿼리구문
String sql_findId = "select * from user where name='"+name+"' and email='"+email+"'";

Connection con_findId = DriverManager.getConnection(url, user, password);
Statement stmt_findId = con_findId.createStatement();
ResultSet rs_findId = stmt_findId.executeQuery(sql_findId);

// 찾은 아이디를 입력할 문자열
String id = "";
while(rs_findId.next()){
	id = rs_findId.getString("id");
}

rs_findId.close();
stmt_findId.close();
con_findId.close();
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
	이름 : <input name="name"><br>
	이메일 : <input name="email"><br>
	<button>아이디찾기</button>
</form>

<%if(id != null && !id.equals("")){ %>
찾으시는 아이디는 : <%=id %> 입니다.
<input type="button" value="닫기" onclick="popupClose('<%=id%>')"><br>
<a href="/user/searchPw.jsp">비밀번호찾기</a>
<%} %>
</body>
</html>