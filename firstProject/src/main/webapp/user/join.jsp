<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>
<%@ include file="/include/common.jsp" %>

<%
request.setCharacterEncoding("utf-8"); // 한글 깨짐 방지

String id = request.getParameter("user_id");
String pw = request.getParameter("user_pw");
String name = request.getParameter("user_name");
String email = request.getParameter("user_email");
String job = request.getParameter("user_job");
String mobile = request.getParameter("user_mobile");
String zipcode = request.getParameter("user_zipcode");
String addressNew = request.getParameter("user_addressNew");
String addressOld = request.getParameter("user_addressOld");
String addressDetail = request.getParameter("user_addressDetail");
String addressRef  = request.getParameter("addressRef");
String visit = request.getParameter("user_visit");

// 회원가입 처리구문 쿼리 입력, level은 (1,2,3) = (1:가입회원,2:미정,3:관리자)

String sql = "insert into user values ('"+id+"','"+pw+"','"+name+"','"+email+"','"+job+"','"+mobile+"','"+zipcode+"','"+addressNew+"','"+addressOld+"','"+addressDetail+"','"+addressRef+"','"+visit+"','1')";

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
stmt.executeUpdate(sql); // 업데이트는 쿼리 삽입, 수정, 삭제구문

stmt.close();
con.close();
%>

<script>
	location.href="/";
</script>