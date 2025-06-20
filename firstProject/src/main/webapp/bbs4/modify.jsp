<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/common.jsp" %>
<%@ include file="/include/header.jsp" %>

<%
String code = request.getParameter("code");
String no = request.getParameter("no");

//페이징 관련
String page_now = request.getParameter("page_now");

//검색 관련
String field = request.getParameter("field");
String search = request.getParameter("search");

// 수정할 글을 찾는 쿼리
String sql_modify = "select * from "+code+" where no="+no;

Connection con_modify = DriverManager.getConnection(url, user, password);
Statement stmt_modify = con_modify.createStatement();
ResultSet rs_modify = stmt_modify.executeQuery(sql_modify);

// 수정할 변수 선언
String id = "";
String title = "";
String inform = "";
String context = "";
String name = "";
String issueDate = "";

if(rs_modify.next()){
	id = rs_modify.getString("id");
	title = rs_modify.getString("title");
	inform = rs_modify.getString("inform");
	context = rs_modify.getString("context");
	name = rs_modify.getString("name");
	issueDate = rs_modify.getString("issueDate");
}

rs_modify.close();
stmt_modify.close();
con_modify.close();

if(inform.equals("3")){ //비밀글
	if((session_level != null && session_level.equals("3")) || (session_id != null && session_id.equals(id))){
		// 관리자 또는 작성자
	}else{
%>
	<script>
		alert("수정 권한이 없습니다.");
		history.back();
	</script>
<%
	}
}
%>

<%
if(session_id == null){
%>
<script>
	alert("로그인을 하지 않았습니다.\n로그인 페이지로 이동합니다.");
	location.href="/user/login.jsp";
</script>
<%
}
%>

<!-- 본문 적용할 스타일시트 오버로딩 -->
<style>
	body{
		background-image: url("/img/imgBoard.png");
		background-repeat: no-repeat;
		background-attachment: fixed;
		background-size: 100% 100%;
	}
</style>

<table class="bodyFrame">
	<tr>
		<td align=center>[자유게시판]</td>
	</tr>
	<tr>
		<td>
			<form action="modifyContent.jsp" method="post">
			<input type="hidden" name="code" value="<%=code%>">
			<input type="hidden" name="no" value="<%=no%>">
			<input type="hidden" name="field" value="<%=field%>">
			<input type="hidden" name="search" value="<%=search%>">
			<input type="hidden" name="page_now" value="<%=page_now%>">
				<table class="bodyFrame">
					<tr><td colspan=2 style="border-top:1px solid black"></td></tr>
					<tr>
						<td height=26>옵션</td>
						<td>
							<input type="radio" name="inform" value="1" <%if(inform.equals("1")){%>checked<%}%>>공지 
							<input type="radio" name="inform" value="2" <%if(inform.equals("2")){%>checked<%}%>>일반 
							<input type="radio" name="inform" value="3" <%if(inform.equals("3")){%>checked<%}%>>비밀 
						</td>
					</tr>
					<tr>
						<td align=center>제목</td>
						<td><input id="title" name="title" value="<%=title %>" style="width:98%"></td>
					</tr>
					<tr>
						<td align=center>내용</td>
						<td><textarea id="context" name="context" style="width:98%; height:100px;"><%=context %></textarea></td>
					</tr>
					<tr>
						<td></td>
						<td><button>수정하기</button></td>
					</tr>
					<tr><td colspan=2 style="border-top:1px solid black"></td></tr>
				</table>
			</form>
		</td>
	</tr>
</table>

<%@ include file="/include/footer.jsp" %>