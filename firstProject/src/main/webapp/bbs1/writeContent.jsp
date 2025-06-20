<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/common.jsp" %>

<%
request.setCharacterEncoding("utf-8");

//파일 저장 폴더 생성 경로(프로젝트 안에 upload 폴더 생성 및 지정 추천) 
//String uploadPath=request.getRealPath("/upload");
String uploadPath="C:\\jsp\\my1stProject\\src\\main\\webapp\\upload"; //window 폴더 내 upload 경로
int size=10*1024*1024; //파일 최대 사이즈 (10메가)

MultipartRequest multi=new MultipartRequest(request,uploadPath,size,"utf-8",new DefaultFileRenamePolicy());

String code = multi.getParameter("code");
String title = multi.getParameter("title");
String context = multi.getParameter("context");

Enumeration files=multi.getFileNames();

//첨부파일1
String attach=(String)files.nextElement(); //첨부파일1 존재한다면
String attach_name=multi.getOriginalFileName(attach); //사용자가 올린 파일명
String attach_rename=multi.getFilesystemName(attach); //중복된 파일명을 새로운 파일명으로 변경

if(attach_name == null){ //첨부파일1 없다면
	attach_name = ""; //null 값이 아닌 비어있는 값으로 대체
	attach_rename = ""; //null 값이 아닌 비어있는 값으로 대체
}

//오늘 날짜
java.util.Date today = new java.util.Date();
SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String issueDate = cal.format(today);

// db 삽입하기
String sql_insert = "insert into "+code+" (title,context,issueDate,attach,attachRe)";
		sql_insert += " values ('"+title+"','"+context+"','"+issueDate+"','"+attach_name+"','"+attach_rename+"')";

Connection con_insert = DriverManager.getConnection(url, user, password);
Statement stmt_insert = con_insert.createStatement();
stmt_insert.executeUpdate(sql_insert);

stmt_insert.close();
con_insert.close();
%>

<script>
	location.href="/bbs1/list.jsp?code=<%=code%>";
</script>
