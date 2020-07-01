<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript">
function sendLogin(){
	var f=document.loginForm;
	var str=f.crewId.value;
	if(!str){
		alert("아이디를 입력하세요.");
		f.crewId.focus();
		return;
	}
	
	str=f.crewPwd.value;
	if(!str){
		alert("패스워드를 입력하세요.");
		f.crewPwd.focus();
		return;
	}
	
	f.action="<%=cp%>/crew/login";
	f.submit();
}
</script>

<!-- Banner -->
		<div id="banner">
			<div class="container">
			</div>
		</div>
	<!-- /Banner -->

	<!-- Main -->
		<div id="page">
			<!-- Main -->
			<div id="main" class="container" style=" width: 1000px; height:300px;  margin-top: 0; padding-top: 0;" >
				<form name="loginForm" method="post" action="">
					<div style="padding:50px 0px; text-align:center; float: left; width:60%; height:250px; border: 1px solid gray;">
						<table style="width:450px; height:150px; text-align: center; margin: 0 auto;"  >
							<tr style="padding: 10px;">
								<td style="text-align:left; width: 20%; height: 30%;">아&nbsp;이&nbsp;디</td>
								<td style="width: 50%; height: 30%;"><input name="crewId" id="crewId" type="text" style="width: 100%;"></td>
								<td  rowspan="2" ><button type="button" onclick="sendLogin();" style="width: 80%; height: 80%;">확인</button></td>
							</tr>
							<tr>
								<td style=" text-align:left; width: 20%; height: 30%;">비밀번호</td>
								<td style="width: 40%; height: 30%;"><input name="crewPwd" id="crewPwd" type="password" style="width: 100%;"></td>
							</tr>
							<tr>
								<td colspan="3">
									<button style="width: 100px; ">회원번호 찾기</button>
									<button style="width: 100px; ">비밀번호 찾기</button>
									<button type="button" onclick="javascript:location.href='<%=cp%>/crew/crew';" style="width: 100px; ">회원가입</button>
								</td>
							</tr>
						</table>				
					</div>
					<div style="text-align:center; padding:50px; width:40%; height:250px; float: left; border: 1px solid gray; margin: 0px auto;">
						<ul>
							<li><button>미등록고객 예매</button></li>
							<li><button>환불|재발권|영수증</button></li>
						</ul>
					</div>
					<p>${message}</p>
				</form>
			</div>
			<!-- Main -->
		</div>
	<!-- /Main -->