<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">

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
	width: 80%;
	border: 1px solid #cccccc;

}

.mypage table{
	margin: 10px;
}

.mypage tr{
	height: 40px;
	border-radius: 20px;
}

.my{
	width: 100px;
	border-radius: 20px;
	text-align: center;
	margin: 10px;
	height: 40px;
	background: #ccc;
}

.my2{
	width: 250px;
	padding-left: 10px;
}


.listtt td{
    padding-top: 5px;
}

.mypagetable{
	height: 150px;
}
</style>


<script type="text/javascript">

$(function(){
	$("ul.tabs li").click(function() {
		var tab = $(this).attr("data-tab");

			$("ul.tabs li").each(function(){
				$(this).removeClass("active");
			});
			$("#tab-"+tab).addClass("active");
		
		
		
		if(tab=="0") {
			$("#crewreservation").hide();
			$("#crewreservation2").hide();
			
		} else if(tab=="1") {
			$("#crewreservation").show();
			$("#crewreservation2").hide();
		} else if(tab=="2") {
			$("#crewreservation").hide();
			$("#crewreservation2").show();
		}
	});
});

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
			
				<!-- 메인 내용 -->
				
					<header style="width: 100%;">
						<h2><i class="fas fa-id-card-alt"></i> MyPage </h2>
					</header>
					
					<img src="<%=cp%>/resource/images/user0000.png" alt="" width="125px;" height="80" style="float: left;">
					
				<div class="mypage">
					<table class="mypagetable">
						<tr >
							<td class="my" style="background: blue;">이름 </td>
							<td class="my2">${dto.crewName} <br></td>
							<td class="my">내 포인트  </td>
							<td class="my2">${dto.point}점</td>
						</tr>
					
						<tr>
							<td class="my">생년월일  </td>
							<td class="my2">${dto.crewBirth}<br></td>
							<td class="my">전화번호  </td>
							<td class="my2">${dto.crewTel}<br></td>
						</tr>
					
						<tr>
							<td class="my">이메일  </td>
							<td class="my2">${dto.crewEmail}<br></td>
							<td class="my">채팅 경고  </td>
							<td class="my2">${dto.crewChatWarning} 회</td>
						</tr>
					</table>
			     </div>
			     
		     	<div style="width: 100%; padding-top: 50px; clear: both;">
					<ul class="tabs">
						<li id="tab-0" data-tab="0"><a href="<%=cp%>/crew/update">회원정보 수정</a></li>
						<li id="tab-1" data-tab="1">승차권구매내역</li>
						<li id="tab-2" data-tab="2">프로모션구매내역</li>
					</ul>
				</div>
				
				<div id="crewreservation" style="display: none; width: 100%;">
					<table style="width:100%; margin-top: 50px; float: left;">
				 		<tr style="height:40px; font-weight:bold; border-top: 2px solid #44565B; background: #EAEAEA; text-align: center;">
				 			<td style="background: #44565B; color: white;" colspan="7">승차권 예약현황</td>
				 		</tr>
				 		<tr style="height:40px; font-weight:bold; background: #E1E8E7; text-align: center;">
				 			<td>승차일</td>
				 			<td>열차번호</td>
				 			<td>출발역</td>
				 			<td>도착역</td>
				 			<td>금액</td>
				 			<td>인원</td>
				 			<td>결제</td>
				 		</tr>
				 		<c:forEach items="${list}" var="dto">
					 		<tr class="listtt" style="text-align: center;" >
					 			<td>${dto.trDate}</td>
					 			<td>${dto.trCategory}&nbsp;${dto.trainCode}</td>
					 			<td>${dto.startCode}</td>
					 			<td>${dto.endCode}</td>
					 			<td>${dto.trPrice}</td>
					 			<td>${dto.count}</td>
					 			<td>결제완료</td>
					 		</tr>
				 		</c:forEach>
					</table>
				</div>
				<div id="crewreservation2" style="display: none; width: 100%;">
					<table  style="width:100%; margin-top: 50px;">
						<tr style="height:40px; font-weight:bold; border-top: 2px solid black; background: #EAEAEA; text-align: center;">
						 	<td style="background: #44565B; color: white;" colspan="5">프로모션 예약현황</td>
						</tr>
						<tr style="height:40px; font-weight:bold; background: #E1E8E7; text-align: center;">
							<td>예약번호</td>
							<td>프로모션 제목 </td>
							<td>구매자 </td>
							<td>예약날짜</td>
							<td>결제여부</td>
						</tr>
						<c:forEach var="dto" items="${list2}" varStatus="status">
							<tr style="text-align: center; height: 40px;">
								<td> ${dto.reservationNumber} </td>
								
								<c:if test="${dto.prpayment==1}">
									<td> <a href="<%=cp%>/crew/paymentSuccess?prSeq=${dto.prSeq}">${dto.pmTitle}</a></td>
								</c:if>
								
								<c:if test="${dto.prpayment!=1}">
									<td> <a href="<%=cp%>/crew/receipt?prSeq=${dto.prSeq}">${dto.pmTitle}</a></td>
								</c:if>
								
								<td> ${dto.crewName} </td>
								<td> ${dto.prReservationDate.substring(0, 10)} </td>
								<td> 
									<c:if test="${dto.prpayment==1}">
										결제완료
									</c:if> 
								</td>
							</tr>
						</c:forEach> 
					</table>
				</div>
			</div>
			<!-- /메인내용 -->
			</div>
		</div>
		<!-- Main -->
