<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>
<%@ include file="/include/common.jsp" %>

<%
// index 페이지에서 입력받은 정보 request로 호출
String id = request.getParameter("user_id");
String pw = request.getParameter("user_pw");

// 입력받은 정보가 db에 있는지 확인 하는 쿼리
String sql_check = "select count(*) as count from user where id='"+id+"'";
//out.print(sql_check+"<br>");
Connection con_check = DriverManager.getConnection(url, user, password);
Statement stmt_check = con_check.createStatement();
ResultSet rs_check = stmt_check.executeQuery(sql_check);
//out.print(rs_check);

// 정보가 있을 경우 countUser변수 이용하여 확인
int countUser = 0;
//String checkPw = "";
while(rs_check.next()){
	countUser = rs_check.getInt("count");
	//checkPw = rs_check.getString("pw");	
}

rs_check.close();
stmt_check.close();
con_check.close();
//out.print("카운터:"+countUser+"<br>");
// 아이디가 db에 없을 경우 
if(countUser == 0) {
	out.print("<script>");
	out.print("alert('입력하신 아이디는 없는 아이디입니다.');");
	out.print("history.back();");
	out.print("</script>");
	out.close();
}

// 비밀번호가 db에 없을 경우
/* else if(pw != checkPw){
	out.print("<script>");
	out.print("alert('비밀번호가 일치하지 않습니다.');");
	out.print("history.back();");
	out.print("</script>");
} */

// 아이디가 db에 있을 경우 세션 생성
else {
	String sql_user = "select * from user where id='"+id+"' and pw='"+pw+"'";

	Connection con_user = DriverManager.getConnection(url, user, password);
	Statement stmt_user = con_user.createStatement();
	ResultSet rs_user = stmt_user.executeQuery(sql_user);

	String checkId = "";
	String checkName = "";
	String checkLevel = "";
	while(rs_user.next()){
		checkId = rs_user.getString("id");
		checkName = rs_user.getString("name");
		checkLevel = rs_user.getString("level");
		
	}
	
	rs_user.close();
	stmt_user.close();
	con_user.close();
	
	if(checkId != null && !checkId.equals("")){
		session.setAttribute("id", checkId);
		session.setAttribute("name", checkName);
		session.setAttribute("level", checkLevel);
		
		out.write("<script>");
		out.write("alert('로그인에 성공하였습니다.');");
		out.write("location.href='/user/list.jsp';");
		out.write("</script>");
		out.close();
	}
	else{
		out.write("<script>");
		out.write("alert('비밀번호가 일치하지 않습니다.');");
		out.write("history.back();");
		out.write("</script>");
		out.close();
	}	
}
%>