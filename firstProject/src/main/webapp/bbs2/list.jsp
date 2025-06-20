<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>
<%@ include file="/include/common.jsp" %>

<%
// db 게시판 테이블명을 변수처리한다.
String code = request.getParameter("code");

String field, search, sql_search;

if(request.getParameter("search") != null && !request.getParameter("search").equals("")){
	field = request.getParameter("field");
	search = request.getParameter("search");
	sql_search = " and "+field+" like '%"+search+"%'";
}
else {
	field = "";
	search = "";
	sql_search = "";
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
	
	#edit {
		color: black;
	}	

	#remove {
		color: black;
	}
</style>

<script>
function checkWrite() {
	alert("로그인을 하셔야 글을 쓸 수 있습니다.");
	result = confirm("로그인을 하시겠습니까?");
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
	<!-- 현재 게시판과 게시판 목록사이 여백층 -->
	<tr><td style="height:70px;"></td></tr>
	<!-- 게시판 이름층 -->
	<tr>
		<td colspan=4 align="center">[자유게시판]</td>
	</tr>
	<%
	// 총 게시물 수를 구하는 쿼리
	String sql_total = "select count(*) from "+code+" where 1=1 "+sql_search;
	
	Connection con_total = DriverManager.getConnection(url, user, password);
	Statement stmt_total = con_total.createStatement();
	ResultSet rs_total = stmt_total.executeQuery(sql_total);
	
	int total_record = 0;
	if(rs_total.next()){
		total_record = rs_total.getInt("count(*)");
	}
	
	rs_total.close();
	stmt_total.close();
	con_total.close();
	
	//페이징 관련
	int page_now = 1;
	if(request.getParameter("page_now") != null){
		page_now = Integer.parseInt(request.getParameter("page_now")); //현재 페이징 수
	}

	int num_per_page = 5; //한 페이지당 출력 게시물 수
	int page_per_block = 3; //한 블럭당 출력 링크 수
	int total_page = (int)Math.ceil(total_record / (double)num_per_page); //총 페이지 수
	int first = num_per_page * (page_now - 1); //limit 시작 값
	%>
	<!-- 검색층 -->
	<tr>
		<!-- 총게시물수방 -->
		<td>Total : <%=total_record %></td>
		<!-- 검색방 -->
		<td colspan=3 align=right>
			<form action="list.jsp" method="get">
				<input type="hidden" name="code" value="<%=code%>">
				<select name="field">
					<option value="title" <%if(field.equals("title")){ %>selected<%} %>>제목</option>
					<option value="context" <%if(field.equals("context")){ %>selected<%} %>>내용</option>
					<option value="author" <%if(field.equals("author")){ %>selected<%} %>>작성자</option>
				</select>
				<input name="search" value="<%=search%>">
				<button>검색</button>
			</form>
		</td>
	</tr>
</table>
<table class="bodyFrame">
	<!-- 게시글 제목 출력 층 -->
	<tr>
		<td colspan=4>
		<!-- 게시글 제목 출력 테이블 -->
		<table width=100%>
			<tr><td colspan=5 style="border-top:1px solid black"></td></tr>
			<tr>
				<th align="center" style="width:150px; height:30px;">No</th>
				<th align="center" style="width:900px;">내용</th>
				<th align="center" style="width:150px;">작성자</th>
				<th align="center" style="width:150px;">작성일</th>
				<th align="center" style="width:150px;">조회수</th>
			</tr>
			<tr><td colspan=5 style="border-top:1px solid black"></td></tr>
			<%
			// 게시물을 작성 순서별로 정렬하는 쿼리
			String sql_sort = "select * from "+code+" where 1=1 "+sql_search+" order by no desc LIMIT "+first+", "+num_per_page;
			
			Connection con_sort = DriverManager.getConnection(url, user, password);
			Statement stmt_sort = con_sort.createStatement();
			ResultSet rs_sort = stmt_sort.executeQuery(sql_sort);
			
			int num = total_record - ((page_now - 1) * num_per_page); //넘버링 처리
			while(rs_sort.next()){
				String no = rs_sort.getString("no"); // 게시물 번호
				String id = rs_sort.getString("id"); // 작성자 아이디
				String name = rs_sort.getString("name");
				String title = rs_sort.getString("title"); // 게시물 제목 
				String context = rs_sort.getString("context"); // 게시물 내용
				String issueDate = rs_sort.getString("issueDate"); // 게시물 작성일
				String hits = rs_sort.getString("hits"); // 게시물 조회수
				// 게시물 제목의 길이가 50자가 넘어갈 때 ...처리
				int titleLength = title.length();
				if(titleLength > 50) {
					title = title.substring(0,50) + "...";
				}
			%>
			<!-- 게시물 각 목록 쿼리로부터 입력받아 출력하는 층 -->
			<tr>
				<td align="center"><%=num%></td>
				<td align="center"><a href="view.jsp?code=<%=code%>&no=<%=no%>&id=<%=id%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>"><%=title %></a></td>
				<td align="center"><%=name %></td>
				<td align="center"><%=issueDate %></td>
				<td align="center"><%=hits %></td>
			</tr>
			<tr>
				<td colspan=5 style="border-top:1px solid black"></td>
			</tr>
			<%
				num--;
			}
			rs_sort.close();
			stmt_sort.close();
			con_sort.close();
			%>
				
			<%
			if(total_record == 0){
			%>
			<tr>
				<td colspan=5 align="center" style="height:150px;">작성된 게시물이 없습니다.</td>
			</tr>
			<tr><td colspan=5 style="border-top:1px solid black"></td></tr>
			<%
			}
			%>
		</table>
		</td>
	</tr>
	<!-- 새로고침과 글쓰기층 -->
	<tr>
		<td colspan=4>
		<table width=100%>
			<tr>
				<td><a href="/bbs2/list.jsp?code=<%=code%>">[새로고침]</a></td>
				<td align=right>
				<%if(session_id != null){ %>
					<a href="/bbs2/write.jsp?code=<%=code%>">[글쓰기]</a>
				<%}else { %>
					<a href="javascript:checkWrite();">[글쓰기]</a>
				</td>
				<%} %>
			</tr>
		</table>
		<table width="100%">
			<tr>
				<td>
				<%
				// 페이징 처리 시작 /////////////////////////////
				int total_block = 0;
				int block = 0;
				int first_page = 0;
				int last_page = 0;
				int direct_page = 0;
				int my_page = 0;
				
				total_block = (int)Math.ceil(total_page / (double)page_per_block); //총 블럭 수
				block = (int)Math.ceil(page_now / (double)page_per_block); //현재 블럭
				first_page = (block - 1) * page_per_block; //블럭내 시작하는 수
				last_page = block * page_per_block; //블럭내 끝나는 수
				
				if(total_block <= block) { //마지막 블럭일 때
					last_page = total_page; //반복문 변수 처리
				}
				
				// 이전 블럭 처리			
				if(block != 1){ //첫 블럭이 아니라면
				%>
					<a href="list.jsp?code=<%=code%>&field=<%=field%>&search=<%=search%>&page_now=<%=first_page%>"><img src="img/btn_left.gif"></a>&nbsp;&nbsp;
				<%
				}
				
				// 블럭내 페이지 수 출력 
				for(direct_page = first_page + 1; direct_page <= last_page; direct_page++){
					if(page_now == direct_page){
				%>
					<span id="page_on"><%=direct_page%></span>&nbsp;
				<%
					}else{
				%>
					<span id="page_off"><a href="list.jsp?code=<%=code%>&field=<%=field%>&search=<%=search%>&page_now=<%=direct_page%>"><%=direct_page%></a></span>&nbsp;
				<%
					}
				}
				
				// 다음 블럭 처리
				if(block < total_block) { //다음 블럭 존재
				%>
					&nbsp;<a href="list.jsp?code=<%=code%>&field=<%=field%>&search=<%=search%>&page_now=<%=last_page + 1%>"><img src="img/btn_right.gif"></a>
				<%
				}
				//페이징 처리 끝 /////////////////////////////			
				%>				
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
				<!-- 회원탈퇴 페이지는 a태그 href에 /user/delUserInfo.jsp 추후에 추가하기 -->
				<td id="join" colspan=2 style="text-align:center; color:#000;"><a id="edit" href="/user/editUserInfo.jsp">[회원정보수정]</a> | <a id="remove" href="">[회원탈퇴]</a></td>
			</tr>
			<tr>
				<td style="text-align:center; font-size:15px; color:#000;">아이디 : </td>
				<td style="text-align:center; font-size:15px; color:#000;"><%=session_id %></td>
			</tr>
			<tr>
				<td style="text-align:center; font-size:15px; color:#000;">이름 :</td>
				<td style="text-align:center; font-size:15px; color:#000;"><%=session_name %></td>
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