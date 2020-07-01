<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/receipt.css" type="text/css">
<script type="text/javascript">

function ajaxJSON(url, type, query, fn) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			fn(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

$(function() {
	$("#showStatement").click(function() {
		$("form[name=showStatementForm]").each(function () {
			this.reset();
		});
		
		$("#statement_dialog").dialog({
			modal: true,
			height: 800,
			width: 700,
			title: '여행상품예약 명세서',
			clos : function (event, ui) {
			}
		})
		
	});
});

$(function() {
	$("#showstatement").click(function() {
		$("form[name=showstatementForm]").each(function () {
			this.reset();
		});
		
		$("#breakdow_dialog").dialog({
			modal: true,
			height: 600,
			width: 400,
			title: '여행상품 예약내역',
			clos : function (event, ui) {
			}
		})
		
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
					<form action="" name="reservationForm" >
						<div>
							<table id="receipt_header">
								<tr>
									<td id="receipt_state1">홈 > 기차 여행 패키지 > 예약하기 > 예약완료 ></td>
									<td id="receipt_logo"  rowspan="2"></td>
								</tr>
								<tr>
									<td id="receipt_title">예약완료</td>
								</tr>
								<tr>
									<td id="receipt_state2" colspan="2">①예약하기 ＞② 예약완료 ＞</td>
								</tr>
							</table>
						</div>
					
						<div>
							<table id="receipt_info">
								<tr><td id="receipt_info_title" colspan="6">■ 예약완료</td></tr>
								<tr>
									<td id="receipt_info_question">상품명</td>
									<td colspan="5" id="receipt_info_answer">${dto.pmTitle}</td>
								</tr>
								<tr>
									<td id="receipt_info_question">상품코드</td>
									<td id="receipt_info_answer">${dto.pmCode}</td>
									<td id="receipt_info_question">출발일자</td>
									<td id="receipt_info_answer">${dto.pmStartDate}</td>
									<td id="receipt_info_question">예약인원</td>
									<td id="receipt_info_answer">${dto.prPersonnel}</td>
								</tr>
							</table>
							
							<table id="receipt_report">
								<tr>
									<td id="receipt_report_num">순서</td>
									<td id="receipt_report_group">상품그룹</td>
									<td id="receipt_report_info" colspan="4">상품상세</td>
								</tr>
								<tr>
									<td id="receipt_report_num" rowspan="5">1</td>
									<td id="receipt_report_group" rowspan="5">가는열차</td>
									<td id="receipt_report_question">상품명</td>
									<td id="receipt_report_answer">${dto.startTrain}</td>
									<td id="receipt_report_question">객실등급</td>
									<td id="receipt_report_answer">${dto.roomGrade}</td>
								</tr>
								<tr>
									<td id="receipt_report_question">이용기간</td>
									<td id="receipt_report_answer" colspan="3">${dto.pmStartDate}</td>

								</tr>

								<tr>
									<td id="receipt_report_question">출발역</td>
									<td id="receipt_report_answer">${dto.startStation}(06:10)</td>
									<td id="receipt_report_question">도착역</td>
									<td id="receipt_report_answer">${dto.endStation}(09:03)</td>
								</tr>
								<tr>
									<td id="receipt_report_question">이용인원</td>
									<td id="receipt_report_answer" colspan="3">
										성인 ${dto.adult}명 어린이  ${dto.child}명 경로  ${dto.oldMan}명
									</td>
								</tr>
								<tr>
									<td id="receipt_report_question">좌석선택</td>
									<td id="receipt_report_answer">E08</td>
								</tr>
								<tr>
									<td id="receipt_report_num" rowspan="3">2</td>
									<td id="receipt_report_group" rowspan="3"> ${dto.product}</td>
									<td id="receipt_report_question">상품명</td>
									<td id="receipt_report_answer" colspan="3">${dto.productContent}</td>
								</tr>
								<tr>
									<td id="receipt_report_question">이용기간</td>
									<td id="receipt_report_answer" colspan="3">${dto.pmStartDate}</td>
								</tr>
								<tr>
									<td id="receipt_report_question">이용인원</td>
									<td id="receipt_report_answer">${dto.prPersonnel}명</td>
									<td id="receipt_report_question">이용수량</td>
									<td id="receipt_report_answer">${dto.productUserCount}개 </td>
								</tr>
								<tr>
									<td id="receipt_report_num" rowspan="5">3</td>
									<td id="receipt_report_group" rowspan="5">오는열차</td>
									<td id="receipt_report_question">상품명</td>
									<td id="receipt_report_answer">${dto.endTrain}</td>
									<td id="receipt_report_question">객실등급</td>
									<td id="receipt_report_answer">${dto.roomGrade1}</td>
								</tr>
								<tr>
									<td id="receipt_report_question">이용기간</td>
									<td id="receipt_report_answer" colspan="3">${dto.pmStartDate}</td>

								</tr>

								<tr>
									<td id="receipt_report_question">출발역</td>
									<td id="receipt_report_answer">${dto.endStation}(20:00)</td>
									<td id="receipt_report_question">도착역</td>
									<td id="receipt_report_answer">${dto.startStation}(22:37)</td>
								</tr>
								<tr>
									<td id="receipt_report_question">이용인원</td>
									<td id="receipt_report_answer" colspan="3">
										성인 ${dto.adult}명 어린이  ${dto.child}명 경로  ${dto.oldMan}명
									</td>
								</tr>
								<tr>
									<td id="receipt_report_question">좌석선택</td>
									<td id="receipt_report_answer" colspan="3">E08</td>
								</tr>
							</table>
						</div>
						<div><table id="receipt_cost"><tr><td>총 결제금액 : ${dto.pmPrice+dto.prAddPrice}원<td></tr></table></div>
						<div>
							<div id="traveler_title">■ 예약자 및 여행자 정보입력</div>
							<table id="travler_info">
								<tr>
									<td id="traveler_title_sub" colspan="4">▷ 예약자 정보</td>
								</tr>
								<tr>
									<td id="travler_info_question">예약자 이름</td>
									<td id="travler_info_name">${dto.crewName}</td>
									<td id="travler_info_question">이메일</td>
									<td id="travler_info_email">${dto.crewEmail}</td>
								</tr>
								<tr>
									<td id="travler_info_question">휴대전화</td>
									<td colspan="3" id="travler_info_tel">${dto.crewTel}</td>
								</tr>
							</table>
							<div>
								<table id="resetpayment">
									<tr>
										<td id="resetpayment_title" colspan="3"> ▷ 결제/취소 기한 </td>
									</tr>
									<tr>
										<td id="resetpayment_question">예약일일</td>
										<td id="resetpayment_answer">${dto.prReservationDate}</td>
										<td id="resetpayment_condition">2020-06-23 15:37 까지 결제하지 않으면 자동 취소됩니다.</td>
									</tr>
								</table>
								<div id="travler_button">
									<button type="button" id="showStatement">예약명세서</button>
									<button type="button" onclick="javascript:location.href='<%=cp%>/travel/main';">확인</button>
									<button type="button" onclick="javascript:location.href='<%=cp%>/booking/payment?prCode=${dto.prCode}';">결제하기</button>
								</div>
							</div>
						</div>	
					</form>
				</div>
					
				</div>
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->
	<div id="statement_dialog">
	<form action="showStatementForm">
		<table id="statement_table">
			<tr>
				<td id="statement_info_question" valign="top">To</td>
				<td id="statement_info_answer" valign="top">${dto.crewName} 고객님</td>
			</tr>
			<tr>
				<td id="statement_info_question" valign="top">From</td>
				<td id="statement_info_answer" valign="top">기차여행 홈페이지</td>
			</tr>
			<tr>
				<td id="statement_info_question" valign="top">콜센터 TEL</td>
				<td id="statement_info_answer" valign="top">0615254422</td>
			</tr>
			<tr>
				<td id="statement_info_question" valign="top">발행일자</td>
				<td id="statement_info_answer" valign="top">${dto.prReservationDate}</td>
			</tr>
			<tr>
				<td id="statement_info_question" valign="top">예약번호</td>
				<td id="statement_info_answer" valign="top">20200623803396</td>
			</tr>
			<tr>
				<td id="statement_info_question1" valign="top">상품평</td>
				<td id="statement_info_answer" valign="top">${dto.pmTitle}</td>
			</tr>
		</table>
		<table id="statement_report">
			<tr>
				<td id="statement_report_title">■ 예약내역</td>
			</tr>
			<tr>
				<td id="statement_report_date1">출발일자</td>
				<td id="statement_report_productName1">상품명</td>
				<td id="statement_report_productCount1">상품수량</td>
			</tr>
			<tr>
				<td rowspan="3" id="statement_report_date2">${dto.pmStartDate}</td>
				<td id="statement_report_productName2">${dto.startTrain}</td>
				<td id="statement_report_productCount2">${dto.prPersonnel}인</td>
			</tr>
			<tr>
				<td id="statement_report_productName2">${dto.product}</td>
				<td id="statement_report_productCount2">${dto.productUserCount}인</td>
			</tr>
			<tr>
				<td id="statement_report_productName2">${dto.endTrain}</td>
				<td id="statement_report_productCount2">${dto.prPersonnel}인</td>
			</tr>
			<tr>
				<td colspan="3" id="statement_report_cost1">총 결제금액</td>
			</tr>
			<tr>
				<td colspan="3" id="statement_report_cost2">${dto.pmPrice+dto.prAddPrice}원</td>
			</tr>
		</table>
		<table id="statement_notice">
			<tr>
				<td id="statement_notice_title">■ 예약내역</td>
			</tr>
			<tr>
				<td id="statement_notice_date1">결제기한</td>
				<td id="statement_notice_date2">2020-06-23 16:52(이후 자동 취소 됩니다.)</td>
			</tr>
		</table>
		<div>● 최소인원 미달, 천재지변 등에 의한 행사 취소 시에는 전액 환불됩니다.</div>
		<div>● 출발시간 내 미 도착 시 당일 취소로 간주합니다.</div>
	</form>
	</div>