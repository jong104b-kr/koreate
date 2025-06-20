<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
java.util.Date today = new java.util.Date();
SimpleDateFormat cal = new SimpleDateFormat("yyyyMMddHHmmss");
String loginDate = cal.format(today); // 로그인 날짜를 구하는 과정

String sessionId = (String)session.getAttribute("id");
String str = loginDate + "_" + (String)session.getAttribute("id"); // 날짜_아이디

String sessionCart = (String)session.getAttribute("cateId");
if(sessionId != null && sessionCart == null){ // 장바구니에 세션값이 없을 경우
	session.setAttribute("cateId", str);
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카페 키오스크 및 배달앱</title>
<link type="text/css" rel="stylesheet" href="/css/cscoffee.css">
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.4.1.min.js"></script>
</head>
<body>
<header class="top">
      <img id="headerLogo" src="/images/headerLogo.PNG" alt="시골커피 로고이미지">
      <img id="headerSlogan" src="/images/headerSlogan.png" alt="생활의 활력소인 카페인을 제공합니다">
</header>
<div id="award">
	<a href="/"><img src="/images/award.gif" alt="올해의 로스터"></a>
</div>
