<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/common.jsp" %>
<%@ include file="/include/header.jsp" %>

<%
String code = request.getParameter("code");

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
			<form action="writeContent.jsp" method="post" onsubmit="return checkSubmit()">
			<input type="hidden" name="code" value="<%=code%>">
				<table class="bodyFrame">
					<tr><td colspan=2 style="border-top:1px solid black"></td></tr>
					<tr>
						<td align=center>제목</td>
						<td><input id="title" name="title" style="width:98%"></td>
					</tr>
					<tr>
						<td align=center>내용</td>
						<td><textarea id="context" name="context" style="width:98%; height:100px;"></textarea></td>
					</tr>
					<tr>
						<td></td>
						<td><button>글쓰기</button></td>
					</tr>
					<tr><td colspan=2 style="border-top:1px solid black"></td></tr>
				</table>
			</form>
		</td>
	</tr>
</table>

<%@ include file="/include/footer.jsp" %>