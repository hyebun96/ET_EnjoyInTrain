<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
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

    str = f.birth.value;
	str = str.trim();
    if(!str /* || !isValidDateFormat(str) */) {
        alert("생년월일를 입력하세요[YYYY-MM-DD]. ");
        f.birth.focus();
        return;
    }
    
    str = f.tel1.value;
	str = str.trim();
    if(!str) {
        alert("전화번호를 입력하세요. ");
        f.tel1.focus();
        return;
    }

    str = f.tel2.value;
	str = str.trim();
    if(!str) {
        alert("전화번호를 입력하세요. ");
        f.tel2.focus();
        return;
    }
    if(!/^(\d+)$/.test(str)) {
        alert("숫자만 가능합니다. ");
        f.tel2.focus();
        return;
    }

    str = f.tel3.value;
	str = str.trim();
    if(!str) {
        alert("전화번호를 입력하세요. ");
        f.tel3.focus();
        return;
    }
    if(!/^(\d+)$/.test(str)) {
        alert("숫자만 가능합니다. ");
        f.tel3.focus();
        return;
    }
    
    str = f.email1.value;
	str = str.trim();
    if(!str) {
        alert("이메일을 입력하세요. ");
        f.email1.focus();
        return;
    }

    str = f.email2.value;
	str = str.trim();
    if(!str) {
        alert("이메일을 입력하세요. ");
        f.email2.focus();
        return;
    }

 	f.action = "<%=cp%>/crew/${mode}";

    f.submit();
}

function changeEmail() {
    var f = document.crewForm;
	    
    var str = f.selectEmail.value;
    if(str!="direct") {
        f.email2.value=str; 
        f.email2.readOnly = true;
        f.email1.focus(); 
    }
    else {
        f.email2.value="";
        f.email2.readOnly = false;
        f.email1.focus();
    }
}

function crewIdCheck() {
<%-- 	var str = $("#crewId").val();
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
		,success:function(data) {
			var p=data.passed;
			if(p=="true") {
				var s="<span style='color:blue;font-weight:bold;'>"+str+"</span> 아이디는 사용 가능합니다.";
				$("#crewId").parent().next(".help-block").html(s);
			} else {
				var s="<span style='color:red;font-weight:bold;'>"+str+"</span> 아이디는 사용할 수 없습니다.";
				$("#crewId").parent().next(".help-block").html(s);
				$("#crewId").val("");
				$("#crewId").focus();
			}
		}
	    ,error:function(e) {
	    	console.log(e.responseText);
	    }
	}); --%>
	
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
				<div class="body-title">
			        <h3>${mode=="crew"?"회원 가입":"회원 정보 수정"}</h3>
			    </div>
				<form name="crewForm" method="post">
				  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
				  <tr>
				      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
				            <label style="font-weight: 900;">아이디</label>
				      </td>
				      <td style="padding: 0 0 15px 15px;">
				        <p style="margin-top: 1px; margin-bottom: 5px;">
				            <input type="text" name="crewId" id="crewId" value="${dto.crewId}"
	                         onchange="crewIdCheck();" style="width: 95%;"
	                         ${mode=="update" ? "readonly='readonly' ":""}
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
				      <td style="padding: 0 0 15px 15px;">
				        <p style="margin-top: 1px; margin-bottom: 5px;">
				            <input type="password" name="crewPwdCheck" maxlength="15"
				                       style="width: 95%;" placeholder="패스워드 확인">
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
			                      style="width: 95%;"
			                      ${mode=="update" ? "readonly='readonly' ":""}
			                      placeholder="이름">
				        </p>
				      </td>
				  </tr>
				
				  <tr>
				      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
				            <label style="font-weight: 900;">생년월일</label>
				      </td>
				      <td style="padding: 0 0 15px 15px;">
				        <p style="margin-top: 1px; margin-bottom: 5px;">
				            <input type="text" name="birth" value="${dto.birth}" maxlength="10" 
				                       style="width: 95%;" placeholder="생년월일">
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
				                <option value="naver.com" ${dto.email2=="naver.com" ? "selected='selected'" : ""}>네이버 메일</option>
				                <option value="hanmail.net" ${dto.email2=="hanmail.net" ? "selected='selected'" : ""}>한 메일</option>
				                <option value="hotmail.com" ${dto.email2=="hotmail.com" ? "selected='selected'" : ""}>핫 메일</option>
				                <option value="gmail.com" ${dto.email2=="gmail.com" ? "selected='selected'" : ""}>지 메일</option>
				                <option value="direct">직접입력</option>
				            </select>
				            <input type="text" name="email1" value="${dto.email1}" size="13" maxlength="30">
				            @ 
				            <input type="text" name="email2" value="${dto.email2}" size="13" maxlength="30"  readonly="readonly">
				        </p>
				      </td>
				  </tr>
				  
				  <tr>
				      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
				            <label style="font-weight: 900;">전화번호</label>
				      </td>
				      <td style="padding: 0 0 15px 15px;">
				        <p style="margin-top: 1px; margin-bottom: 5px;">
				            <select class="selectField" id="tel1" name="tel1" >
				                <option value="">선 택</option>
				                <option value="010" ${dto.tel1=="010" ? "selected='selected'" : ""}>010</option>
				                <option value="011" ${dto.tel1=="011" ? "selected='selected'" : ""}>011</option>
				                <option value="016" ${dto.tel1=="016" ? "selected='selected'" : ""}>016</option>
				                <option value="017" ${dto.tel1=="017" ? "selected='selected'" : ""}>017</option>
				                <option value="018" ${dto.tel1=="018" ? "selected='selected'" : ""}>018</option>
				                <option value="019" ${dto.tel1=="019" ? "selected='selected'" : ""}>019</option>
				            </select>
				            -
				            <input type="text" name="tel2" value="${dto.tel2}" maxlength="4">
				            -
				            <input type="text" name="tel3" value="${dto.tel3}" maxlength="4">
				        </p>
				      </td>
				  </tr>
				  <c:if test="${mode=='crew'}">
					  <tr>
					      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
					            <label style="font-weight: 900;">약관동의</label>
					      </td>
					      <td style="padding: 0 0 15px 15px;">
					        <p style="margin-top: 7px; margin-bottom: 5px;">
					             <label>
					                 <input id="agree" name="agree" type="checkbox" checked="checked"
					                      onchange="form.sendButton.disabled = !checked"> <a href="#">이용약관</a>에 동의합니다.
					             </label>
					        </p>
					      </td>
					  </tr>
				  </c:if>
				  </table>
				
				  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
				     <tr height="45"> 
				      <td align="center" >
				        <button type="button" name="sendButton" class="btn" onclick="crewOk();">${mode=="crew"?"회원가입":"정보수정"}</button>
				        <button type="reset" class="btn">다시입력</button>
				        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/';">${mode=="crew"?"가입취소":"수정취소"}</button>
				      </td>
				    </tr>
				    <tr height="30">
				        <td align="center" style="color: blue;">${message}</td>
				    </tr>
				  </table>
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
	
