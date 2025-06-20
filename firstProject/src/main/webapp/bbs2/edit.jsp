<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/common.jsp" %>
<%
request.setCharacterEncoding("utf-8"); // 한글깨짐방지

// 회원정보수정 페이지에서 넘어온 값들을 db에 삽입할 변수 선언
// String id = request.getParameter("user_id"); 아이디는 primary key로 변경 불가능한 상황
String pw = request.getParameter("user_pw");
String name = request.getParameter("user_name");
String email = request.getParameter("user_email");
String job = request.getParameter("user_job");
String mobile = request.getParameter("user_mobile");
String zipcode = request.getParameter("user_zipcode");
String addressNew = request.getParameter("user_addressNew");
String addressOld = request.getParameter("user_addressOld");
String addressDetail = request.getParameter("user_addressDetail");
String visit = request.getParameter("user_visit");

// 회원정보 수정할 db입력 쿼리구문
String sql_update = "update user set pw='"+pw+"',name='"+name+"',email='"+email+"',job='"+job+"',mobile='"+mobile+"',zipcode='"+zipcode+"',addressNew='"+addressNew+"',addressOld='"+addressOld+"',addressDetail='"+addressDetail+"',visit='"+visit+"'";

Connection con_update = DriverManager.getConnection(url, user, password);
Statement stmt_update = con_update.createStatement();
stmt_update.executeUpdate(sql_update);

stmt_update.close();
con_update.close();
%>

<script>
	alert("회원정보를 수정하였습니다.");
	location.href="/";
</script>