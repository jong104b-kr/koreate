<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/admin/include/header.jsp" %>

<script>
var popupX = (window.screen.width/2)-(600/2);
var popupY = (window.screen.height/2)-(500/2);

function popupDetail(str){ // 상세
	window.open("view?id="+str,"view","width=600,height=500,left="+popupX+",top="+popupY);
}

function popupUpdate(str){ // 수정
	window.open("update?id="+str,"view","width=600,height=500,left="+popupX+",top="+popupY);
}

function popupDelete(str){ // 삭제
	result = confirm("삭제하시겠습니까?");
	if(result==true){
		location.href="delete?id="+str;
	}
}
</script>
<style>
.tdTitle{
	text-align:center;
	font-weight:bold;
}
</style>

<!-- 스타일 시트 수정해야 함, 팝업관련 선생님 게시물 참조 -->
<h1>회원관리</h1>
<fieldset>
	<legend>회원관리</legend>
	<div class="tableRow">
		<table style="width:700px;">
		<tr>
			<td>Total : ${count }</td>
			<td align=right>
				<form method="get">
				<table>
					<tr>
						<td>
							<select name="field" style="height:25px;">
								<option value="id" <c:if test="${field == 'id' }">selected</c:if>>아이디</option>
								<option value="name" <c:if test="${field == 'name' }">selected</c:if>>이름</option>
							</select>
							<input name="search" value="${search }" style="height:25px;">
							<button>검색</button>
						</td>
					</tr>
				</table>
				</form>
			</td>
		</tr>
		</table>
		<table style="width:700px;">
			<tr bgcolor="#e5ecef" height="30">
				<td class="tdTitle">아이디</td>
				<td class="tdTitle">이름</td>
				<td class="tdTitle">전화번호</td>
				<td class="tdTitle">이메일</td>
				<td class="tdTitle">레벨</td>
				<td class="tdTitle">Mode</td>
			</tr>
			<c:set var="number" value="${number }" />
			<c:forEach var="list" items="${v }">
				<tr height="24">
					<td align="center">${list.id }</td>
					<td align="center">${list.name }</td>
					<td align="center">${list.phone }</td>
					<td align="center">${list.email }</td>
					<td align="center">${list.level }</td>
					<td align="center">
					<span onclick="popupDetail('${list.id }')" style="cursor:pointer">[상세]</span>
					<span onclick="popupUpdate('${list.id }')" style="cursor:pointer">[수정]</span>
					<span onclick="popupDelete('${list.id }')" style="cursor:pointer">[삭제]</span>
					</td>
				</tr>
				<tr><td colspan=7 height=1 bgcolor="#e5ecef"></td></tr>
			<c:set var="number" value="${number - 1 }" />
			</c:forEach>
		</table>
	</div>
</fieldset>
<br>

<!-- 페이징 처리 -->
<style>
	.page_on {
		padding:0px 5px;
		color:red;
		border:1px solid red;
		font-weight:bold;
	}
	.page_off {
		padding:0px 5px;
		color:black;
		border:1px solid black;
	}
</style>
<table width=700 border=0>
	<tr>
		<td>
			<c:if test="${count > 0 }">
				<c:set var="pageCount" value="${count / pagingSize + (count % pagingSize == 0 ? 0 : 1) }" />
				<fmt:parseNumber var="pageCount" value="${pageCount }" integerOnly="true" />
				<!-- fmt:parseNumber : 문자열을 숫자로 변환해 주는 기능을 제공하는 태그 -->
				<!-- integerOnly : true , false 정수만 출력할 것인지를 묻는 속성 -->
			
				<!-- 2개의 변수 초기화 -->
				<c:set var="startPage" value="${1 }" />
				<c:set var="pageBlock" value="${3 }" />	
			
				<!-- 두번째 이상 블럭을 실행할 경우 startPage 값 변경 부분-->
				<c:if test="${pagingNumber > pageBlock }">
					<!-- 결과를 정수형으로 리턴 받아야 하기 대문에 fmt -->
					<fmt:parseNumber var="result" value="${pagingNumber / pageBlock - (pagingNumber % pageBlock == 0 ? 1:0) }" integerOnly="true"/>
					<c:set var="startPage" value="${result * pageBlock + 1 }" />
				</c:if>	
			
				<!-- endPage 값 설정 부분 -->
				<c:set var="endPage" value="${startPage + pageBlock - 1 }" />
				<!-- 마지막 블럭일 경우 endPage -->
				<c:if test="${endPage > pageCount }">
					<c:set var="endPage" value="${pageCount }" />
				</c:if>
			
				<!-- 이전 링크 -->
				<c:if test="${startPage > pageBlock }">
					<a href="list?pagingNumber=${startPage - pageBlock }&field=${field}&search=${search}">[이전] </a>
				</c:if>
			
				<!-- 페이징 링크 -->
				<c:forEach var="i" begin="${startPage }" end="${endPage }">
					<c:choose>
						<c:when test="${pagingNumber == i }">
							<a href="list?pagingNumber=${i}&field=${field}&search=${search}"><span class="page_on"><font color=red><b>${i }</b></font></span></a>
						</c:when>
						<c:otherwise>
							<a href="list?pagingNumber=${i}&field=${field}&search=${search}"><span class="page_off">${i }</span></a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			
				<!-- 다음 링크 -->
				<c:if test="${endPage < pageCount }">
					<a href="list?pagingNumber=${startPage + pageBlock }&field=${field}&search=${search}">[다음] </a>
				</c:if>
			</c:if>
		</td>
		<td align="right"><a href="add">[회원등록]</a></td>
	</tr>
</table>
<br>
	
<%@ include file="/admin/include/footer.jsp"%>