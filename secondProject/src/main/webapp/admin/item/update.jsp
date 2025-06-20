<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/admin/include/header.jsp" %>

<script>
function subCate(cate,cate2){
	$.ajax({
		url: "subCategory", //전송받을 페이지 경로
		type: "post", //데이터 읽어오는 방식
		dataType: "text", //데이터 방식
		data: "cateId="+cate+"&cateSubId="+cate2, //데이터 변수 전달
		error:function(){ //실패일 경우
			alert("실패");
		},
		success:function(text){ //성공일 경우
			$("#subCategoryResult").html(text);
		}
	});
}

subCate(${item.itemCategory},${item.itemSubCategory}); //중분류 한번 실행

function itemOk(){
	document.submit();
}
</script>

<fieldset>
<legend>재고관리</legend>
<div class="tableRow">
<table style="width:100%;height:50px;">
	<tr>
		<td style="color:#777;font-size:14px;font-weight:bold;">[재고관리]</td>
	</tr>
</table>

<form action="update" method="post" enctype="multipart/form-data" onsubmit="return itemOk()">
<input type="hidden" name="itemCode" value="${item.itemCode }">
<input type="hidden" name="pagingNumber" value="${param.pagingNumber }">
<input type="hidden" name="field" value="${param.field }">
<input type="hidden" name="search" value="${param.search }">
<table style="width:480;">
	<tr>
		<td width=160>상품코드</td>
		<td height=24><font color=red>${item.itemCode }</font></td>
	</tr>
	<tr>
		<td>카테고리</td>
		<td>
			<select id="itemCategory" name="itemCategory" onchange="subCate(this.value)">
				<option value="">=대분류 선택=</option>
				<c:forEach var="c" items="${v }">
				<option value="${c.cateId }" <c:if test="${item.itemCategory == c.cateId }">selected</c:if>>${c.cateName }</option>
				</c:forEach>
			</select>
			<span id="subCategoryResult">
				<select id="itemSubCategory" name="itemSubCategory">
					<option value="">=대분류를 먼저 선택하세요=</option>
				</select>
			</span>
		</td>
	</tr>
	<tr>
		<td>상품명</td>
		<td><input name="itemName" value="${item.itemName }"></td>
	</tr>
	<tr>
		<td>업체아이디</td>
		<td><input name="id" value="${item.id }"></td>
	</tr>
	<tr>
		<td>판매가격</td>
		<td><input name="itemPrice" value="${item.itemPrice }"></td>
	</tr>
	<tr>
		<td>상품수량</td>
		<td><input type="number" name="itemQuantity" value="${item.itemQuantity }"></td>
	</tr>
	<tr>
		<td>판매여부</td>
		<td>
			<input type="radio" name="itemOnSale" value="Y" <c:if test="${item.itemOnSale == 'Y' }">checked</c:if>>Y
			<input type="radio" name="itemOnSale" value="N" <c:if test="${item.itemOnSale == 'N' }">checked</c:if>>N
		</td>
	</tr>
	<tr>
		<td>상품이미지1</td>
		<td>
			<input type="file" name="itemImage1">
			<c:if test="${item.itemImage1 != ''}"><img src="/uploadItem/${item.itemImage1 }" width=40 height=40></c:if> ${item.itemImage1 }
		</td>
	</tr>
	<tr><td colspan=2 height=10></td></tr>
	<tr>
		<td></td>
		<td>
			<input type="button" value="목록" onclick="location.href='list?pagingNumber=${param.pagingNumber }&field=${param.field}&search=${param.search}'">
			<button>상품수정</button>
		</td>
	</tr>
</table>
</form>
<br>
</div>
</fieldset>

<%@ include file="/admin/include/footer.jsp"%>