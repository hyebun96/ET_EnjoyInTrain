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
 
.alert-info {
    border: 1px solid #9acfea;
    border-radius: 4px;
    background-color: #d9edf7;
    color: #31708f;
    padding: 15px;
    margin-top: 10px;
    margin-bottom: 20px;
}

.boxTF{
	width: 300px;
}


.btn{
	width: 80px; 
	height: 30px; 
	margin-top: 20px; 
	background-color: white; 
	border-color: #cccccc;
	border-radius: 10px;
	align: left;
	
}

.help-block{
	font-size: 12px;
}
</style>


<script type="text/javascript">
function crewOk() {
	var f = document.crewForm;
	var str;

	str = f.crewId.value;
	str = str.trim();
	if(!str) {
		alert("아이디를 입력하세요. ");
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
    if(!str /* || !isValidDateFormat(str) */) {
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

 	f.action = "<%=cp%>/crew/update";

    f.submit();
}

function changeEmail(){
	var f=document.crewForm;
	var str=f.selectEmail.value;
	if(str!="direct"){
		f.crewEmail2.value=str;
		f.crewEmail2.readOnly=true;
		f.crewEmail1.focus();
	}
	else{
		f.crewEmail2.value="";
		f.crewEmail2.readOnly=false;
		f.crewEmail1.focus();
	}
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
			<div id="main" class="container">
			 <div class="row">
				<!-- 사이드 바 메뉴 -->
				<div class="3u">
					<section class="sidebar">
						<header>
							<h2>MyPage</h2>
						</header>
						
						<ul class="style1">
							<li><a href="<%=cp%>/crew/update">정보수정</a></li>
							<li><a href="#">구매내역</a></li>
										
						</ul>
					</section>
				</div>
				<!-- /사이드바 메뉴 -->
			
				<!-- 메인 내용 -->
				<div class="9u skel-cell-important">
					<header>
						<h2><i class="fas fa-user-edit"></i> 회원정보수정</h2>
					</header>
					
					 <form name="crewForm" method="post">
						<div>
						  <table style="width: 500px; margin: 20px auto 0px; border-spacing: 0px; float: left;">
							  <tr>
							      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
							            <label style="font-weight: 900;">아이디</label>
							      </td>
							      <td style="padding: 0 0 15px 15px;">
							        <p style="margin-top: 1px; margin-bottom: 5px;">
							            <input type="text" name="crewId" id="crewId" value="${dto.crewId}"
							                      onchange="crewIdCheck();" style="width: 95%; font-weight: bold;" readonly="readonly"
							                      maxlength="15" placeholder="아이디">
							        </p>
							      </td>
							  </tr>
							
							  <tr>
							      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
							            <label style="font-weight: 900;">패스워드</label>
							      </td>
							      <td style="padding: 0 0 15px 15px;">
							        <p style="margin-top: 1px; margin-bottom: 5px;">
							            <input type="password" name="crewPwd" maxlength="15"
							                       style="width:95%;" placeholder="패스워드">
							        </p>
							      </td>
							  </tr>
							
							  <tr>
							      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
							            <label style="font-weight: 900;">패스워드 확인</label>
							      </td>
							      <td style="padding: 0 0 5px 15px;">
							        <p style="margin-top: 1px; margin-bottom: 5px;">
							            <input type="password" name="crewPwdCheck" maxlength="15" style="width: 95%;" placeholder="패스워드 확인">
							        </p>
							        <p class="help-block">패스워드를 한번 더 입력해주세요.</p>
							      </td>
							  </tr>
							
							  <tr>
							      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
							            <label style="font-weight: 900;">이름</label>
							      </td>
							      <td style="padding: 0 0 15px 15px;">
							        <p style="margin-top: 1px; margin-bottom: 5px;">
							            <input type="text" name="crewName" value="${dto.crewName}" maxlength="30" 
							                     style="width: 95%; font-weight: bold;" readonly="readonly" placeholder="이름">
							        </p>
							      </td>
							  </tr>
							
							  <tr>
							      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
							            <label style="font-weight: 900;">생년월일</label>
							      </td>
							      <td style="padding: 0 0 5px 15px;">
							        <p style="margin-top: 1px; margin-bottom: 5px;">
							            <input type="text" name="crewBirth"maxlength="10" style="width: 95%;" placeholder="생년월일">
							        </p>
							        <p class="help-block">생년월일은 2000-01-01 형식으로 입력 합니다.</p>
							      </td>
							  </tr>
							 
							  <tr>
							      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
							            <label style="font-weight: 900;">이메일</label>
							      </td>
							      <td style="padding: 0 0 15px 15px;">
							        <p style="margin-top: 1px; margin-bottom: 5px;">
							            <select name="selectEmail" onchange="changeEmail();" class="selectField">
											<option value="">선 택</option>
											<option value="naver.com" ${dto.crewEmail2=="naver.com" ? "selected='selected'" : ""}>네이버</option>
											<option value="hanmail.net" ${dto.crewEmail2=="hanmail.net" ? "selected='selected'" : ""}>한메일</option>
											<option value="hotmail.com" ${dto.crewEmail2=="hotmail.com" ? "selected='selected'" : ""}>핫메일</option>
											<option value="gmail.com" ${dto.crewEmail2=="gmail.com" ? "selected='selected'" : ""}>지메일</option>
											<option value="direct">입력</option>
							            </select>
							            <input type="text" name="crewEmail1" value="${dto.crewEmail1}" size="13" maxlength="30" style="width: 30%;">
							            @ 
							            <input type="text" name="crewEmail2" value="${dto.crewEmail2}" size="13" maxlength="30" style="width: 40%;" readonly="readonly">
							        </p>
							      </td>
							  </tr>
							 
							  <tr>
							      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
							            <label style="font-weight: 900;">전화번호</label>
							      </td>
							      <td style="padding: 0 0 15px 15px;">
											<select name="crewTel1"  class="selectField">
												<option value="">선택</option>
												<option value="010">010</option>
												<option value="011">011</option>
												<option value="016">016</option>
											</select>
											-
											<input type="text" name="crewTel2" style="width: 35%;">
											-
											<input type="text" name="crewTel3"  style="width: 38%;">
								  </td>
							  </tr>
						 </table>
						
						 <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
						    <tr height="45"> 
						     	<td align="left" style="padding-left: 150px;">
						        <button type="button" name="sendButton" class="btn" onclick="crewOk();">수정완료</button>
						        <button type="reset" class="btn">다시입력</button>
						        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/';">수정취소</button>
						    	 </td>
						  	 </tr>
						    <tr height="30">
						        <td align="center" style="color: blue;">${message}</td>
						     </tr>
						  </table>
						  </div>
					</form>
				</div>
				<!-- /메인내용 -->
				</div>
			</div>
			<!-- Main -->
		</div>
	<!-- /Main -->
