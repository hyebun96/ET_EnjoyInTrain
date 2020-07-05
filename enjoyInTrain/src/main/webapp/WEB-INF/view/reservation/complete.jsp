<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<style>

.homepage #page {
    padding: 2em 0em;
    padding-bottom: 500px;
}

.table1{
	width:100%; 
	text-align: left;
	border: 1px solid #BDBDBD;
}

.tr1{
	height:45px;
	border-bottom:  1px solid #BDBDBD;
}

.col{
	font-weight:10px;
	width:180px; 
	text-align: center;
	border: 1px solid #BDBDBD;
}

.col2{
	padding-left: 20px;
}

.ticket1{
	margin-top: 50px;
	width: 1200px;
	height: 380px;
	padding:0 120px 0 170px;
	border: 1px solid #BDBDBD;
}
.ticket2{
	margin: 10px 100px 10px 60px;
	width: 850px;
	height: 360px;
	border: 1px solid #BDBDBD;
}

.ticket3{
	width: 347px;
	margin: 10px 10px 10px 13px;
	float: left;
	padding: 10px;
	height: 340px;
	border: 1px solid #BDBDBD;
}

.ticket4{
	width: 465px;
	margin: 10px 10px 10px 0px;
	float: left;
	height: 340px;
	border: 1px solid #BDBDBD;
}

.ticket4 tr td{
	width: 465px;
	height: 40px;
}

.back{
	background: #E3CEF6;
}

</style>

<script type="text/javascript">
function info_print() {
	var initBody = document.body.innerHTML;
	
	window.onbeforeprint = function () {
	document.body.innerHTML = document.getElementById("test").innerHTML;
	}
	
	window.onafterprint = function () {
	document.body.innerHTML = initBody;
	}
	
	window.print();
}

</script>
	<!-- Main -->
		<div id="page" >
			<!-- Main -->
			<div id="main" class="container" style="margin-top: 0; padding-top: 0;">
				<div class="row">
					<div class="9u skel-cell-important">
						<section>
							<header>
								<div style="width:1200px; text-align:center; height:150px; line-height:150px; border: 1px solid #BDBDBD">
									<p style="font-weight:bold; font-size: 20px;"><i class="fas fa-check-circle" style=" color: #6f047f;"></i>&nbsp;승차권 발급이 완료되었습니다.</p>
								</div>
							</header>
						</section>
					
						<div style="width: 1200px; text-align: center;">

						 	<table class="table1">
						 		<tr class="tr1" style="border-top: 2px solid #BDBDBD;">
						 			<td class="col"><b>결제금액</b></td>
						 			<td class="col2">${map.totalPay} 원</td>
						 		</tr>
						 	</table>
						 	
						 	<table class="table1">
						 		<tr class="tr1" style="border-top: 2px solid #BDBDBD;">
						 			<td class="col"><b>승차일자</b></td>
						 			<td class="col2">${map.trDate}</td>
						 		</tr>
						 		<tr class="tr1">
						 			<td class="col"><b>열차종류</b></td>
						 			<td class="col2">${map.trainName}</td>
						 		</tr>
						 		<tr class="tr1">
						 			<td class="col"><b>열차번호</b></td>
						 			<td class="col2">${map.trainCode}</td>
						 		</tr>
						 		<tr class="tr1">
						 			<td class="col"><b>인원</b></td>
						 			<td class="col2">${map.total} 명</td>
						 		</tr>
						 	</table>
						 	<table class="table1">
						 		<tr class="tr1"><td class="col2">* 승차권 인쇄버튼을 클릭하여 승차권을 인쇄하십시오.<td></tr>
						 	</table>
						</div>
						
						<div style="width: 1200px; text-align: center;">
							<button onclick="javascript:location.href='<%=cp%>/main';" style="margin:20px; width:160px; font-weight:bold; font-size:15px; border-radius:5px; height:40px; background: #6f047f; color: white; border: none;">메인으로 가기</button>
							<button onclick="javascript:location.href='<%=cp%>/main';" style="margin:20px; width:160px; font-weight:bold; font-size:15px; border-radius:5px; height:40px; background: #6f047f; color: white; border: none;">발권조회</button>
							<button onclick="info_print()" style="margin:20px; width:160px; font-weight:bold; font-size:15px; border-radius:5px; height:40px; background: #6f047f; color: white; border: none;">승차권 인쇄</button>
						</div>
						<div class="ticket1">
							<div class="ticket2">
								<div class="ticket3">
									<table>
										<tr>
											<td>
												&nbsp;&nbsp;이용안내<br>
												&nbsp;&nbsp;1.&nbsp; 홈티켓(Home-Ticket)은 승차권에 표시된 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												승차자가 이용하여야 하며, 도착역을 벗어날때 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;까지 소지하셔야합니다.<br>
												&nbsp;&nbsp;2.&nbsp;직원이 본인확인을 요구할 경우 신분증을 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;제시하셔야 합니다.
												<br><br>
											</td>
										</tr>
										<tr>
											<td align="center">
												<img src="<%=cp%>/resource/images/qrCodeReservation.jpg" width="100" height="100">
												<br>
											</td>
										</tr>	
										<tr>
											<td style="background: #dddddd; height: 35px;">
												&nbsp;&nbsp;문의 전화 : 1234-5678
											</td>
										</tr>
									</table>
								</div>
								<div class="ticket4">
									<table>
										<tr>
											<td>승차일&nbsp;${map.trDate}</td>
										</tr>
										<tr>
											<td>${map.startCode}&nbsp;▶&nbsp;${map.endCode}</td> 
										</tr>
										<tr>
											<td>${map.stTime}&nbsp;▶&nbsp;${map.endTime}</td>
										</tr>
										<tr>
											<td>${map.trainName}</td>
											<td>${map.trainCode}열차(${map.roomGrade})</td> 
											<td style="border: 1px soild #cccccc; width: 100px; height: 100px;">${map.roomNum}호차 ${map.seatNum}석</td>
										</tr>
										<tr>
											<td>승객유형</td>
											<td>${map.seatType}</td>
										</tr>
										<tr class="back">
											<td>운임요금 &nbsp;${map.seatPay}원</td>
											<td>할인금액 &nbsp; 0원</td>
											<td colspan="2">영수금액&nbsp;${map.totalPay}원</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			<!-- Main -->
		</div>
	<!-- /Main -->
</div>