<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>
<%@ include file="/include/common.jsp" %>

<script>
function checkLogin() {
	if(user_id.value == ""){
		alert("아이디를 입력하세요.");
		user_id.focus();
		return false;
	}
	if(user_pw.value == ""){
		alert("비밀번호를 입력하세요.");
		user_pw.focus();
		return false;
	}
}
</script>

<!-- 타이틀과 로그인 사이 들어갈 내용부분 -->
<style>
	body {
		background-image: url("/img/imgBoard.png");
		background-repeat: no-repeat;
		background-attachment: fixed;
		background-size: 100% 100%;
	}
	#edit {
		color: #000;
	}
	#remove {
		color: #000;	
	}
</style>
<table class="bodyFrame">
	<tr><td style="height:10px;"></td></tr>
	<tr>
		<td style="text-align:center; font-size:15px; color:#fff;"><a href="/bbs1/list.jsp?code=notice">[소개 및 뉴스]</a></td>
		<td style="text-align:center; font-size:15px; color:#fff;"><a href="/bbs2/list.jsp?code=public">[자유게시판]</a></td>
		<td style="text-align:center; font-size:15px; color:#fff;"><a href="/bbs3/list.jsp?code=photos">[인증샷 갤러리]</a></td>
		<td style="text-align:center; font-size:15px; color:#fff;"><a href="/bbs4/list.jsp?code=qna">[민원과 답변]</a></td>
	</tr>
	<tr><td style="height:590px;"></td></tr>
</table>

<!-- 회원정보 입력부분 --> 
<table class="inputFrame">
<tr>
	<td align="center">
		<form name="" action="/user/logout.jsp" method="get" onsubmit="return checkLogin()">
		<table class="inputInfoFrame">
			<tr>
				<!-- 회원탈퇴 페이지는 a태그 href에 /user/delUserInfo.jsp 추후에 추가하기 -->
				<td id="join" colspan=2 style="text-align:center; color:#000;"><a id="edit" href="/user/editUserInfo.jsp">[회원정보수정]</a> | <a id="remove" href="">[회원탈퇴]</a></td>
			</tr>
			<tr>
				<td style="text-align:center; font-size:15px; color:#000;">아이디 : </td>
				<td style="text-align:center; font-size:15px; color:#000;"><%=session_id %></td>
			</tr>
			<tr>
				<td style="text-align:center; font-size:15px; color:#000;">이름 :</td>
				<td style="text-align:center; font-size:15px; color:#000;"><%=session_name %></td>
			</tr>
			<tr>
				<td colspan=2 style="padding-left:73px;"><button>로그아웃</button></td>
			</tr>
		</table>
		</form>
	</td>
</tr>
</table>

<%@ include file="/include/footer.jsp" %>