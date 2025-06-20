<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>
<%@ include file="/include/common.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String code = request.getParameter("code");
String no = request.getParameter("no");
String field = request.getParameter("field");
String search = request.getParameter("search");
String page_now = request.getParameter("page_now");
String com_no = request.getParameter("com_no"); //댓글 no

//삭제
String sql_delete = "delete from comment where no="+com_no;

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
stmt.executeUpdate(sql_delete);

stmt.close();
con.close();
%>

<script type="text/javascript">
	location.href="view.jsp?code=<%=code%>&no=<%=no%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>";
</script>