<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>
<%@ include file="/include/common.jsp" %>

<%
// 세션에 저장한 id값을 읽어와서 db에 그 id에 해당하는 테이블값을 쿼리구문을 통해 검색 
String id = (String)session.getAttribute("id");
String pw = (String)session.getAttribute("pw"); 
String sql_delete = "select * from user where id='"+id+"'";

Connection con_delete = DriverManager.getConnection(url, user, password);
Statement stmt_delete = con_delete.createStatement();
ResultSet rs_delete = stmt_delete.executeQuery(sql_delete);

// 삭제할할 정보를 입력할 변수들 선언
String user_id = "";
String user_pw = "";
String user_name = "";
String user_email = "";
String user_job = "";
String user_mobile = "";
String user_zipcode = "";
String user_addressNew = "";
String user_addressOld = "";
String user_addressDetail = "";
String user_addressRef = "";
String user_visit = "";

// 쿼리에서 받은 정보로 수정한 값을 대입
while(rs_delete.next()){
	user_id = rs_delete.getString("id");
	user_pw = rs_delete.getString("pw");
	user_name = rs_delete.getString("name");
	user_email = rs_delete.getString("email");
	user_job = rs_delete.getString("job");
	user_mobile = rs_delete.getString("mobile");
	user_zipcode = rs_delete.getString("zipcode");
	user_addressNew = rs_delete.getString("addressNew");
	user_addressOld = rs_delete.getString("addressOld");
	user_addressDetail = rs_delete.getString("addressDetail");
	user_addressRef = rs_delete.getString("addressRef");
	user_visit = rs_delete.getString("visit");
}

rs_delete.close();
stmt_delete.close();
con_delete.close();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴를 합니다.</title>

<!-- 외부 스타일시트 -->
<link rel="stylesheet" type="text/css" href="/css/join.css">

<script>
function deleteInfo(){
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
	if(user_pw.value != user_pw2.value){
		alert("비밀번호를 확인하세요.");
		user_pw2.focus();
		return false;
	}
	if(user_name.value == ""){
		alert("이름을 입력하세요.");
		user_name.focus();
		return false;
	}
	if(user_email.value == ""){
		alert("이메일을 입력하세요.");
		user_email.focus();
		return false;
	}
	if(user_mobile.value == ""){
		alert("휴대전화번호를 입력하세요.");
		user_id.mobile();
		return false;
	}
}
function cancel(){
	var i = confirm("취소하시겠습니까?");
	if(i){
		location.href="list.jsp";	
	}
	return false;
}
</script>
</head>

<body>
<!-- 회원정보 삭제테이블 -->
<table class="joinInfo">
	<tr>
		<td style="text-align:center;">회원탈퇴</td>
	<tr>
		<td>
			<form action="delete.jsp" method="get" onsubmit="return deleteInfo()">
			<table>
				<tr>
					<td id="userInput">아이디</td>
					<td><input type="text" id="user_id" name="user_id" value="<%=user_id %>" size="30" disabled></td>
				</tr>
				<tr>
					<td id="userInput">비밀번호</td>
					<td><input type="password" id="user_pw" name="user_pw" value="<%=user_pw %>" size="30"></td>
				</tr>
				<tr>
					<td id="userInput">비밀번호 확인</td>
					<td><input type="password" id="user_pw2" name="user_pw2" value="<%=user_pw %>" size="30"></td>
				</tr>
				<tr>
					<td id="userInput">이름</td>
					<td><input type="text" id="user_name" name="user_name" value="<%=user_name %>" size="30"></td>
				</tr>
				<tr>
					<td id="userInput">이메일</td>
					<td><input type="email" id="user_email" name="user_email" value="<%=user_email %>" size="30"></td>
				</tr>
				<tr>
					<td id="userInput">휴대전화번호</td>
					<td><input type="text" id="user_mobile" name="user_mobile" value="<%=user_mobile %>" size="30"></td>
				</tr>
				<tr>
					<td id="inputConfirm" colspan=2><button style="width:150px;">회원탈퇴</button></td>
				</tr>
			</table>
			</form>
		</td>
	</tr>
	<tr>
		<td><button onclick="cancel()">취소</button></td>
	</tr>
</table>
</body>
</html>