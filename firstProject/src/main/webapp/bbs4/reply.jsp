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

//원글 내용
String sql_reply="select * from "+code+" where no="+no;

Connection con_reply=DriverManager.getConnection(url, user, password);
Statement stmt_reply=con_reply.createStatement();
ResultSet rs_reply=stmt_reply.executeQuery(sql_reply);

String title = "";
String context = "";
int feed = 0;
String thread = "";

if(rs_reply.next()){
	title = rs_reply.getString("title");
	context = rs_reply.getString("context");
	feed = rs_reply.getInt("feed");
	thread = rs_reply.getString("thread");
}

rs_reply.close();
stmt_reply.close();
con_reply.close();
%>
<style>
	body{
		background-image: url("/img/imgBoard.png");
		background-repeat: no-repeat;
		background-attachment: fixed;
		background-size: 100% 100%;
	}
</style>

<table class="bodyFrame" height=50 border=0>
	<tr>
		<td align=center style="color:#777;font-size:14px;font-weight:bold;">[민원과 답변]</td>
	</tr>
</table>
<form name="board" method="post" action="reply_insert.jsp" ENCTYPE="multipart/form-data">
	<input type="hidden" name="code" value="<%=code%>">
	<input type="hidden" name="no" value="<%=no%>">
	<input type="hidden" name="field" value="<%=field%>">
	<input type="hidden" name="search" value="<%=search%>">
	<input type="hidden" name="page_now" value="<%=page_now%>">
	<input type="hidden" name="feed" value="<%=feed%>">
	<input type="hidden" name="thread" value="<%=thread%>">

	<table width="700" border="0" cellpadding="0" cellspacing="0">
		<tr><td colspan=3 height=1 width=100% bgcolor=#d1dee2></td></tr>
		<tr>
			<td height=28>옵션</td>
			<td>
				<input type="radio" name="inform" value="2" checked>일반 
				<input type="radio" name="inform" value="3">비밀 
			</td>
		</tr>
		<tr><td colspan=3 height=1 width=100% bgcolor=#d1dee2></td></tr>
		<tr>
			<td height=28>제목</td>
			<td><input name="title" style="height:20px;width:99%;" value="Re:<%=title%>" escapeXml="true" /></td>
		</tr>
		<tr><td colspan=3 height=1 width=100% bgcolor=#d1dee2></td></tr>
		<tr>
			<td>내용</td>
			<td>
				<textarea name="context" style="height:92px;width:99%;">Re:<%=context%></textarea>
			</td>
		</tr>
		<tr><td colspan=3 height=1 width=100% bgcolor=#d1dee2></td></tr>
	</table>
	<br>
	<table width="700" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center"><button>작성완료</button></td>
		</tr>
	</table>
	<br>
</form>

<%@ include file="/include/footer.jsp" %>