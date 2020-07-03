<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/paymentSuccess.css" type="text/css">
<script type="text/javascript">
$(function() {
	$("#showReservationCancle").click(function() {
		$("form[name=showReservationCancleForm]").each(function () {
			this.reset();
		});
		
		$("#showReservationCancle_dialog").dialog({
			modal: true,
			height: 300,
			width: 400,
			title: '여행상품 예약 취소',
			clos : function (event, ui) {
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

					<div class="3u">
						<section class="sidebar">
							<header>
								<h2>Feugiat Tempus</h2>
							</header>
							<ul class="style1">
								<li><a href="#">Maecenas luctus lectus at sapien</a></li>
								<li><a href="#">Etiam rhoncus volutpat erat</a></li>
								<li><a href="#">Donec dictum metus in sapien</a></li>
								<li><a href="#">Nulla luctus eleifend purus</a></li>
								<li><a href="#">Maecenas luctus lectus at sapien</a></li>
							</ul>
						</section>
					</div>
				
					<div class="9u skel-cell-important">
						<div>
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
										<span class="reservationNumber">${startDto.reservationNumber}</span>
										<span class="paymentstate">결제내역</span> 입니다.
									</td>
								</tr>
							</table>
						</div>
						<div>
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
											(${start.startStation} - > ${start.endStation})
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
										<td class="payment_report_category2">오는 기차</td>
										<td class="payment_report_name2">
											${end.trainName} - ${endDto.trainCode}
											(${end.startStation} - > ${end.endStation})
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
			<table>
				<tr>
					<td>예약번호</td>
					<td>${startDto.reservationNumber}</td>
				</tr>
				<tr>
					<td>상품분류</td>
					<td>상품명</td>
					<td>가격</td>
				</tr>
				<tr>
					<td>프로모션</td>
					<td>${startDto.pmTitle}</td>
					<td>${startDto.pmPrice}</td>
				</tr>
				<tr>
					<td>가는기차</td>
					<td>${start.trainName}-${startDto.trainCode} (${startDto.roomGrade})</td>
					<td>${startDto.prAddPrice}</td>
				</tr>
				<tr>
					<td>오는기차</td>
					<td>${end.trainName}-${endDto.trainCode} (${endDto.roomGrade})</td>
					<td>${endDto.prAddPrice}</td>
				</tr>
				<tr>
					<td>
						<button type='button' onclick='reservationCancle();'>예약취소</button>
						<button type="button" onclick="javascript:location.href='<%=cp%>/booking/paymentSuccess?prSeq=7'">뒤로가기</button>
					</td>
				<tr>
			</table>
		</form>
	</div>
