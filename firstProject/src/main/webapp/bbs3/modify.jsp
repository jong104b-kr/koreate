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
String title = "";
String issueDate = "";
String attach = "";

if(rs_modify.next()){
	title = rs_modify.getString("title");
	issueDate = rs_modify.getString("issueDate");
	attach = rs_modify.getString("attach");
}

rs_modify.close();
stmt_modify.close();
con_modify.close();
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
		<td align=center>[인증샷 갤러리]</td>
	</tr>
	<tr>
		<td>
			<form action="modifyContent.jsp" method="post" ENCTYPE="multipart/form-data">
			<input type="hidden" name="code" value="<%=code%>">
			<input type="hidden" name="no" value="<%=no%>">
			<input type="hidden" name="field" value="<%=field%>">
			<input type="hidden" name="search" value="<%=search%>">
			<input type="hidden" name="page_now" value="<%=page_now%>">
				<table class="bodyFrame">
					<tr><td colspan=2 style="border-top:1px solid black"></td></tr>
					<tr>
						<td align=center>제목</td>
						<td><input id="title" name="title" value="<%=title %>" style="width:98%"></td>
					</tr>
					<!-- 
					<tr>
						<td align=center>내용</td>
						<td><textarea id="context" name="context" style="width:98%; height:100px;"></textarea></td>
					</tr>
					 -->
					<tr>
						<td align=center height=28>첨부</td>
						<td>
							<input type="file" name="attach">
							<%if(!attach.equals("")){ //첨부파일 존재 %>
								<%=attach %> <img src="img/icon_file.gif">
							<%} %>
						</td>
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