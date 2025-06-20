<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/admin/include/headerPopup.jsp" %>

<!-- 스타일 시트 수정해야 함, 팝업관련 선생님 게시물 참조 -->

<script>
function popup_close(){
	self.close();
}
</script>

<h1>회원정보</h1>
<fieldset>
	<legend>회원정보</legend>
	<div class="tableRow">
		<table class="manageMember">
			<tr><td colspan=2 height=1 bgcolor=e9e9e9></tr>
			<tr>
				<td style="width:100px;height:26px"><b>아이디</b></td>
				<td>${m.id }</td>
			</tr>
			<tr><td colspan=2 height=1 bgcolor=e9e9e9></tr>
			<tr>
				<td style="width:100px;height:26px"><b>비밀번호</b></td>
				<td>${m.passwd }</td>
			</tr>
			<tr><td colspan=2 height=1 bgcolor=e9e9e9></tr>
			<tr>
				<td style="width:100px;height:26px"><b>이름</b></td>
				<td>${m.name }</td>
			</tr>
			<tr><td colspan=2 height=1 bgcolor=e9e9e9></tr>
			<tr>
				<td style="width:100px;height:26px"><b>이메일</b></td>
				<td>${m.email }</td>
			</tr>
			<tr><td colspan=2 height=1 bgcolor=e9e9e9></tr>
			<tr>
				<td style="width:100px;height:26px"><b>하고싶은 말</b></td>
				<td style="padding:4px 0px;">
					<% pageContext.setAttribute("NL","\n"); %>
					${fn:replace(m.comment, NL, "<br>") }
				</td>
			</tr>
			<tr><td colspan=2 height=1 bgcolor=e9e9e9></tr>
		</table>
		<br>
		<table widtd="96%" border="0" cellpadding="0" cellspacing="0" align=center>
			<tr>
				<td><button onclick="popup_close()">창닫기</button></td>
			</tr>
		</table>
	</div>
</fieldset>
	
<%@ include file="/admin/include/footer.jsp"%>