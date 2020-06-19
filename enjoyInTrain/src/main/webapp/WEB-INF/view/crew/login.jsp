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
									<button style="width: 100px; ">회원가입</button>
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
								<li><a href="#"><img src="<%=cp%>/resource/images/pics07.jpg" alt=""></a></li>
								<li><a href="#"><img src="<%=cp%>/resource/images/pics08.jpg" alt=""></a></li>
								<li><a href="#"><img src="<%=cp%>/resource/images/pics09.jpg" alt=""></a></li>
								<li><a href="#"><img src="<%=cp%>/resource/images/pics10.jpg" alt=""></a></li>
								<li><a href="#"><img src="<%=cp%>/resource/images/pics11.jpg" alt=""></a></li>
								<li><a href="#"><img src="<%=cp%>/resource/images/pics12.jpg" alt=""></a></li>
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