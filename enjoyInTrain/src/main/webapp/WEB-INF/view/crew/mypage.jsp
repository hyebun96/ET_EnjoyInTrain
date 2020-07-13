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
.mypage{
	margin-left: 100px;
}
</style>


<script type="text/javascript">




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
							<li><a href="<%=cp%>/crew/mypage">MyPage</a></li>
							<li><a href="<%=cp%>/crew/update">정보수정</a></li>
							<li><a href="#">구매내역</a></li>
										
						</ul>
					</section>
				</div>
				<!-- /사이드바 메뉴 -->
			
				<!-- 메인 내용 -->
				<div class="9u skel-cell-important">
					<header>
						<h2><i class="fas fa-id-card-alt"></i> MyPage </h2>
					</header>
					
					<img src="<%=cp%>/resource/images/user0000.png" alt="" width="80px;" height="80" style="float: left;">
					<div class="mypage">
							크루 이름 : ${dto.crewName} <br>
							크루 생년월일 : ${dto.crewBirth}<br>
							크루 전화번호 : ${dto.crewTel}<br>
							크루 이메일 : ${dto.crewEmail}<br>
							채팅 경고 : ${dto.crewChatWarning} 회<br>
			        </div>
					
					
					
					
					
				</div>
				<!-- /메인내용 -->
				</div>
			</div>
			<!-- Main -->
		</div>
	<!-- /Main -->
