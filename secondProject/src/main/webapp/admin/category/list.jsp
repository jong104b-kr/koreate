<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/admin/include/header.jsp" %>

<style>
.cateId {
	width:70px;
	border:0px;
}
.tdTitle{
	text-align:center;
	font-weight:bold;
}
</style>

<script>
function checkDelete(id){
	var result = confirm('정말 삭제하시겠습니까?');
	
	if(result == true){
		location.href='delete?cateId='+id;
	}
}
</script>

<!-- 스타일 시트 수정해야 함, 팝업관련 선생님 게시물 참조 -->
<h1>상품입고</h1>
<fieldset>
<legend>상품입고</legend>
<div class="tableRow">
<table style="width:700px;">
	<tr>
		<td>Total : ${count }</td>
		<td align="right">
			<form method="get">
			<table>
				<tr>
					<td>
						<select name="field" style="height:20px;">
							<option value="cateId" <c:if test="${field == 'id' }">selected</c:if>>분류코드</option>
							<option value="cateName" <c:if test="${field == 'name' }">selected</c:if>>분류명</option>
						</select>
						<input name="search" value="${search }" style="height:20px;">
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
		<td class="tdTitle">No</td>
		<td class="tdTitle">분류코드</td>
		<td class="tdTitle">분류명</td>
		<td class="tdTitle">판매가능</td>
		<td class="tdTitle">관리</td>
	</tr>
	<c:set var="number" value="${number }" />
	<c:forEach var="c" items="${v }">
	<form action="update" method="post">
	<input type="hidden" name="number" value="${number }">
	<tr height="24">
		<td align="center">${number }</td>
		<td align="center">
			<!-- 들여쓰기 설명 - fn:length() - 컬렉션의 항목 수 또는 문자열의 문자 수를 반환합니다. -->
			<c:set var="id_len" value="${c.cateId }" />
			<c:forEach var="id_num" begin="1" end="${fn:length(id_len)-2}" step="1">
				&nbsp;
			</c:forEach>
			<input name="cateId" value="${c.cateId }" class="cateId" readonly></td>
		<td align="center"><input name="cateName" value="${c.cateName }"></td>
		<td align="center">
			<input type="radio" name="cateUse[${number }]" value="Y" <c:if test='${c.cateUse eq "Y"}'>checked</c:if>>Y
			<input type="radio" name="cateUse[${number }]" value="N" <c:if test='${c.cateUse eq "N"}'>checked</c:if>>N
		</td>
		<td align="center">
			<button>수정</button>
			<input type="button" value="삭제" onclick="checkDelete('${c.cateId }')">
		</td>
	</tr>
	<tr><td colspan=5 height=1 bgcolor="#e5ecef"></td></tr>
	</form>
	<c:set var="number" value="${number - 1 }" />
	</c:forEach>
	<c:if test="${count == 0}">
		<tr>
			<td colspan=5 height=50 align=center>작성된 분류가 없습니다.</td>
		</tr>
		<tr><td colspan=5 height=1 bgcolor="#e5ecef"></td></tr>
	</c:if>
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
<table style="width:700px;">
	<tr>
		<td>
			<c:if test="${count>0 }">
				<c:set var="pageCount" value="${count / pagingSize + (count % pagingSize == 0 ? 0 : 1) }" />
				<fmt:parseNumber var="pageCount" value="${pageCount }" integerOnly="true" />
				<!-- fmt:parseNumber : 문자열을 숫자로 변환해 주는 기능을 제공하는 태그 -->
				<!-- integerOnly : true , false 정수만 출력할 것인지를 묻는 속성 -->
			
				<!-- 2개의 변수 초기화 -->
				<c:set var="startPage" value="${1 }" />
				<c:set var="pageBlock" value="${3 }" />	
			
				<!-- 다음 페이지 블럭이 존재 할 경우 startPage 값 변경 부분-->
				<c:if test="${pagingNumber > pageBlock }">
					<!-- 결과를 정수형으로 리턴 받아야 하기 대문에 fmt -->
					<fmt:parseNumber var="result" value="${pagingNumber / pageBlock - (pagingNumber % pageBlock == 0 ? 1:0) }" integerOnly="true"/>
					<c:set var="startPage" value="${result * pageBlock + 1 }" />
				</c:if>	
			
				<!-- endPage 값 설정 부분 -->
				<c:set var="endPage" value="${startPage + pageBlock - 1 }" />
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
							<a href="list?pagingNumber=${i }&field=${field}&search=${search}"><span class="page_on"><font color=red><b>${i }</b></font></span></a>
						</c:when>
						<c:otherwise>
							<a href="list?pagingNumber=${i }&field=${field}&search=${search}"><span class="page_off">${i }</span></a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			
				<!-- 다음 링크 -->
				<c:if test="${endPage < pageCount }">
					<a href="list?pagingNumber=${startPage + pageBlock }&field=${field}&search=${search}">[다음] </a>
				</c:if>
			</c:if>
		</td>
		<td align="right"><a href="add">[상품등록]</a></td>
	</tr>
</table>
<br>
	
<%@ include file="/admin/include/footer.jsp"%>