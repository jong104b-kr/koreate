<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp"%>

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

<h1>상품목록</h1>
<fieldset>
<legend>상품목록</legend>
<div class="tableRow">
	<!-- 검색층 -->
	<table style="width:100%">
		<tr>
			<td>Total : ${count }</td>
			<td align="right">
				<form method="get">
				<table>
					<tr>
						<td>
							<select name="field">
								<option value="itemCode" <c:if test="${field == 'itemCode' }">selected</c:if>>상품코드</option>
								<option value="itemName" <c:if test="${field == 'itemName' }">selected</c:if>>상품명</option>
							</select>
							<input name="search" value="${search }">
							<button>검색</button>
						</td>
					</tr>
				</table>
				</form>
			</td>
		</tr>
	</table>
	<!-- 상품목록 표시 -->
	<table style="width:100%">
		<tr bgcolor="#e5ecef" height="30">
			<td class="tdTitle">No</td>
			<td class="tdTitle">상품코드</td>
			<td class="tdTitle">이미지</td>
			<td class="tdTitle">상품명</td>
			<td class="tdTitle">상품가격</td>
			<td class="tdTitle">재고수량</td>
			<td class="tdTitle">판매여부</td>
		</tr>
		<c:set var="number" value="${number }" />
		<c:forEach var="i" items="${v }">
		<form action="addBoard" method="post">
		<input type="hidden" name="number" value="${number }">	
		<tr style="height:24px;">
			<td width=40 align="center">${number }</td>
			<td align="center">${i.itemCode }</td>
			<td align="center" style="padding-top:4px;">
				<a href="view?itemCode=${i.itemCode }&pagingNumber=${pagingNumber }&field=${field}&search=${search}"><img src="/uploadItem/${i.itemImage1 }" width=150 height=150></a>
			</td>
			<td align="center">${i.itemName }</td>
			<td align="center">${i.itemPrice }</td>
			<td align="center">${i.itemQuantity }</td>
			<td align="center">( ${i.itemOnSale } )</td>
		</tr>
		<tr><td colspan=7 height=1 bgcolor="#e5ecef"></td></tr>
		</form>
		<c:set var="number" value="${number - 1 }" />
		</c:forEach>
	</table>

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
<table style="width:800px;">
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
	</tr>
</table>
<br>
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
			cartAdd.qty.value = num - 1;
		}		
	}else{ //증가
		cartAdd.qty.value = num + 1;
	}
}
//장바구니 , 바로구매 버튼 처리
function cart_order(str){
	order.value = str;
	document.cartAddBoard.submit();
}
</script>
<%@ include file="/include/footer.jsp"%>