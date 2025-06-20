<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/common.jsp" %>

<%
request.setCharacterEncoding("utf-8"); // 한글깨짐방지

String code = request.getParameter("code");
String no = request.getParameter("no");
String title = request.getParameter("title");
String context = request.getParameter("context");

//검색 관련
String field=request.getParameter("field");
String search=request.getParameter("search");

//페이징 관련
String page_now = request.getParameter("page_now");

//오늘 날짜
java.util.Date today = new java.util.Date();
SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String issueDate = cal.format(today);

// db 삽입하기
String sql_modify = "update "+code+" set title='"+title+"',context='"+context+"' where no="+no;

Connection con_modify = DriverManager.getConnection(url, user, password);
Statement stmt_modify = con_modify.createStatement();
stmt_modify.executeUpdate(sql_modify);

stmt_modify.close();
con_modify.close();

response.sendRedirect("list.jsp?code="+code);
%>