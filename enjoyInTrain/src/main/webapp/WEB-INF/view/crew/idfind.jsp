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

.idinput{
  color: blue;
  font-style: italic;
}


</style>
<script type="text/javascript">

function ajaxJSON(url, type, query, fn) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			fn(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

function ajaxHTML(url, type, query, selector) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,success:function(data) {
			if($.trim(data)=="error") {
				listPage(1);
				return false;
			}	
			$(selector).html(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

function crewidfind(){
	var f=document.crewForm;
	var url = "<%=cp%>/crew/idfind2";
	var query = "crewName=" + f.crewName.value + "&crewTel=" + f.crewTel.value;
	var selector = "#idfind000";
	
	
	ajaxHTML(url, "get", query, selector);
}

	
function emailfind(){
		var f=document.pwdfindForm;
		
		var pwdId=f.pwdId.value;
		pwdId=pwdId.trim();
		
		var pwdTel=f.pwdTel.value;
		pwdTel=pwdTel.trim();
		
		
		if(pwdId == ""){
			alert("아이디를 입력하세요.");
			f.pwdId.focus();
			return;
		}
		
		if(pwdTel == ""){
			alert("전화번호를 입력하세요.");
			f.pwdTel.focus();
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
						<h2 align="center" style="margin-top: 20px"><i class="fas fa-key"></i> 아이디 찾기 <br><br><br></h2>
				</header>
				
				<form action="" name="crewForm" method="post">
					<table style="width: 85%; margin: 20px auto 0px;">
						
						<tr>
							<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            		<label style="font-weight: 900;">이름</label>
			      			</td>
			      			<td style="padding: 0 0 20px 15px;">
			      				<p style="margin-top: 1px; margin-bottom: 5px;">
								<input name="crewName" type="text"  style="width: 100%;" placeholder="이름을 입력해주세요.">
							</td>
							</tr>
						<tr>
							<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            		<label style="font-weight: 900;">전화번호</label>
			            	</td>
							<td style="padding: 0 0 20px 15px;">
			      				<p style="margin-top: 1px; margin-bottom: 5px;">
								<input name="crewTel" type="text"  style="width: 100%;" placeholder="전화번호를 입력해주세요.">
							</td>
						</tr>
					
						<tbody id="idfind000">
							
						</tbody>
					
					</table>
						
					<button class="btn00" name="sendButton" type="button" onclick="crewidfind();">아이디찾기</button>
					<button class="btn" type="button" onclick="javascript:location.href='<%=cp%>/';">돌아가기</button>
				</form>
			</div>
			
			
			
			
			<div id="main" class="container" style="width: 700px; margin-top: 50px; padding-top: 0;" >
				<header>
						<h2 align="center"><i class="fas fa-lock"></i> 비밀번호 찾기 <br><br><br></h2>
				</header>
				<form action="<%=cp%>/crew/emailfind" name="pwdfindForm" method="post">
					<table style="width: 85%; margin: 20px auto 0px;">
						
						<tr>
							<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            		<label style="font-weight: 900;">아이디 : </label>
			      			</td>
			      			<td style="padding: 0 0 20px 15px;">
			      				<p style="margin-top: 1px; margin-bottom: 5px;">
								<input name="pwdId" type="text"  style="width: 100%;" placeholder="id">
							</td>
						</tr>
						<tr>
							<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            		<label style="font-weight: 900;">전화번호</label>
			            	</td>
							<td style="padding: 0 0 20px 15px;">
			      				<p style="margin-top: 1px; margin-bottom: 5px;">
								<input name="pwdTel" type="text"  style="width: 100%;" placeholder="전화번호를 입력해주세요.">
							</td>
						</tr>
						<tr class="pwdsolution">
							<td valign="top" style="text-align: center; padding-top: 5px;" colspan="2">
			            		${message}
			      			</td>
						</tr>
					</table>
					<button class="btn01" name="sendButton" type="button" onclick="emailfind();">비밀번호찾기</button>
					<button class="btn" type="button" onclick="javascript:location.href='<%=cp%>/';">돌아가기</button>
				</form>
			</div>
			<!-- Main -->
		</div>
	<!-- /Main -->
