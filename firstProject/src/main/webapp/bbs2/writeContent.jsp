<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/common.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String code = request.getParameter("code");

//검색 관련
String title = request.getParameter("title");
String context = request.getParameter("context");

//오늘 날짜
java.util.Date today = new java.util.Date();
SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String issueDate = cal.format(today);

// db 삽입하기
String sql_insert = "insert into "+code+" (id,name,title,context,issueDate,hits) ";
	sql_insert += "values ('"+session_id+"','"+session_name+"','"+title+"','"+context+"','"+issueDate+"',0)";

Connection con_insert = DriverManager.getConnection(url, user, password);
Statement stmt_insert = con_insert.createStatement();
stmt_insert.executeUpdate(sql_insert);

stmt_insert.close();
con_insert.close();
%>

<script>
	location.href="/bbs2/list.jsp?code=<%=code%>";
</script>
