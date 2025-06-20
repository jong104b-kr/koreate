<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>
<%@ include file="/include/common.jsp" %>

<%
// db 게시판 테이블명을 변수처리한다.
String code = request.getParameter("code");
String no = request.getParameter("no");

// 검색 관련
String field = request.getParameter("field");
String search = request.getParameter("search");

//페이징 관련
String page_now = request.getParameter("page_now");
%>

<%
// 조회수를 +1 하는 코드
/* String sql_count ="update "+code+" set hits=hits+1 where no="+no;

Connection con_count = DriverManager.getConnection(url, user, password);
Statement stmt_count = con_count.createStatement();
stmt_count.executeUpdate(sql_count);

out.print(sql_count);
stmt_count.close();
con_count.close(); */
%>

<%
// View (상세보기)
String sql_view = "select * from "+code+" where no="+no;

Connection con_view = DriverManager.getConnection(url, user, password);
Statement stmt_view = con_view.createStatement();
ResultSet rs_view = stmt_view.executeQuery(sql_view);

// 전역변수 선언
String id = "";
String title = "";
String inform = "";
String context = "";
String name = "";
String issueDate = "";

// 쿼리값을 대입
if(rs_view.next()){
	id = rs_view.getString("id");
	title = rs_view.getString("title");
	inform = rs_view.getString("inform");
	context = rs_view.getString("context");
	name = rs_view.getString("name");
	issueDate = rs_view.getString("issueDate");
}

rs_view.close();
stmt_view.close();
con_view.close();

if(inform.equals("3")){ //비밀글
	if((session_level != null && session_level.equals("3")) || (session_id != null && session_id.equals(id))){
		// 관리자 또는 작성자
	}else{
%>
	<script>
		alert("읽을 권한이 없습니다.");
		history.back();
	</script>
<%
	}
}
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

<!-- 본문 삽입할 스크립트 -->
<script>
function checkLogin() {
	if(user_id.value == ""){
		alert("아이디를 입력하세요.");
		user_id.focus();
		return false;
	}
	if(user_pw.value == ""){
		alert("비밀번호를 입력하세요.");
		user_pw.focus();
		return false;
	}
}

function checkWrite() {
	alert("작성자 혹은 관리자만 편집할 수 있습니다.");
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
		<td colspan=4 align="center">[민원과 답변]</td>
	</tr>
	<!-- 게시글 제목 출력 층 -->
	<tr>
		<td colspan=4>
		<!-- 게시글 제목 출력 테이블 -->
		<table class="bodyFrame">
			<!-- 제목층 -->
			<tr><td colspan=4 style="border-top:1px solid black"></td></tr>
			<tr>
				<th align="center" style="width:150px; height:30px;">No</th>
				<th align=center style="width:1050px;">내용</th>
				<th align=center style="width:200px;">작성자</th>
				<th align=center style="width:200px;">작성일</th>
			</tr>
			<!-- 본문층 -->
			<tr><td colspan=4 style="border-top:1px solid black"></td></tr>
			<tr>
				<td align="center"><%=no %></td>
				<td align="center"><%=context %></td>
				<td align="center"><%=name %></td>
				<td align="center"><%=issueDate %></td>
			</tr>
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
						<a href="reply.jsp?code=<%=code%>&no=<%=no%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>">[답변]</a>
						<%if((session_id != null && (session_id.equals(id))) || ((session_id != null && session_level.equals("3")))){ %>	
							<a href="modify.jsp?code=<%=code%>&no=<%=no%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>">[수정]</a>					
							<a href="remove.jsp?code=<%=code%>&no=<%=no%>">[삭제]</a>
						<%}else{ %>
							<a href="javascript:checkWrite();">[수정]</a>
							<a href="javascript:checkWrite();">[삭제]</a>
						<%} %>
					</td>
				</tr>
			</table>		
		</td>
	</tr>
</table>

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