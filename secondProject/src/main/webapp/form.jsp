<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시골커피 커피공장</title>
<link rel="stylesheet" href="/css/cscoffee.css">
<link rel="stylesheet" href="/css/styledform.css">
</head>
<body>
    <h1>시골커피 커피공장</h1>
    <h2>아래 양식을 채운 후, “주문” 버튼을 클릭하세요</h2>
    <form action="#" method="post">
	<fieldset>
		<legend>주문내역</legend>
		<div class="tableRow">
			<label for="beans">
          		커피를 선택하세요:
			</label>
            <select id="beans" name="beans">
              <option value="House Blend">하우스 블렌드</option>
              <option value="Bolivia">쉐이드 그로운 볼리비아 수프레모</option>
              <option value="Guatemala">유기농 과테말라 </option>
              <option value="Kenya">케냐</option>
            </select>
		</div>
		<div class="tableRow">
			<label>유형:</label>
			<p>
           		<input type="radio" id="whole_beantype" name="beantype" value="whole"> 
					<label for="whole_beantype">분쇄하지 않은 커피</label><br>
            	<input type="radio" id="ground_beantype" name="beantype" value="ground" checked> 
            		<label for="ground_beantype">분쇄한 커피</label>
			</p>
		</div>
		<div class="tableRow">
			<label for="bags">상품 개수:</label>
			<input type="number" id="bags" name="bags" min="1" max="10">
		</div>
		<div class="tableRow">
			<label for="date">배송일자:</label>
			<input type="date" name="date">
		</div>
		<div class="tableRow">
			<label>기타:</label>
			<p>
            	<input type="checkbox" id="giftwrap_extras" name="extras[]" value="giftwrap"> 
					<label for="giftwrap_extras">선물 포장</label><br>
            	<input type="checkbox" id="catalog_extras" name="extras[]" value="catalog" checked>
            		<label for="catalog_extras">카탈로그 포함</label>
			</p>
		</div>
	</fieldset>
	<fieldset>
		<legend>배송지 주소</legend>
		<div class="tableRow">
			<label for="name">이름:</label>
			<input type="text" id="name" name="name" value="" placeholder="회원명" required> 
		</div>
		<div class="tableRow">
			<label for="phone">전화번호:</label>
			<input type="tel" id="phone" name="phone" value="" placeholder="010-0000-0000 입력요망" required>
		</div>
		<div class="tableRow">
			<label for="email">이메일:</label>
			<input type="email" id="email" name="email" value="" placeholder="nickname@domain.com" required>
		</div>
		<div class="tableRow">
			<label for="zip">주소:</label>
			<input type="text" id="sample4_postcode" name="zipcode" placeholder="우편번호">
			<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" id="sample4_roadAddress" name="addressNew" placeholder="도로명주소">
			<input type="text" id="sample4_jibunAddress" name="addressOld" placeholder="지번주소"><br>
			<span id="guide" style="color:#999;display:none"></span>
			<input type="text" id="sample4_detailAddress" name="addressDetail" placeholder="상세주소">
			<input type="text" id="sample4_extraAddress" name="addressRef" placeholder="참고항목">
		</div>
		<div class="tableRow">
			<label for="comments">고객 요구사항:</label>
            <textarea id="comments" name="comments"></textarea>
		</div>
		<div class="tableRow">
			<label></label>
			<input type="submit" value="주문">
		</div>
	</fieldset>
    </form>
</body>

<!-- 주소입력 스크립트 하단삽입 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
</html>