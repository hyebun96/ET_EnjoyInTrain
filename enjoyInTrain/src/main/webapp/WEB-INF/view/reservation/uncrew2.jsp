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
$(function(){
	$("#unCrew2Btn").click(function(){
		var name=$("#name").val();
		var tel1=$("#tel1").val();
		var tel2=$("#tel2").val();
		var tel3=$("#tel3").val();
		var email=$("#email").val();
		var password=$("#password").val();
		if(name==""||tel1==""||tel2==""||tel3==""||email==""||password==""||password==""){
			alert("정보를 입력하세요");
			return;
		}
		if(password.length<5){
			alert("비밀번호는 5자리 입니다.");
			return;
		}
		
		var f=document.unCrew2Form;
		f.submit();
	});
});

</script>
	<!-- Main -->
		<div id="page" >
			<!-- Main -->
			<div id="main" class="container" style="margin-top: 0; padding-top: 0;">
				<div class="row">
					<div class="9u skel-cell-important">
						<section>
							<header>
								<form action="<%=cp%>/reservation/unCrewSubmit"  name="unCrew2Form" method="post">
								<h2>미등록고객 발권내역/취소</h2>
								<span class="byline">UNCREW RESERVATION</span>
								<div style="width: 1200px; text-align: center;">
									<div style="text-align:left; border: 1px solid #BDBDBD; padding: 20px; margin-bottom: 15px;">
										<span>· 승차권 발권 시 입력한 정보를 입력하십시오.</span><br>
										<span>· 개인정보보호를 위해 발권내역 조회 시 입력하신 비밀번호가 일치하는 내역만 조회됩니다.</span><br>
									</div>
								 	<table style="width:100%;  ">
								 		<tr style="height:40px;  border-top: 2px solid black;">
								 			<td style="width:200px; background:#CEE3F6;"><b>성명</b></td>
								 			<td style="text-align: left;"><input id="name" name="name" style="margin: 5px;" type="text"></td>
								 		</tr>
								 		<tr style="height:40px;">
								 			<td style="background:#CEE3F6;"><b>전화번호</b></td>
								 			<td style="text-align: left;">
								 				<input id="tel1" name="tel1" style="margin: 5px;" type="text">-<input id="tel2" name="tel2" style="margin: 5px;" type="text">-<input id="tel3" name="tel3" style="margin: 5px;" type="text">
								 			</td>
								 		</tr>
								 		<tr style="height:40px;">
								 			<td style="background:#CEE3F6;"><b>이메일</b></td>
								 			<td style="text-align: left;"><input id="email" name="email" type="text" style="width:300px; margin: 5px;"></td>
								 		</tr>
								 		<tr style="height:40px;">
								 			<td style="background:#CEE3F6;"><b>비밀번호</b></td>
								 			<td style="text-align: left;"><input id="password" maxlength="5" name="password" style="margin: 5px;" type="password">※ 구입 시 입력한 비밀번호 5자리</td>
								 		</tr>
								 	</table>
								 	<button type="button" id="unCrew2Btn" style="font-weight:bold; font-size:15px; border-radius:5px; width:100px; height:30px; background: #08298A; color: white; border: none;">확인</button>
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