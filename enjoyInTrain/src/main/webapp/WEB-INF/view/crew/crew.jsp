<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
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
				<form action="" name="crewForm" method="post">
					<table style="width: 100%;">
						<tr>
							<td width="150px">아이디</td>
							<td>
								<p><input id="crewId" style="width: 100%;" name="crewId" type="text" placeholder="아이디" onchange="crewIdCheck();"></p>
								<p class="help-block">아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.</p>
							</td>
						</tr>
						<tr>
							<td>패스워드</td>
							<td>
								<p><input name="crewPwd" type="password"  style="width: 100%;" placeholder="패스워드"></p>
								<p>패스워드는 5~10자 이내이며, 하나 이상의 숫자나 특수문자가 포함되어야 합니다.</p>
							</td>
						</tr>
						<tr>
							<td>패스워드 확인</td>
							<td>
								<p><input type="password" name="crewPwdCheck"  style="width: 100%;" placeholder="패스워드 확인"></p>
								<p>패스워드를 한번 더 입력해주세요.</p>
							</td>
						</tr>
						<tr>
							<td>이름</td>
							<td><input name="crewName" type="text"  style="width: 100%;" placeholder="이름"></td>
						</tr>
						<tr>
							<td>생년월일</td>
							<td>
								<p><input name="crewBirth" type="text"  style="width: 100%;" placeholder="생년월일"></p>
								<p>생년월일은 2000-01-01 형식으로 입력 합니다.</p>
							</td>
						</tr>
						<tr>
							<td>이메일</td>
							<td>
								<select name="selectEmail" onchange="changeEmail();">
									<option value="">선 택</option>
									<option value="naver.com">네이버 메일</option>
									<option value="daum.net">다음 메일</option>
									<option value="gmail.com">지 메일</option>
									<option value="direct">직접 입력</option>
								</select>
								<input type="text" name="crewEmail1">
								@
								<input type="text" name="crewEmail2" readonly="readonly">
							</td>
						</tr>
						<tr>
							<td>전화번호</td>
							<td>
								<select name="crewTel1">
									<option value="">선택</option>
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
								</select>
								-
								<input type="text" name="crewTel2">
								-
								<input type="text" name="crewTel3">
							</td>
						</tr>
						<tr>
							<td>약관동의</td>
							<td><input type="checkbox" checked="checked" onchange="form.sendButton.disabled=!checked"></td>
						</tr>
					</table>
					<button name="sendButton" type="button" onclick="crewOk();">회원가입</button>
					<button type="reset">다시입력</button>
					<button type="button" onclick="javascript:location.href='<%=cp%>/';">가입취소</button>
					<p>${message}</p>
				</form>
			</div>
			<!-- Main -->
		</div>
	<!-- /Main -->

	<!-- Featured -->
		<div id="featured">
			<div class="container">
				<div class="row">
					<section class="4u">
						<div class="box">
							<a href="#" class="image left"><img src="<%=cp%>/resource/images/pics04.jpg" alt=""></a>
							<h3>Etiam posuere augue</h3>
							<p>Donec nonummy magna quis risus eleifend. </p>
							<a href="#" class="button">More</a>
						</div>
					</section>
					<section class="4u">
						<div class="box">
							<a href="#" class="image left"><img src="<%=cp%>/resource/images/pics05.jpg" alt=""></a>
							<h3>Etiam posuere augue</h3>
							<p>Donec nonummy magna quis risus eleifend. </p>
							<a href="#" class="button">More</a>
						</div>
					</section>
					<section class="4u">
						<div class="box">
							<a href="#" class="image left"><img src="<%=cp%>/resource/images/pics06.jpg" alt=""></a>
							<h3>Etiam posuere augue</h3>
							<p>Donec nonummy magna quis risus eleifend. </p>
							<a href="#" class="button">More</a>
						</div>
					</section>
				</div>
				<div class="divider"></div>
			</div>
		</div>
	<!-- /Featured -->
	
	<!-- Footer -->
		
			<div class="container">
				<div class="row">
					<div class="3u">
						<section>
							<h2>Maecenas lectus</h2>
							<div class="balloon">
								<blockquote>&ldquo;&nbsp;&nbsp;Donec leo, vivamus ullamcorper fermentum nibh in augue pulvinar ullamcorper metus praesent a lacus at urna congue ullamcorper  rutrum.&nbsp;&nbsp;&rdquo;<br>
									<br>
									<strong>&ndash;&nbsp;&nbsp;John Smith</strong></blockquote>
							</div>
							<div class="ballon-bgbtm">&nbsp;</div>
						</section>
					</div>
					<div class="3u">
						<section>
							<h2>Donec dictum</h2>
							<ul class="default">
								<li>
									<h3>Mauris vulputate dolor sit amet</h3>
									<p><a href="#">Donec leo, vivamus fermentum nibh in augue praesent a lacus at urna congue rutrum.</a></p>
								</li>
								<li>
									<h3>Fusce ultrices fringilla metus</h3>
									<p><a href="#">Donec leo, vivamus fermentum nibh in augue praesent a lacus at urna congue rutrum.</a></p>
								</li>
								<li>
									<h3>Donec dictum metus in sapien</h3>
									<p><a href="#">Donec leo, vivamus fermentum nibh in augue praesent a lacus at urna congue rutrum.</a></p>
								</li>
							</ul>
						</section>
					</div>
					<div class="3u">
						<section>
							<h2>Nulla leifend</h2>
							<p>Donec placerat odio vel elit. Nullam ante orci, pellentesque eget, tempus quis, ultrices in, est. Curabitur sit amet nulla. Nam in massa. Sed vel tellus. Curabitur sem urna, consequat.</p>
							<ul class="style5">
								<li><a href="#"><img src="images/pics07.jpg" alt=""></a></li>
								<li><a href="#"><img src="images/pics08.jpg" alt=""></a></li>
								<li><a href="#"><img src="images/pics09.jpg" alt=""></a></li>
								<li><a href="#"><img src="images/pics10.jpg" alt=""></a></li>
								<li><a href="#"><img src="images/pics11.jpg" alt=""></a></li>
								<li><a href="#"><img src="images/pics12.jpg" alt=""></a></li>
							</ul>
							<a href="#" class="button">More Collections</a>
						</section>
					</div>
					<div class="3u">
						<section>
							<h2>Luctus eleifend</h2>
							<p><strong>Aliquam erat volutpat. Pellentesque tristique ante ut risus. </strong></p>
							<p>Quisque dictum. Integer nisl risus, sagittis convallis, rutrum id, elementum congue, nibh. Suspendisse dictum porta lectus. Donec placerat odio vel elit.</p>
							<p>Donec placerat odio vel elit. Nullam ante orci, pellentesque eget, tempus quis, ultrices in, est. Curabitur sit amet nulla. Nam in massa. Sed vel tellus. Curabitur sem urna, consequat.</p>
							<a href="#" class="button">More Collections</a>
						</section>
					</div>
				</div>
			</div>
	<!-- /Footer -->