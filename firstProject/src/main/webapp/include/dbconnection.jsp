<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// DB 접속하기	
Class.forName("com.mysql.cj.jdbc.Driver");
String url="jdbc:mysql://localhost:3306/1stprj"; //데이타베이스명 : 1stprj
String user="root"; //관리자 아이디
String password="1111"; //관리자 비밀번호
%>