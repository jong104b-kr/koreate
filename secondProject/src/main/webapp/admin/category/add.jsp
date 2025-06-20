<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/admin/include/header.jsp" %>

<script>
function category_ok(){
	if(!category.ca_id.value){
		alert("분류코드를 입력하세요.");
		category.ca_id.focus();
		return false;
	}
	if(!category.ca_name.value){
		alert("분류명을 입력하세요.");
		category.ca_name.focus();
		return false;
	}
	document.join.submit();
}
</script>

<fieldset>
<legend>상품입고</legend>
	<div class="tableRow">
	<table style="height:50px">
		<tr>
			<td align=center style="color:#777;font-size:14px;font-weight:bold;">[분류관리]</td>
		</tr>
	</table>
	<form name="category" action="add" method="post" onsubmit="return category_ok()">
	<table style="width:300px;">
		<tr height=30>
			<td>분류코드</td>
			<td><input id="cateId" name="cateId"></td>
		</tr>
		<tr height=30>
			<td>분류명</td>
			<td><input id="cateName" name="cateName"></td>
		</tr>
		<tr height=30>
			<td>판매여부</td>
			<td>
				<input type="radio" id="cateUse" name="cateUse" value="Y" checked>Y
				<input type="radio" id="cateUse" name="cateUse" value="N">N
			</td>
		</tr>
		<tr>
			<td></td>
			<td><button>분류추가</button></td>
		</tr>
	</table>
	</form>
	<br>	
	</div>
</fieldset>

<%@ include file="/admin/include/footer.jsp"%>