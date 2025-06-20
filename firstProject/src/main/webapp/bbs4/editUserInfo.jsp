<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>
<%@ include file="/include/common.jsp" %>

<%
// 로그인 시 생성한 세션의 아이디값을 호출함  
String sql_update = "select * from user where id='"+session_id+"'";

Connection con_update = DriverManager.getConnection(url, user, password);
Statement stmt_update = con_update.createStatement();
ResultSet rs_update = stmt_update.executeQuery(sql_update);

// 수정할 정보를 입력할 변수들 선언
String user_id = "";
String user_pw = "";
String user_name = "";
String user_email = "";
String user_job = "";
String user_mobile = "";
String user_zipcode = "";
String user_addressNew = "";
String user_addressOld = "";
String user_addressDetail = "";
String user_addressRef = "";
String user_visit = "";

// 쿼리에서 받은 정보로 수정한 값을 대입
while(rs_update.next()){
	user_id = rs_update.getString("id");
	user_pw = rs_update.getString("pw");
	user_name = rs_update.getString("name");
	user_email = rs_update.getString("email");
	user_job = rs_update.getString("job");
	user_mobile = rs_update.getString("mobile");
	user_zipcode = rs_update.getString("zipcode");
	user_addressNew = rs_update.getString("addressNew");
	user_addressOld = rs_update.getString("addressOld");
	user_addressDetail = rs_update.getString("addressDetail");
	user_addressRef = rs_update.getString("addressRef");
	user_visit = rs_update.getString("visit");
}

rs_update.close();
stmt_update.close();
con_update.close();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보를 수정합니다.</title>

<!-- 외부 스타일시트 -->
<link rel="stylesheet" type="text/css" href="/css/join.css">

<script>
function editUserInfo(){
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
	if(user_pw.value != user_pw2.value){
		alert("비밀번호를 확인하세요.");
		user_pw2.focus();
		return false;
	}
	if(user_name.value == ""){
		alert("이름을 입력하세요.");
		user_name.focus();
		return false;
	}
	if(user_email.value == ""){
		alert("이메일을 입력하세요.");
		user_email.focus();
		return false;
	}
	if(user_job.value == ""){
		alert("하는일을 입력하세요.");
		user_job.focus();
		return false;
	}
	if(user_mobile.value == ""){
		alert("휴대전화번호를 입력하세요.");
		user_mobile.focus();
		return false;
	}
	if(user_zipcode.value == ""){
		alert("우편번호를 입력하세요.");
		user_zipcode.focus();
		return false;
	}
	if(user_addressNew.value == ""){
		alert("도로명주소를 입력하세요.");
		user_addressNew.focus();
		return false;
	}
	if(user_addressOld.value == ""){
		alert("지번주소를 입력하세요.");
		user_addressOld.focus();
		return false;
	}
	if(user_addressDetail.value == ""){
		alert("상세주소를 입력하세요.");
		user_addressDetail.focus();
		return false;
	}
	if(user_addressRef.value == ""){
		alert("참고사항을 입력하세요.");
		user_addressRef.focus();
		return false;
	}
	if(user_visit.value == ""){
		alert("방문일자를 입력하세요.");
		user_visit.focus();
		return false;
	}
}

function cancel(){
	var i = confirm("취소하시겠습니까?");
	if(i){
		location.href="list.jsp";	
	}
	return false;
}
</script>

<body>
<!-- 회원정보 수정테이블 -->
<table class="joinInfo">
	<tr>
		<td style="text-align:center;">회원정보수정</td>
	<tr>
		<td>
			<form action="edit.jsp" method="get" onsubmit="return editUserInfo()">
			<table>
				<tr>
					<td id="userInput">아이디</td>
					<td><input type="text" id="user_id" name="user_id" value="<%=user_id %>" size="30" disabled></td>
				</tr>
				<tr>
					<td id="userInput">비밀번호</td>
					<td><input type="password" id="user_pw" name="user_pw" value="<%=user_pw %>" size="30"></td>
				</tr>
				<tr>
					<td id="userInput">비밀번호 확인</td>
					<td><input type="password" id="user_pw2" name="user_pw2" value="<%=user_pw %>" size="30"></td>
				</tr>
				<tr>
					<td id="userInput">이름</td>
					<td><input type="text" id="user_name" name="user_name" value="<%=user_name %>" size="30"></td>
				</tr>
				<tr>
					<td id="userInput">이메일</td>
					<td><input type="email" id="user_email" name="user_email" value="<%=user_email %>" size="30"></td>
				</tr>
				<tr>
					<td id="userInput">하는일</td>
					<td><input type="text" id="user_job" name="user_job" value="<%=user_job %>" size="30"></td>
				</tr>
				<tr>
					<td id="userInput">휴대전화번호</td>
					<td><input type="number" id="user_mobile" name="user_mobile" value="<%=user_mobile %>" size="30"></td>
				</tr>
				<tr>
					<td id="userInput">사는곳</td>
					<td>
						<input type="text" id="sample4_postcode" name="user_zipcode" value="<%=user_zipcode %>" placeholder="우편번호">
						<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
						<input type="text" id="sample4_roadAddress" name="user_addressNew" value="<%=user_addressNew %>" placeholder="도로명주소">
						<input type="text" id="sample4_jibunAddress" name="user_addressOld" value="<%=user_addressOld %>" placeholder="지번주소"><br>
						<span id="guide" style="color:#999;display:none"></span>
						<input type="text" id="sample4_detailAddress" name="user_addressDetail" value="<%=user_addressDetail %>" placeholder="상세주소">
						<input type="text" id="sample4_extraAddress" name="user_addressRef" value="<%=user_addressRef %>" placeholder="참고항목">
					</td>
				</tr>
				<tr>
					<td id="userInput">방문일자</td>
					<td><input type="date" id="user_visit" name="user_visit" value="<%=user_visit %>" size="30"></td>
				</tr>
				<tr>
					<td id="inputConfirm" colspan=2><button style="width:150px;">회원정보수정</button></td>
				</tr>
			</table>
			</form>
		</td>
	</tr>
	<tr>
		<td><button onclick="cancel()">취소</button></td>
	</tr>
</table>
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