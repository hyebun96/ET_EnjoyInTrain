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

#page {
    padding: 5em 0em 15em 0em;
}

.help-block{
	font-size: 12px;
	margin-top: -10px;
}
.help-block1{
	font-size: 12px;
 
}
.btn{
	width: 80px; 
	height: 30px; 
	margin-top: 20px; 
	background-color: white; 
	border-color: #cccccc;
	border-radius: 10px;
	
}
.btn1{
	width: 80px; 
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
function crewOk(){
	var f=document.crewForm;
	var str;
	str=f.crewId.value;
	str=str.trim();
	if(!str){
		alert("아이디를 입력하세요.");
		f.crewId.focus();
		return;
	}
	if(!/^[a-z][a-z0-9_]{4,9}$/i.test(str)) { 
		alert("아이디는 5~10자이며 첫글자는 영문자이어야 합니다.");
		f.crewId.focus();
		return;
	}
	f.crewId.value = str;
	
	str = f.crewPwd.value;
	str = str.trim();
	if(!str) {
		alert("패스워드를 입력하세요. ");
		f.crewPwd.focus();
		return;
	}
	if(!/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str)) { 
		alert("패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.");
		f.crewPwd.focus();
		return;
	}
	f.crewPwd.value = str;
	
	if(str!= f.crewPwdCheck.value) {
        alert("패스워드가 일치하지 않습니다. ");
        f.crewPwdCheck.focus();
        return;
	}
	
	str = f.crewName.value;
	str = str.trim();
    if(!str) {
        alert("이름을 입력하세요. ");
        f.crewName.focus();
        return;
    }
    f.crewName.value = str;
    
    str = f.crewBirth.value;
	str = str.trim();
    if(!str  || !isValidDateFormat(str) ) {
        alert("생년월일를 입력하세요[YYYY-MM-DD]. ");
        f.crewBirth.focus();
        return;
    }
    
    str = f.crewTel1.value;
	str = str.trim();
    if(!str) {
        alert("전화번호를 입력하세요. ");
        f.crewTel1.focus();
        return;
    }

    str = f.crewTel2.value;
	str = str.trim();
    if(!str) {
        alert("전화번호를 입력하세요. ");
        f.crewTel2.focus();
        return;
    }
    
    if(!/^(\d+)$/.test(str)) {
        alert("숫자만 가능합니다. ");
        f.crewTel2.focus();
        return;
    }
    
    str = f.crewTel3.value;
	str = str.trim();
    if(!str) {
        alert("전화번호를 입력하세요. ");
        f.crewTel3.focus();
        return;
    }
    if(!/^(\d+)$/.test(str)) {
        alert("숫자만 가능합니다. ");
        f.crewTel3.focus();
        return;
    }
    
    str = f.crewEmail1.value;
	str = str.trim();
    if(!str) {
        alert("이메일을 입력하세요. ");
        f.crewEmail1.focus();
        return;
    }

    str = f.crewEmail2.value;
	str = str.trim();
    if(!str) {
        alert("이메일을 입력하세요. ");
        f.crewEmail2.focus();
        return;
    }
    
    f.action = "<%=cp%>/crew/${mode}";

    f.submit();
}

function isValidDateFormat(data){
    var regexp = /[12][0-9]{3}[\.|\-|\/]?[0-9]{2}[\.|\-|\/]?[0-9]{2}/;
    if(! regexp.test(data))
        return false;

    regexp=/(\.)|(\-)|(\/)/g;
    data=data.replace(regexp, "");
    
	var y=parseInt(data.substr(0, 4));
    var m=parseInt(data.substr(4, 2));
    if(m<1||m>12) 
    	return false;
    var d=parseInt(data.substr(6));
    var lastDay = (new Date(y, m, 0)).getDate();
    if(d<1||d>lastDay)
    	return false;
		
	return true;
}

function changeEmail(){
	var f=document.crewForm;
	var str=f.selectEmail.value;
	if(str!="direct"){
		f.crewEmail2.value=str;
		f.crewEmail2.readOnly=true;
		f.crewEmail1.fucus();
	}
	else{
		f.crewEmail2.value="";
		f.crewEmail2.readOnly=false;
		f.crewEmail1.focus();
	}
}

function crewIdCheck(){
	var str = $("#crewId").val();
	str = str.trim();
	if(!/^[a-z][a-z0-9_]{4,9}$/i.test(str)) { 
		$("#crewId").focus();
		return;
	}
	
	var url="<%=cp%>/crew/crewIdCheck";
	var q="crewId="+str;
	
	$.ajax({
		type:"post"
		,url:url
		,data:q
		,dataType:"json"
		,success:function(data){
			var p=data.passed;
			if(p=="true"){
				var s="<span style='color:blue;font-weight:bold;'>"+str+"</span> 아이디는 사용 가능합니다.";
				$("#crewId").parent().next(".help-block").html(s);
			}else{
				var s="<span style='color:red;font-weight:bold;'>"+str+"</span> 아이디는 사용할 수 없습니다.";
				$("#crewId").parent().next(".help-block").html(s);
				$("#crewId").val("");
				$("#crewId").focus();
			}
		}
		,error:function(e){
			console.log(e.responseText);
		}
	});
	
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
						<h2 align="center"><i class="fas fa-user-plus"></i> 회원가입 <br><br><br></h2>
				</header>
				<form action="" name="crewForm" method="post">
					<table style="width: 85%; margin: 20px auto 0px;">
						<tr>
							<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            		<label style="font-weight: 900;">아이디</label>
			     			</td>
							<td style="padding: 0 0 10px 15px;">
								<p><input id="crewId" style="width: 100%;" name="crewId" type="text" placeholder="아이디" onchange="crewIdCheck();"></p>
								<p class="help-block">아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.</p>
							</td>
						</tr>
						<tr>
							<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            		<label style="font-weight: 900;">패스워드</label>
			      			</td>
			     			<td style="padding: 0 0 10px 15px;">
								<p style="margin-top: 1px; margin-bottom: 5px;"><input name="crewPwd" type="password"  style="width: 100%;" placeholder="패스워드"></p>
								<p class="help-block1">패스워드는 5~10자 이내이며, 하나 이상의 숫자나 특수문자가 포함되어야 합니다.</p>
							</td>
						</tr>
						<tr>
							<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            		<label style="font-weight: 900;">패스워드 확인</label>
			      			</td>
			      			<td style="padding: 0 0 10px 15px;">
								<p style="margin-top: 1px; margin-bottom: 5px;"><input type="password" name="crewPwdCheck"  style="width: 100%;" placeholder="패스워드 확인"></p>
								<p class="help-block1">패스워드를 한번 더 입력해주세요.</p>
							</td>
						</tr>
						<tr>
							<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            		<label style="font-weight: 900;">이름</label>
			      			</td>
			      			<td style="padding: 0 0 20px 15px;">
			      				<p style="margin-top: 1px; margin-bottom: 5px;">
								<input name="crewName" type="text"  style="width: 100%;" placeholder="이름">
							</td>
						</tr>
						<tr>
							<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            		<label style="font-weight: 900;">생년월일</label>
			      			</td>
			      			<td style="padding: 0 0 10px 15px;">
								<p style="margin-top: 1px; margin-bottom: 5px;"><input name="crewBirth" type="text"  style="width: 100%;" placeholder="생년월일"></p>
								<p class="help-block1">생년월일은 2000-01-01 형식으로 입력 합니다.</p>
							</td>
						</tr>
						<tr>
							<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            		<label style="font-weight: 900;">이메일</label>
			      			</td>
			      			<td style="padding: 0 0 20px 15px;">
			        			<p style="margin-top: 1px; margin-bottom: 5px;">
								<select name="selectEmail" onchange="changeEmail();">
									<option value="">선 택</option>
									<option value="naver.com" ${dto.crewEmail2=="naver.com" ? "selected='selected'" : ""}>네이버</option>
									<option value="hanmail.net" ${dto.crewEmail2=="hanmail.net" ? "selected='selected'" : ""}>한메일</option>
									<option value="hotmail.com" ${dto.crewEmail2=="hotmail.com" ? "selected='selected'" : ""}>핫메일</option>
									<option value="gmail.com" ${dto.crewEmail2=="gmail.com" ? "selected='selected'" : ""}>지메일</option>
									<option value="direct">입력</option>
								</select>
				            <input type="text" name="crewEmail1" size="13" maxlength="30" style="width: 39%;">
								@
				            <input type="text" name="crewEmail2" size="13" maxlength="30" readonly="readonly" style="width: 40%;">
							</td>
						</tr>
						<tr>
							<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            		<label style="font-weight: 900;">전화번호</label>
			      			</td>
			      			<td style="padding: 0 0 20px 15px;">
			        			<p style="margin-top: 1px; margin-bottom: 5px;">
								<select name="crewTel1">
									<option value="">선택</option>
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
								</select>
								-
								<input type="text" name="crewTel2" style="width: 41%;">
								-
								<input type="text" name="crewTel3" style="width: 41%;">
							</td>
						</tr>
						<tr>
							<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
				            	<label style="font-weight: 900;">약관동의</label>
				      		</td>
							<td style="padding: 0 0 10px 15px;">
				       			<p style="margin-top: 7px; margin-bottom: 5px;">
								<input type="checkbox" checked="checked" onchange="form.sendButton.disabled=!checked">
								</p>
							</td>
						</tr>
					</table>
					<button class="btn1" name="sendButton" type="button" onclick="crewOk();">회원가입</button>
					<button class="btn" type="reset">다시입력</button>
					<button class="btn" type="button" onclick="javascript:location.href='<%=cp%>/';">가입취소</button>
					<p>${message}</p>
				</form>
			</div>
			<!-- Main -->
		</div>
	<!-- /Main -->
