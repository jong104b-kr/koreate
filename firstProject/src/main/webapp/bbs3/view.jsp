<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>
<%@ include file="/include/common.jsp" %>

<%
// db 게시판 테이블명을 변수처리한다.
String code = request.getParameter("code");
String no = request.getParameter("no");

// 수정 및 편집을 위해 아이디 확인
String id = request.getParameter("id");

// 검색 관련
String field = request.getParameter("field");
String search = request.getParameter("search");

//페이징 관련
String page_now = request.getParameter("page_now");
%>

<%-- <%
// 조회수를 +1 하는 코드
String sql_count ="update "+code+" set hits=hits+1 where no="+no;

Connection con_count = DriverManager.getConnection(url, user, password);
Statement stmt_count = con_count.createStatement();
stmt_count.executeUpdate(sql_count);

out.print(sql_count);
stmt_count.close();
con_count.close();
%> --%>

<%
// View (상세보기)
String sql_view = "select * from "+code+" where no="+no;

Connection con_view = DriverManager.getConnection(url, user, password);
Statement stmt_view = con_view.createStatement();
ResultSet rs_view = stmt_view.executeQuery(sql_view);

// 전역변수 선언
String title = "";
String name = "";
String issueDate = "";
String attach = "";

// 쿼리값을 대입
if(rs_view.next()){
	title = rs_view.getString("title");
	name = rs_view.getString("name");
	issueDate = rs_view.getString("issueDate");
	attach = rs_view.getString("attach");
}

rs_view.close();
stmt_view.close();
con_view.close();
%>

<!-- 본문 적용할 스타일시트 오버로딩 -->
<style>
	body{
		background-image: url("/img/imgBoard.png");
		background-repeat: no-repeat;
		background-attachment: fixed;
		background-size: 100% 100%;
	}
	
	#page_on {
		padding: 0px 5px;
		color: red;
		border:1px solid red;
		font-weight: bold;
	}
	
	#page_off {
		padding: 0px 5px;
		color: black;
		border:1px solid red;
	}
</style>

<script>
function checkWrite() {
	alert("작성자나 관리자만 글을 편집할 수 있습니다.");
	result = confirm("관리자로 로그인을 하시겠습니까?");
	if(result == true) {
		location.href = '/';
	}
}
</script>

<!-- 타이틀과 로그인 사이 들어갈 내용부분 -->
<table class="bodyFrame">
	<!-- 여백층 -->
	<tr><td style="height:10px;"></td></tr>
	<!-- 게시판 리스트층 -->
	<tr>
		<td style="text-align:center; font-size:15px; color:#fff;"><a href="/bbs1/list.jsp?code=notice">[소개 및 뉴스]</a></td>
		<td style="text-align:center; font-size:15px; color:#fff;"><a href="/bbs2/list.jsp?code=public">[자유게시판]</a></td>
		<td style="text-align:center; font-size:15px; color:#fff;"><a href="/bbs3/list.jsp?code=photos">[인증샷 갤러리]</a></td>
		<td style="text-align:center; font-size:15px; color:#fff;"><a href="/bbs4/list.jsp?code=qna">[민원과 답변]</a></td>
	</tr>
	<!-- 여백층 -->
	<tr><td style="height:70px;"></td></tr>
	<!-- 게시판 이름층 -->
	<tr>
		<td colspan=4 align="center">[인증샷 갤러리]</td>
	</tr>
	<!-- 게시글 제목 출력 층 -->
	<tr>
		<td colspan=4>
		<!-- 게시글 제목 출력 테이블 -->
		<table class="bodyFrame">
			<!-- 제목층 -->
			<tr><td colspan=5 style="border-top:1px solid black"></td></tr>
			<tr>
				<td width="375" align="center"><b>번호</b></td>
				<td width="375" align="center"><b>제목</b></td>
				<td width="375" align="center"><b>글쓴이</b></td>
				<td width="375" align="center"><b>날짜</b></td>
			</tr>
			<!-- 본문층 -->
			<tr><td colspan=4 style="border-top:1px solid black"></td></tr>
			<tr>
				<td align="center" style="width:60px;"><%=no %></td>
				<td align="center" style="width:840px;"><img src="/upload/<%=attach %>"></td>
				<td align="center" style="width:300px;"><%=name %></td>
				<td align="center" style="width:300px;"><%=issueDate %></td>
			</tr>
			<%if(!attach.equals("")){ //첨부파일 존재 %>
			<tr height=26>
				<td colspan=4>● 첨부 : <a href="/upload/<%=attach %>" download><%=attach %></a></td>
			</tr>
			<%} %>
			<tr>
				<td colspan=4 style="border-top:1px solid black"></td>
			</tr>
		</table>
		</td>
	</tr>
	<!-- 목록과 수정,삭제 -->
	<tr>
		<td colspan=4>
			<table class="bodyFrame">
				<tr>
					<td><a href="list.jsp?code=<%=code%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>">[목록]</a></td>
					<td align=right>
					<%if(session_id != null && (session_id.equals(id)) || (session_id != null && (session_level.equals("3")))){ %>
						<a href="modify.jsp?code=<%=code%>&no=<%=no%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>">[수정]</a>					
						<a href="remove.jsp?code=<%=code%>&no=<%=no%>">[삭제]</a>
					<%}else { %>
						<a href="javascript:checkWrite();">[수정]</a>
						<a href="javascript:checkWrite();">[삭제]</a>
					</td>
					<%} %>
				</tr>
			</table>		
		</td>
	</tr>
</table>

<!-- 댓글 부분 시작 -->
<br>
<div style="width:1500px;height:30px;text-align:center;font-weight:bold;color:blue">●댓글</div>

<table width="700" border="0" cellpadding="0" cellspacing="0">
	<tr><td colspan=3 height=1 width=100% bgcolor=#97b1ec></td></tr>
<%
//댓글 목록
String sql_comment="select * from comment where tb_table='"+code+"' and tb_no="+no;

Connection conn_comment=DriverManager.getConnection(url, user, password);
Statement stmt_comment=conn_comment.createStatement();
ResultSet rs_comment=stmt_comment.executeQuery(sql_comment);

int i=0;
while(rs_comment.next()){
	int com_no = rs_comment.getInt("no");
	String tb_id = rs_comment.getString("tb_id");
%>
	<tr height=26>
		<td width=90><%=rs_comment.getString("tb_name") %></td>
		<td width=510 style="padding:5px 0px 5px 0px;">
			<%=rs_comment.getString("tb_comment") %>
			<%
			//작성자 or 관리자 삭제
			if((session_id != null && session_id.equals(tb_id)) || (session_id !=null && session_level.equals("3"))){
			%>
			<a href='comment_delete.jsp?code=<%=code%>&no=<%=no%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>&com_no=<%=com_no%>'>
				<img src='img/comment_del.gif'></a>
			<%
			}
			%>
		</td>
		<td width=100 align=right><%=rs_comment.getString("tb_issueDate") %></td>
	</tr>
	<tr><td colspan=3 height=1 width=100% bgcolor=#97b1ec></td></tr>
<%
	i++;
}
rs_comment.close();
stmt_comment.close();
conn_comment.close();

if(i == 0){ //출력할 내용이 없다면
%>
	<tr><td colspan=3 align=center height=40>등록된 댓글이 없습니다.</td></tr>
	<tr><td colspan=3 height=1 width=100% bgcolor=#97b1ec></td></tr>
<%
}
%>
</table>

<form action="comment_insert.jsp" method="post" onsubmit="return send()">
<input type="hidden" name="code" value="<%=code %>">
<input type="hidden" name="no" value="<%=no %>">
<input type="hidden" name="field" value="<%=field %>">
<input type="hidden" name="search" value="<%=search %>">
<input type="hidden" name="page_now" value="<%=page_now %>">

<table width="700" border="0" cellpadding="0" cellspacing="0">
	<tr height=30>
		<td width=610><input id="view_comment" name="view_comment" style="width:99%"></td>
		<td width=90 align=right>
			<%if(session_id != null){ %>
			<button>댓글등록</button>
			<%}else{ %>
			<input type="button" onclick="javascript:alert('로그인 후 사용 가능합니다.')" value="댓글등록">
			<%} %>
		</td>
	</tr>
	<tr><td colspan=2 height=1 width=100% bgcolor=#97b1ec></td></tr>
</table>
</form>
<script>
function send(){
	if(!view_comment.value){
		alert("댓글 내용을 입력하세요.");
		view_comment.focus();
		return false;
	}
}
</script>
<br>
<!-- 댓글 부분 끝 -->

<!-- 회원정보 입력부분 -->
<table class="inputFrame">
<tr>
	<td align="center">
		<form name="" action="/user/logout.jsp" method="get" onsubmit="return checkLogin()">
		<table class="inputInfoFrame">
			<tr>
				<td id="join" colspan=2 style="text-align:center; color:#fff;"><a id="" href="/user/editUserInfo.jsp">[회원정보수정]</a> | <a id="" href="/user/delUserInfo.jsp">[회원탈퇴]</a></td>
			</tr>
			<tr>
				<td style="text-align:center; font-size:15px; color:#fff;">아이디 : </td>
				<td style="text-align:center; font-size:15px; color:#fff;"><%=session_id %></td>
			</tr>
			<tr>
				<td style="text-align:center; font-size:15px; color:#fff;">이름 :</td>
				<td style="text-align:center; font-size:15px; color:#fff;"><%=session_name %></td>
			</tr>
			<tr>
				<td colspan=2 style="padding-left:100px;"><button>로그아웃</button></td>
			</tr>
		</table>
		</form>
	</td>
</tr>
</table>

<%@ include file="/include/footer.jsp" %>