<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/admin/include/header.jsp" %>

<script>
function subCate(cate){
	$.ajax({
		url: "subCategory", //전송받을 페이지 경로
		type: "post", //데이터 전송 방식
		dataType: "text",
		data: "cateId="+cate,
		error:function(){ //실패일 경우
			alert("실패");
		},
		success:function(text){ //성공일 경우
			$("#itemSubCategoryResult").html(text);
		}
	});
}
function itemOk(){
	document.submit();
}
</script>

<fieldset>
<legend>상품관리</legend>
<div class="tableRow">
<table style="width:100%;height:50px;">
	<tr>
		<td style="color:#777;font-size:14px;font-weight:bold;">[상품관리]</td>
	</tr>
</table>
<form action="add" method="post" enctype="multipart/form-data" onsubmit="return itemOk()">
	<table style="width:480px;">
		<tr>
			<td width=160>상품코드</td>
			<td height=24><font color=red>자동으로 처리됨</font></td>
		</tr>
		<tr>
			<td>카테고리</td>
			<td>
				<select id="itemCategory" name="itemCategory" onchange="subCate(this.value)">
					<option value="">=대분류 선택=</option>
					<c:forEach var="c" items="${v }">
					<option value="${c.cateId }">${c.cateName }</option>
					</c:forEach>
				</select>
				<span id="itemSubCategoryResult">
					<select id="itemSubCategory" name="itemSubCategory">
						<option value="">=대분류를 먼저 선택하세요=</option>
					</select>
				</span>
			</td>
		</tr>
		<tr>
			<td>상품명</td>
			<td><input name="itemName"></td>
		</tr>
		<tr>
			<td>업체 아이디</td>
			<td><input name="id" value="${sessionScope.id }" readonly></td>
		</tr>
		<tr>
			<td>판매가격</td>
			<td><input name="itemPrice"></td>
		</tr>
		<tr>
			<td>상품수량</td>
			<td><input type="number" name="itemQuantity"></td>
		</tr>
		<tr>
			<td>판매가능</td>
			<td>
				<input type="radio" name="itemOnSale" value="Y" checked>Y
				<input type="radio" name="itemOnSale" value="N">N
			</td>
		</tr>
		<tr>
			<td>상품 이미지 1</td>
			<td><input type="file" name="itemImage1"></td>
		</tr>
		<tr>
			<td></td>
			<td><button>상품추가</button></td>
		</tr>
	</table>
</form>
</div>
</fieldset>

<%@ include file="/admin/include/footer.jsp"%>