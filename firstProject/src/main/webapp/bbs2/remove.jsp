<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/common.jsp" %>

<%
String code = request.getParameter("code");
String no = request.getParameter("no");

/* String sql_remove = "select * from "+code+" where no="+no;

Connection con_remove = DriverManager.getConnection(url, user, password);
Statement stmt_remove = con_remove.createStatement();
ResultSet rs_remove = stmt_remove.executeQuery(sql_remove);

// 작성자 아이디
String id = "";

if(rs_remove.next()){
	id = rs_remove.getString("id");
}

rs_remove.close();
stmt_remove.close();
con_remove.close(); */

// 작성자일때만 삭제가능한 조건문
/* if(session_id != null && session_id.equals(id)){
 */	// 삭제 쿼리
	String sql_removeOk = "delete from "+code+" where no="+no;
	
	Connection con_removeOk = DriverManager.getConnection(url, user, password);
	Statement stmt_removeOk = con_removeOk.createStatement();
	stmt_removeOk.executeUpdate(sql_removeOk);
	
	stmt_removeOk.close();
	con_removeOk.close();
	
	response.sendRedirect("list.jsp?code="+code);
/* }else { */
%>
<!-- <script>
	alert("잘못된 경로이거나 권한이 없습니다.");
	location.href="/";
</script> -->
<%
/* } */
%>