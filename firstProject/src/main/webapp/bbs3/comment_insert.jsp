<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>
<%@ include file= "/include/common.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String code = request.getParameter("code");
String no = request.getParameter("no");

String field = request.getParameter("field");
String search = request.getParameter("search");

String page_now = request.getParameter("page_now");
String view_comment = request.getParameter("view_comment");

//오늘 날짜
java.util.Date today = new java.util.Date();
SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd");
String issueDate = cal.format(today);

//입력
String sql_insert = "INSERT INTO comment (tb_no,tb_table,tb_id,tb_name,tb_comment,tb_issueDate)";
	sql_insert += " VALUES ('"+no+"','"+code+"','"+session_id+"','"+session_name+"','"+view_comment+"','"+issueDate+"')";
//out.print(sql_insert);
Connection con=DriverManager.getConnection(url, user, password);
Statement stmt=con.createStatement();
stmt.executeUpdate(sql_insert);

stmt.close();
con.close();
%>

<script type="text/javascript">
	location.href="view.jsp?code=<%=code%>&no=<%=no%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>";
</script>