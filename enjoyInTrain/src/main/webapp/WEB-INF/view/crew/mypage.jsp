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
					<table>
						<tr>
							<td>크루 이름 : ${dto.crewName}</td>
						</tr>
						<tr>
							<td>크루 생년월일 : ${dto.crewBirth}</td>
						</tr>
						<tr>
							<td>크루 전화번호 : ${dto.crewTel}</td>
						</tr>
						<tr>
							<td>크루 이메일 : ${dto.crewEmail}</td>
						</tr>
						<tr>
							<td>채팅 경고 : ${dto.crewChatWarning} 회</td>
						</tr>
					</table>
							
			     </div>
			     	
					<a href="<%=cp%>/crew/update">회원정보 수정</a>
				
				<div class="crewreservation">
					<table style="width:50%; margin-top: 50px; float: left;">
							 		<tr style="height:40px; font-weight:bold; border-top: 2px solid black; background: #EAEAEA; text-align: center;">
							 			<td style="background: #353866; color: white;" colspan="7">승차권 예약현황</td>
							 		</tr>
							 		<tr style="height:40px; font-weight:bold; background: #EAEAEA; text-align: center;">
							 			<td style="background: #C1D8F3">승차일</td>
							 			<td style="background: #C1D8F3">열차번호</td>
							 			<td style="background: #C1D8F3">출발역</td>
							 			<td style="background: #C1D8F3">도착역</td>
							 			<td style="background: #C1D8F3">금액</td>
							 			<td style="background: #C1D8F3">인원</td>
							 			<td style="background: #C1D8F3">결제</td>
							 		</tr>
							 		<c:forEach items="${list}" var="dto">
								 		<tr>
								 			<td>${dto.trDate}</td>
								 			<td>${dto.trCategory}&nbsp;${dto.trainCode}</td>
								 			<td>${dto.startCode}<br>${dto.stTime}</td>
								 			<td>${dto.endCode}<br>${dto.endTime}</td>
								 			<td>${dto.trPrice}</td>
								 			<td>${dto.count}</td>
								 			<td>결제완료</td>
								 		</tr>
							 		</c:forEach>
					</table>
				</div>
					<table  style="width:50%; margin-top: 50px;">
							<tr style="height:40px; font-weight:bold; border-top: 2px solid black; background: #EAEAEA; text-align: center;">
							 	<td style="background: #353866; color: white;" colspan="4">프로모션 예약현황</td>
							 </tr>
							<tr style="height:40px; font-weight:bold; background: #C1D8F3; text-align: center;">
								<td>예약번호</td>
								<td>프로모션 제목 </td>
								<td>구매자 </td>
								<td>예약날짜</td>
								
								
							</tr>
							<c:forEach var="dto" items="${list2}" varStatus="status">
									<tr>
										
										<td> ${dto.reservationNumber} </td>
										<td> ${dto.pmTitle} </td>
										<td> ${dto.crewName} </td>
										<td> ${dto.prReservationDate.substring(0, 10)} </td>
										
										
										
									</tr>
							</c:forEach> 
						</table>
					
					
				</div>
				<!-- /메인내용 -->
				</div>
			</div>
			<!-- Main -->
		</div>
	<!-- /Main -->
