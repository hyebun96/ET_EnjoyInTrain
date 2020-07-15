<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>


<style>
table{
	border: 1px solid #BDBDBD;
}
table tr{
	border-bottom: 1px solid #BDBDBD;
}
</style>

<script type="text/javascript">
function unCrewBtn(){
	var name=$("#name").val();
	var tel1=$("#tel1").val();
	var tel2=$("#tel2").val();
	var tel3=$("#tel3").val();
	var email=$("#email").val();
	var password=$("#password").val();
	var password2=$("#password2").val();
	if(name==""||tel1==""||tel2==""||tel3==""||email==""||password==""||password==""){
		alert("정보를 입력하세요");
		return;
	}
	if(password.length<5||password2.length<5){
		alert("비밀번호는 5자리 입니다.");
		return;
	}
	if(password!=password2){
		alert("비밀번호가 일치하지 않습니다.");
		return;
	}
	var agree=$("input[name=agree]:checked").val();
	if(agree!="yes"){
		alert("개인정보 수집 및 이용에 동의하셔야 승차권 예약이 가능합니다.");
		return;
	}
	
	var f=document.unCrewForm;
	f.submit();
}

</script>
	<!-- Main -->
		<div id="page" >
			<!-- Main -->
			<div id="main" class="container" style="margin-top: 0; padding-top: 0;">
				<div class="row">
					<div class="9u skel-cell-important">
						<section>
							<header>
								<form action="<%=cp%>/reservation/confirm"  name="unCrewForm" method="post">
								<input type="hidden" name="startSt" value="${map.startSt}">
								<input type="hidden" name="endSt" value="${map.endSt}">
								<input type="hidden" name="day" value="${map.day}">
								<input type="hidden" name="time" value="${map.time}">
								<input type="hidden" name="tCategory" value="${map.tCategory}">
								<input type="hidden" name="path" value="${map.path}">
								<input type="hidden" name="adult" value="${map.adult}">
								<input type="hidden" name="child" value="${map.child}">
								<input type="hidden" name="senior" value="${map.senior}">
								<input type="hidden" name="disabled1" value="${map.disabled1}">
								<input type="hidden" name="disabled2" value="${map.disabled2}">
								<input type="hidden" name="seat" value="${map.seat}">
								<input type="hidden" name="seat2" value="${map.seat2}">
								<input type="hidden" name="total" value="${map.total}">
								<input type="hidden" name="trainCode" value="${map.trainCode}">
								<input type="hidden" name="trainName" value="${map.trainName}">
								<input type="hidden" name="stTime" value="${map.stTime}">
								<input type="hidden" name="endTime" value="${map.endTime}">
								<input type="hidden" name="roomGrade" value="${map.roomGrade}">
								<input type="hidden" name="directRv" value="true">
								<input type="hidden" name="unCrew" value="true">
								<h2>미등록고객 예매</h2>
								<span class="byline">UNCREW RESERVATION</span>
								<div style="width: 1200px; text-align: center;">
								 	<table style="width:100%;  ">
								 		<tr style="height:40px;  border-top: 2px solid black;">
								 			<td style="width:200px; background:#44565B;"><b style="color: white;">성명</b></td>
								 			<td style="text-align: left;"><input id="name" name="name" style="margin: 7px;" type="text"></td>
								 		</tr>
								 		<tr style="height:40px;">
								 			<td style="background:#44565B;"><b style="color: white;">전화번호</b></td>
								 			<td style="text-align: left;">
								 				<input id="tel1" name="tel1" style="margin: 7px;" type="text">-<input id="tel2" name="tel2" style="margin: 7px;" type="text">-<input id="tel3" name="tel3" style="margin: 7px;" type="text">
								 			</td>
								 		</tr>
								 		<tr style="height:40px;">
								 			<td style="background:#44565B;"><b style="color: white;">이메일</b></td>
								 			<td style="text-align: left;"><input id="email" name="email" type="text" style="width:300px; margin: 7px;"></td>
								 		</tr>
								 		<tr style="height:40px;">
								 			<td style="background:#44565B;"><b style="color: white;">비밀번호</b></td>
								 			<td style="text-align: left;"><input id="password" maxlength="5" name="password" style="margin: 7px;" type="password">※ 발권조회 확인용 숫자 5자리를 입력하세요.</td>
								 		</tr>
								 		<tr style="height:40px;">
								 			<td style="background:#44565B;"><b style="color: white;">비밀번호 확인</b></td>
								 			<td style="text-align: left;"><input id="password2" maxlength="5" style="margin: 7px;" type="password"></td>
								 		</tr>
								 	</table>
								 	<div style="text-align: left;">
									 	<span style="text-align: left;">개인정보 수집 및 이용에 대한 안내(필수)</span>
								 	</div>
								 	<div style="text-align:left; border: 1px solid #BDBDBD; padding: 20px;">
								 		<span>ET는 미등록 고객의 승차권 예매를 위하여 아래와 같은 최소한의 개인정보를 수집 및 이용합니다.</span><br>
 										<span>- 필수정보 : 성명, 전화번호, 비밀번호, 이메일</span><br>
										<span>- 이용목적 : 미등록 고객 승차권 예매</span><br>
										<span>- 보유기간 : 승차 종료일로부터 1년</span><br>
										<br>
										<span>이용자는 개인정보 수집/이용에 동의하지 않을 권리가 있으나, 거부 시 승차권 예약이 불가합니다.</span><br>
								 	</div>
								 	<div style="text-align: right;">
									 	<span style="text-align: right;">개인정보 수집 및 이용에 동의합니다.(필수)</span>
									 	<span>
									 		<input class="agree" type="radio" value="yes" name="agree"><label>동의</label>
									 		<input class="agree" type="radio" value="no" name="agree"><label>미동의</label>
									 	</span>
								 	</div>
								 	<br>
								 	<button type="button" onclick="unCrewBtn()" style="font-weight:bold; font-size:15px; border-radius:5px; width:100px; height:30px; background: #44565B; color: white; border: none;">확인</button>
								</div>
								
								</form>
							</header>
						</section>
					</div>
					
				</div>
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->