<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">


<style type="text/css">
.homepage #main{
	margin-top: 0em;
    padding-top: 0em;
} 

.help-block{
	font-size: 12px;
	margin-top: -10px;
}
.help-block1{
	font-size: 12px;
 
}
.btn{
	width: 100px; 
	height: 30px; 
	margin-top: 20px; 
	background-color: white; 
	border-color: #cccccc;
	border-radius: 10px;
	
}
.btn1{
	width: 100px; 
	height: 30px; 
	margin-top: 20px; 
	background-color: white; 
	border-color: #cccccc;
	border-radius: 10px;
	margin-left: 250px;
	
}

.btn00{
width: 100px; 
	height: 30px; 
	margin-top: 20px; 
	background-color: white; 
	border-color: #cccccc;
	border-radius: 10px;
	margin-left: 250px;
}
.btn01{
width: 100px; 
	height: 30px; 
	margin-top: 20px; 
	background-color: white; 
	border-color: #cccccc;
	border-radius: 10px;
	margin-left: 250px;
}

.boxTF{
	width: 300px;
}

input{
	border : 1px solid gray;
	border-radius: 4px;
}



</style>
<script type="text/javascript">
$(function(){
	var crewId = "${sessionScope.crew.crewId}";
	var crewName = "${sessionScope.crew.crewName}";
	var isVisible = $(".idsolution").is(':visible');
	var isVisible1 = $(".pwdsolution").is(':visible');
	
	
	$(".btn00").click(function() {
		
		if (! isVisible && crewName===crewName) {
			$(".idsolution").show();
			
		}
	});
	
	$(".btn01").click(function() {
		if (! isVisible && crewId===crewId) {
			$(".pwdsolution").show();
			
		}
	});
	
});


function crewfind(){
		var f=document.crewForm;
		var str;
		str=f.crewName.value;
		str=str.trim();
		if(!str){
			alert("이름를 입력하세요.");
			f.crewName.focus();
			return;
		}
		f.submit();
}
	
function crewpwdfind(){
		var f=document.crewForm;
		var str;
		str=f.crewId.value;
		str=str.trim();
		if(!str){
			alert("아이디를 입력하세요.");
			f.crewId.focus();
			return;
		}
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
			<div id="main" class="container" style="width: 700px; margin-top: 0; padding-top: 0;" >
				<header>
						<h2 align="center"><i class="fas fa-user-plus"></i> 아이디 찾기 <br><br><br></h2>
				</header>
				
				<form action="" name="crewForm" method="post">
					<table style="width: 85%; margin: 20px auto 0px;">
						
						<tr>
							<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            		<label style="font-weight: 900;">이름</label>
			      			</td>
			      			<td style="padding: 0 0 20px 15px;">
			      				<p style="margin-top: 1px; margin-bottom: 5px;">
								<input name="crewName" type="text"  style="width: 100%;" placeholder="이름">
							</td>
						</tr>
					
						<tr style="display: none;" class="idsolution">
							<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            		<label style="font-weight: 900;">아이디 ${dto.crewName}</label>
							
			      			</td>
			      			<td style="padding: 0 0 10px 15px;">
								<p style="margin-top: 1px; margin-bottom: 5px;"><input name="crewId" type="text"  style="width: 100%;" placeholder="${dto.crewId}">${dto.crewId}</p>
								<p class="help-block1">아이디를 성공적으로 찾았습니다.</p>
							</td>
						</tr>
					
					</table>
						
					<button class="btn00" name="sendButton" type="button" onclick="crewidfind();">아이디찾기</button>
					<button class="btn" type="button" onclick="javascript:location.href='<%=cp%>/';">돌아가기</button>
				</form>
			</div>
			
			
			
			
			<div id="main" class="container" style="width: 700px; margin-top: 50px; padding-top: 0;" >
				<header>
						<h2 align="center"><i class="fas fa-user-plus"></i> 비밀번호 찾기 <br><br><br></h2>
				</header>
				<form action="" name="crewForm" method="post">
					<table style="width: 85%; margin: 20px auto 0px;">
						
						<tr>
							<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            		<label style="font-weight: 900;">아이디</label>
			      			</td>
			      			<td style="padding: 0 0 20px 15px;">
			      				<p style="margin-top: 1px; margin-bottom: 5px;">
								<input name="crewId" type="text"  style="width: 100%;" placeholder="id">
							</td>
						</tr>
						<tr style="display: none;" class="pwdsolution">
							<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            		<label style="font-weight: 900;">비밀번호</label>
							
			      			</td>
			      			<td style="padding: 0 0 10px 15px;">
								<p style="margin-top: 1px; margin-bottom: 5px;"><input name="crewPwd" type="text"  style="width: 100%;" placeholder="${dto.crewPwd}">${dto.crewPwd}</p>
								<p class="help-block1">비밀번호를 성공적으로 찾았습니다.</p>
							</td>
						</tr>
						
						
					</table>
					<button class="btn01" name="sendButton" type="button" onclick="crewpwdfind();">비밀번호찾기</button>
					<button class="btn" type="button" onclick="javascript:location.href='<%=cp%>/';">돌아가기</button>
				</form>
			</div>
			<!-- Main -->
		</div>
	<!-- /Main -->
