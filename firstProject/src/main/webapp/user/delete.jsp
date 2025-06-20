<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/common.jsp" %>

<%
String id = request.getParameter("id");
String pw = request.getParameter("pw");
String name = request.getParameter("name");
String email = request.getParameter("email");
String job = request.getParameter("job");
String mobile = request.getParameter("mobile");
String zipcode = request.getParameter("zipcode");
String addressNew = request.getParameter("addressNew");
String addressOld = request.getParameter("addressOld");
String addresssDetail = request.getParameter("addresssDetail");
String visit = request.getParameter("visit");

String sql_deleteOk = "update user set pw='null',name='null',email='null',job='null',mobile='null',zipcode='null',addressNew='null',addressOld='null',addressDetail='null',visit='null' where id='"+id+"'";

Connection con_deleteOk = DriverManager.getConnection(url, user, password);
Statement stmt_deleteOk = con_deleteOk.createStatement();
stmt_deleteOk.executeUpdate(sql_deleteOk);

stmt_deleteOk.close();
con_deleteOk.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
</head>
<script>
	alert("회원탈퇴를 하였습니다.");
	location.href="/";
</script>
<body>
</body>
</html>