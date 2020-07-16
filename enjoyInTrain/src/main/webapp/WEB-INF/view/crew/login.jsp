<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
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
	background: #e8e8e8;
	border-color: #cccccc;
	border-width: 1px;
	margin: 35px 10px 15px 10px;
	border-radius: 5px;
	cursor: pointer;
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

#page {
    padding: 10px 0px 35px 0px;
}

header h2 {
    font-size: 2.5em;
    padding-top: 50px;
}

.homepage #main {
    margin-top: 0px;
    padding-top: 6em;
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
				<header>
						<h2 align="center"><i class="fas fa-check"></i> 로그인<br><br></h2>
				</header>
			<div id="main" class="container" style=" width: 1000px; border-top:3px solid #273267; height:270px; padding-top: 0;" >
				<form name="loginForm" method="post" action="">
					<div style="padding:50px 0px; text-align:center; float: left; width:60%; height:250px; border: 1px solid #cccccc; margin-bottom: 10px;">
						<table style="width:450px; height:150px; text-align: center; margin: 0 auto;"  >
							<tr style="padding: 10px;">
								<td style="font-size:17px; font-weight:bold; text-align:left; width: 20%; height: 30%;">아&nbsp;이&nbsp;디</td>
								<td style="width: 50%; height: 30%;"><input name="crewId" id="crewId" type="text" style="border:1px solid #BDBDBD; width: 100%;" autocomplete="off"></td>
								<td style="text-align: right;"  rowspan="2" ><button style="border:none; font-weight:bold; background: #273267; color: white;" type="button" class="btn" onclick="sendLogin();">확&nbsp;인</button></td>
							</tr>
							<tr>
								<td style="font-size:17px; font-weight:bold; text-align:left; width: 20%; height: 30%;">비밀번호</td>
								<td style="width: 40%; height: 30%;"><input name="crewPwd" id="crewPwd" type="password" style="border:1px solid #BDBDBD; width: 100%;" autocomplete="off"></td>
							</tr>
							<tr>
								<td colspan="3">
									<button class="findbtn"  type="button" onclick="javascript:location.href='<%=cp%>/crew/idfind';">아이디 찾기</button>
									<button class="findbtn"  type="button" onclick="javascript:location.href='<%=cp%>/crew/idfind';">비밀번호 찾기</button>
									<button class="findbtn"  type="button" onclick="javascript:location.href='<%=cp%>/crew/crew';">회원가입</button>
									<p style="color: red;">${message}</p>
								</td>
							</tr>
						</table>				
					</div>
					<div style="text-align:center;  width:40%; height:250px; float: left; border: 1px solid #cccccc; border-left:none; margin: 0px auto;">
						<div style="margin: 30px;">
							<ul>
								<li><p>미등록고객은 아래의 버튼을 <br>이용하시기 바랍니다.</p></li>
								<li><button type="button" onclick="javascript:location.href='<%=cp%>/reservation/main';" style="background: #273267; border:none; color: white;" class="notcrewbtn">미등록고객 예매</button></li>
								<li><button type="button" onclick="javascript:location.href='<%=cp%>/reservation/uncrew2';" style="background: #273267; border:none; color: white;" class="notcrewbtn">발권내역/취소</button></li>
							</ul>
						</div>
					</div>
				</form>
			</div>
					<div class="container" style=" width: 1000px; height:230px; padding-top: 0;" >
						<table>
							<tr style="border: 1px solid #cccccc; ">
								<td style="margin-top: 10px; width: 1000px; padding: 20px;">
									<span>※ 비밀번호 5회 오류 시 로그인 할 수 없습니다.</span><br>
									<span>· 전화번호 또는 이메일 인증을 받으시면 아이디 또는 비밀번호를 찾을 수 있습니다.</span><br>
									<span>· 로그인 후 30분 동안 입력이 없을 경우 자동으로 로그아웃됩니다.</span><br>
								</td>
							</tr>
						</table>
					</div>
			<!-- Main -->
		</div>
	<!-- /Main -->