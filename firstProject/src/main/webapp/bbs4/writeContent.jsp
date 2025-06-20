<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/common.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String code = request.getParameter("code");

String title = request.getParameter("title");
String context = request.getParameter("context");
String inform = request.getParameter("inform");

//오늘 날짜
java.util.Date today = new java.util.Date();
SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String issueDate = cal.format(today);

//답변 fid 값 설정
String sql_feed = "select max(feed) as feed_max from "+code+" ";

Connection con_feed=DriverManager.getConnection(url, user, password);
Statement stmt_feed=con_feed.createStatement();
ResultSet rs_feed=stmt_feed.executeQuery(sql_feed);

int feed = 1; //default = 1 처리
if(rs_feed.next()){
	if(rs_feed.getInt("feed_max") > 0){
		feed = rs_feed.getInt("feed_max") + 1;
	}
}
rs_feed.close();
stmt_feed.close();
con_feed.close();


// db 삽입하기
String sql_insert = "insert into "+code+" (id,name,title,context,issueDate,inform,feed,thread) ";
	sql_insert += "values ('"+session_id+"','"+session_name+"','"+title+"','"+context+"','"+issueDate+"','"+inform+"','"+feed+"','A')";

Connection con_insert = DriverManager.getConnection(url, user, password);
Statement stmt_insert = con_insert.createStatement();
stmt_insert.executeUpdate(sql_insert);

stmt_insert.close();
con_insert.close();
%>

<script>
	location.href="/bbs4/list.jsp?code=<%=code%>";
</script>
