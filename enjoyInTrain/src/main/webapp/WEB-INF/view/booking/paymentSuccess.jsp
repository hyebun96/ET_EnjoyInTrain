<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/booking.css" type="text/css">
<script type="text/javascript">
$(function() {
	$("#showReservationCancle").click(function() {
		$("form[name=showReservationCancleForm]").each(function () {
			this.reset();
		});
		
		$("#showReservationCancle_dialog").dialog({
			modal: true,
			height: 400,
			width: 600,
			title: '여행상품 예약 취소',
			close: function (event, ui) {
			}
		})
		
	});
});


function reservationCancle() {
<c:if test="${sessionScope.crew.crewId==startDto.crewId}">
	var q = "prSeq=${startDto.prSeq}";
	var url = "<%=cp%>/booking/delete?"+q;
	if(confirm("예약을 취소 하시겠습니까?")){
		location.href=url;
	}
</c:if>
<c:if test="${sessionScope.crew.crewId!='admin' && sessionScope.crew.crewId!=startDto.crewId}">
alert("예약을 취소할 수  없습니다.");
</c:if>
}

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

$(function() {
	$("#checkedTicket").click(function() {
		$("#checkedTicket_dialog").dialog({
			modal: true,
			height: 800,
			width: 1250,
			title: '승차권 확인',
			close: function (event, ui) {
			}
		})
		
	});
});
</script>
	<!-- Main -->
		<div id="page">
				
			<!-- Main -->
			<div id="main" class="container">
			<div id="payment_top">
				<div class="payment_main">
						<div style="width: 100%">
							<table class="payment_header">
								<tr>
									<td class="payment_state1">홈 > 기차 여행 패키지 > 예약하기 > 예약완료 > 결제 > 결제완료</td>
									<td class="payment_logo"  rowspan="2"></td>
								</tr>
								<tr>
									<td class="payment_title">결제 완료</td>
								</tr>
								<tr>
									<td class="payment_state2" colspan="2">① 예약하기 ＞ ② 예약완료 ＞ ③ 결제 ＞ ④ 결제완료</td>
								</tr>
							</table>
							<table class="payment_appear">
								<tr>
									<td> 예약번호 
										<span class="reservationNumber" style="color: blanchedalmond">${startDto.reservationNumber}</span>
										<span class="paymentstate">결제내역</span> 입니다.
									</td>
								</tr>
							</table>
						</div>
						<div style="width: 100%">
							<table class="payment_report">
								<tr><td class="payment_report_title" colspan="6">■ 결제 내역</td></tr>
								<tr>
									<td class="payment_report_num1">예약번호</td>
									<td class="payment_report_category1">분류</td>
									<td class="payment_report_name1">상품명</td>
									<td class="payment_report_pay1">요금</td>
								</tr>
								<tr>
									<td class="payment_report_num2">${startDto.reservationNumber}</td>
									<td class="payment_report_category2">패키지상품</td>
									<td class="payment_report_name2">${startDto.pmTitle}</td>
									<td class="payment_report_pay2">${startDto.pmPrice}원</td>
									<tr>
										<td class="payment_report_num2"></td>
										<td class="payment_report_category2">가는 기차</td>
										<td class="payment_report_name2">
											${start.trainName} - ${startDto.trainCode}
											(${startDto.startStation} - > ${startDto.endStation})
										</td>
										<td class="payment_report_pay2"></td>
									<tr>
									<tr>
										<td class="payment_report_num2"></td>
										<td class="payment_report_category2">객실 등급</td>
										<td class="payment_report_name2">${startDto.roomGrade}</td>
										<td class="payment_report_pay2">${startDto.prAddPrice}원</td>
									<tr>
									<tr>
										<td class="payment_report_num2"></td>
										<td class="payment_report_category2">프로모션 포함 상품</td>
										<td class="payment_report_name2">${startDto.product}(${startDto.productContent})</td>
										<td class="payment_report_pay2"></td>
									</tr>
									<tr>
										<td class="payment_report_num2"></td>
										<td class="payment_report_category2">오는 기차</td>
										<td class="payment_report_name2">
											${end.trainName} - ${endDto.trainCode}
											(${endDto.startStation} - > ${endDto.endStation})
										</td>
										<td class="payment_report_pay2"></td>
									<tr>
									<tr>
										<td class="payment_report_num2"></td>
										<td class="payment_report_category2">객실 등급</td>
										<td class="payment_report_name2">${endDto.roomGrade}</td>
										<td class="payment_report_pay2">${endDto.prAddPrice}원</td>
									<tr>
								</tr>
								<tr>
									<td class="payment_report_cost1" colspan="3">총비용</td>
									<td class="payment_report_cost2">${startDto.pmPrice + startDto.prAddPrice + endDto.prAddPrice}원</td>
								</tr>
							</table>
							<table class="payment_info">
								<tr><td class="payment_info_title" colspan="6">■ 결제자 정보</td></tr>
								<tr>
									<td class="payment_info_question">아이디</td>
									<td colspan="5" class="payment_info_answer">${startDto.crewId}</td>
								</tr>
								<tr>
									<td class="payment_info_question">이름</td>
									<td colspan="5" class="payment_info_answer">${startDto.crewName}</td>
								</tr>
								<tr>
									<td class="payment_info_question">전화 번호</td>
									<td colspan="5" class="payment_info_answer">${startDto.crewTel}</td>
								</tr>
								<tr>
									<td class="payment_info_question">이메일</td>
									<td colspan="5" class="payment_info_answer">${startDto.crewEmail}</td>
								</tr>
								<tr>
									<td class="payment_info_question">생년월일</td>
									<td colspan="5" class="payment_info_answer">${startDto.crewBirth}</td>
								</tr>
							</table>
							<div class="payment_button">
							<button type="button" id="checkedTicket">승차권 확인</button>
							<button type="button" id="showReservationCancle">예약취소 ></button>
							<button type="button" onclick="javascript:location.href='<%=cp%>/travel/main';">확인 ＞</button>
							</div>
						</div>
			
					</div>
				</div>
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->
	
	<div id="showReservationCancle_dialog">
		<form name="showReservationCancleForm" method="post">
			<table class="reservationCancle_table">
				<tr>
					<td class="reservationCancle_tab">예약번호</td>
					<td class="reservationCancle_content">${startDto.reservationNumber}</td>
					<td class="reservationCancle_price"></td>
				</tr>
				<tr>
					<td class="reservationCancle_tab">상품분류</td>
					<td class="reservationCancle_content">상품명</td>
					<td class="reservationCancle_price">가격</td>
				</tr>
				<tr>
					<td class="reservationCancle_tab">프로모션</td>
					<td class="reservationCancle_content">${startDto.pmTitle}</td>
					<td class="reservationCancle_price">${startDto.pmPrice}</td>
				</tr>
				<tr>
					<td class="reservationCancle_tab">가는기차</td>
					<td class="reservationCancle_content">${start.trainName}-${startDto.trainCode} (${startDto.roomGrade})</td>
					<td class="reservationCancle_price">${startDto.prAddPrice}</td>
				</tr>
				<tr>
					<td class="reservationCancle_tab">오는기차</td>
					<td class="reservationCancle_content">${end.trainName}-${endDto.trainCode} (${endDto.roomGrade})</td>
					<td class="reservationCancle_price">${endDto.prAddPrice}</td>
				</tr>
				<tr class="reservationCancle_button">
					<td colspan="3">
						<button type='button' style="background:   #4e0c6f; color: white;" onclick='reservationCancle();'>예약취소</button>
						<button type="button" style="background:   #4e0c6f; color: white;" onclick="javascript:location.href='<%=cp%>/booking/paymentSuccess?prSeq=7'">뒤로가기</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div id="checkedTicket_dialog">
		<div class="ticket1">
			<div class="ticket2">
				<div class="ticket3">
					<table>
						<tr>
							<td>
								&nbsp;&nbsp;이용안내<br>
								&nbsp;&nbsp;1.&nbsp; 홈티켓(Home-Ticket)은 승차권에 표 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;시된
								승차자가 이용하여야 하며, 도착역 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;을 벗어날때까지 소지하셔야합니다.
								&nbsp;&nbsp;2.&nbsp;직원이 본인확인을 요구할 경우 신분증 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;을제시하셔야 합니다.
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
							<td style="width:100px; ">승차일</td>
							<td colspan="2" style="font-size: 20px; font-weight: bold; vertical-align: middle">${startDto.pmStartDate}<br><br></td>
						</tr>
						<tr>
							<td colspan="3" style="font-size: 30px;">${startDto.startStation}&nbsp;▶&nbsp;${startDto.endStation}<br><br><br></td> 
						</tr>
						<tr>
							<td colspan="3" style="font-size: 30px;">${start.startTime}&nbsp;▶&nbsp;${start.endTime}<br><br><br></td>
						</tr>
						<tr>
							<td style="width: 230px;">${start.trainName} - ${startDto.trainCode}열차(${startDto.roomGrade})</td>
							<td style="border: 1px soild #cccccc; width: 240px; font-weight: bold;">${startDto.roomNum}호차 ${startDto.prTrainSeat}석</td>
						</tr>
						<tr>
							<td colspan="2">승객유형&nbsp;&nbsp;성인 : ${startDto.adult}명 어린이 : ${startDto.child}명 경로 : ${startDto.oldMan}명</td>
						</tr>
						<tr class="back">
							<td  style="width:300px;">운임요금 &nbsp;${startDto.prAddPrice}원</td>
							<td>영수금액&nbsp;${startDto.prAddPrice}원</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="ticket1">
			<div class="ticket2">
				<div class="ticket3">
					<table>
						<tr>
							<td>
								&nbsp;&nbsp;이용안내<br>
								&nbsp;&nbsp;1.&nbsp; 홈티켓(Home-Ticket)은 승차권에 표 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;시된
								승차자가 이용하여야 하며, 도착역 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;을 벗어날때까지 소지하셔야합니다.
								&nbsp;&nbsp;2.&nbsp;직원이 본인확인을 요구할 경우 신분증 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;을제시하셔야 합니다.
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
							<td style="width:100px; ">승차일</td>
							<td colspan="2" style="font-size: 20px; font-weight: bold; vertical-align: middle">${endDto.pmStartDate}<br><br></td>
						</tr>
						<tr>
							<td colspan="3" style="font-size: 30px;">${endDto.startStation}&nbsp;▶&nbsp;${endDto.endStation}<br><br><br></td> 
						</tr>
						<tr>
							<td colspan="3" style="font-size: 30px;">${end.startTime}&nbsp;▶&nbsp;${end.endTime}<br><br><br></td>
						</tr>
						<tr>
							<td style="width: 230px;">${end.trainName} - ${endDto.trainCode}열차(${endDto.roomGrade})</td>
							<td style="border: 1px soild #cccccc; width: 240px; font-weight: bold;">${endDto.roomNum}호차 ${endDto.prTrainSeat}석</td>
						</tr>
						<tr>
							<td colspan="2">승객유형&nbsp;&nbsp;성인 : ${endDto.adult}명 어린이 : ${endDto.child}명 경로 : ${endDto.oldMan}명</td>
						</tr>
						<tr class="back">
							<td  style="width:300px;">운임요금 &nbsp;${endDto.prAddPrice}원</td>
							<td>영수금액&nbsp;${endDto.prAddPrice}원</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<table class="table1">
		 	<tr class="tr1"><td class="col2">* 승차권 인쇄버튼을 클릭하여 승차권을 인쇄하십시오.<td></tr>
		</table>
		<div style="width: 1200px; text-align: right;">
			<button onclick="info_print()" style="background: #82909D; color: white; border: none; font-weight: bold; height: 30px;">승차권 인쇄</button>
		</div>
		<div class="ticket1">
			<div class="ticket2">
				<div class="ticket3">
					<table>
						<tr>
							<td>
								<img src="<%=cp%>/uploads/travel/${saveFileName}" style="width: 320px; height: 280px;">
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
							<td style="width:100px; ">이용일</td>
							<td colspan="2" style="font-size: 20px; font-weight: bold; vertical-align: middle">${startDto.pmStartDate}<br><br></td>
						</tr>
						<tr>
							<td colspan="3" style="font-size: 30px; height: 40px; line-height: 40px;">${startDto.product}<br><br><br></td> 
						</tr>
						<tr>
							<td colspan="3" style="font-size: 20px; height: 30px; line-height: 30px;">${startDto.productContent}<br><br><br></td>
						</tr>
						<tr class="back">
							<td colspan="2">이용인원&nbsp;&nbsp; ${startDto.productUserCount} 명</td>
						</tr>
						
					</table>
				</div>
			</div>
		</div>
	</div>
		
	