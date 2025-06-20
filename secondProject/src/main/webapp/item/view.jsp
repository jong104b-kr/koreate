<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

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
</script>

<h1>상품주문보기</h1>
<fieldset>
<legend>상품주문보기</legend>
<div class="tableRow">
<form name="cartAddBoard" action="/cart/add" method="post">
<input type="hidden" name="itemCode" value="${item.itemCode }">
<input type="hidden" name="cateId" value="${category.cateId }">
<table style="width:480;"> 
	<tr>
		<td width=160>상품코드</td>
		<td height=24><font color=red>${item.itemCode }</font></td>
	</tr>
	<tr>
		<td>캐터고리</td>
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
		<td><c:if test="${item.itemImage1 != ''}"><img src="/uploadItem/${item.itemImage1 }" width=80 height=80></c:if></td>
	</tr>
</table>
<br><br><br>

<table style="width:480;">
	<tr>
		<td width=160>수량</td>
		<td>
			<input type="button" value="-" onclick="qty_num('-')" style="width:22px;height:22px;">
			<input id="qty" name="qty" value="1" style="width:20px;height:20px;border:1px solid blue;text-align:center">
			<input type="button" value="+" onclick="qty_num('+')" style="width:22px;height:22px;">
		</td>
		<td>
			<input type="button" value="장바구니" onclick="cart_order('c')">
			<input type="button" value="바로구매" onclick="cart_order('o')">
			<input type="hidden" id="order" name="order" value="">
		</td>
	</tr>
</table>
</form>
</div>
</fieldset>

<script>
//수량 증가,감소 처리
function qty_num(str){
	var num = parseInt(cartAddBoard.qty.value);
	if(str == "-"){ //차감
		if(num == 1){
			alert("주문 최소 수량은 1개입니다.");
		}else{
			cartAddBoard.qty.value = num - 1;
		}		
	}else{ //증가
		cartAddBoard.qty.value = num + 1;
	}
}
//장바구니 , 바로구매 버튼 처리
function cart_order(str){
	order.value = str;
	document.cartAddBoard.submit();
}
</script>

<%@ include file="/include/footer.jsp"%>