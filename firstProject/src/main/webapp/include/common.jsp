<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/dbconnection.jsp" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.Enumeration"%>

<%@ page import="java.awt.Image"%>
<%@ page import="java.awt.Graphics2D" %>
<%@ page import="java.awt.image.renderable.ParameterBlock" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="javax.media.jai.JAI" %>
<%@ page import="javax.media.jai.RenderedOp" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.io.*" %>

<!-- 개행 처리, sql 이스케이프 처리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@page import="java.text.SimpleDateFormat"%>

<%
String session_id = (String)session.getAttribute("id");
String session_name = (String)session.getAttribute("name");
String session_level = (String)session.getAttribute("level");
%>

<!DOCTYPE html>
<html>
<body>
	<!-- session_id, session_name, session_level 확인값 넣을 곳 -->
	<a href="/bbs1/list.jsp?code=notice" type="hidden"></a>
	<a href="/bbs2/list.jsp?code=public" type="hidden"></a>
	<a href="/bbs3/list.jsp?code=photos" type="hidden"></a>
	<a href="/bbs4/list.jsp?code=qna" type="hidden"></a>
</body>
</html>
