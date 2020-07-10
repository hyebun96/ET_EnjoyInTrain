<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<style type="text/css">
.notcrewbtn{
	width: 180px;
	height: 50px;
	background: white;
	border-color: #cccccc;
	border-width: 1px;
	margin-bottom:10px;
}

.findbtn{
	width: 100px;
	height: 35px;
	background: white;
	border-color: #cccccc;
	border-width: 1px;
	margin: 10px 10px 15px 10px;
}

.btn{
	width: 100px;
	height: 80px;
	border-color: #cccccc;
	border-width: 1px;
	margin-bottom:10px;
	background: white;
	vertical-align: middle;
}

</style>

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
	<!-- /Banner -->

	<!-- Main -->
		<div id="page">
			<!-- Main -->
			<div id="main" class="container" style=" width: 1000px; border-top:3px solid #6f047f; height:300px;  margin-top: 0; padding-top: 0;" >
				<form name="loginForm" method="post" action="">
					<div style="padding:50px 0px; text-align:center; float: left; width:60%; height:250px; border: 1px solid gray; ">
						<table style="width:450px; height:150px; text-align: center; margin: 0 auto;"  >
							<tr style="padding: 10px;">
								<td style="font-size:17px; font-weight:bold; text-align:left; width: 20%; height: 30%;">아&nbsp;이&nbsp;디</td>
								<td style="width: 50%; height: 30%;"><input name="crewId" id="crewId" type="text" style="border:1px solid #BDBDBD; width: 100%;"></td>
								<td style="text-align: right;"  rowspan="2" ><button style="border:none; font-weight:bold; background: #6f047f; color: white;" type="button" class="btn" onclick="sendLogin();">확&nbsp;인</button></td>
							</tr>
							<tr>
								<td style="font-size:17px; font-weight:bold; text-align:left; width: 20%; height: 30%;">비밀번호</td>
								<td style="width: 40%; height: 30%;"><input name="crewPwd" id="crewPwd" type="password" style="border:1px solid #BDBDBD; width: 100%;"></td>
							</tr>
							<tr>
								<td colspan="3">
									<button class="findbtn" style="border:1px solid #BDBDBD;  background: #EAEAEA;">아이디 찾기</button>
									<button class="findbtn" style="border:1px solid #BDBDBD; background: #EAEAEA;">비밀번호 찾기</button>
									<button class="findbtn" style="border:1px solid #BDBDBD; background: #EAEAEA;" type="button" onclick="javascript:location.href='<%=cp%>/crew/crew';">회원가입</button>
									<p style="color: red;">${message}</p>
								</td>
							</tr>
						</table>				
					</div>
					<div style="text-align:center;  width:40%; height:250px; float: left; border: 1px solid gray; border-left:none; margin: 0px auto;">
						<div style="margin: 30px;">
							<ul>
								<li><p>미등록고객은 아래의 버튼을 <br>이용하시기 바랍니다.</p></li>
								<li><button type="button" onclick="javascript:location.href='<%=cp%>/reservation/main';" style="background: #6f047f; border:none; color: white;" class="notcrewbtn">미등록고객 예매</button></li>
								<li><button type="button" style="background: #6f047f; border:none; color: white;" class="notcrewbtn">환불ㆍ재발권ㆍ영수증</button></li>
							</ul>
						</div>
					</div>
				</form>
			</div>
			<!-- Main -->
		</div>
	<!-- /Main -->