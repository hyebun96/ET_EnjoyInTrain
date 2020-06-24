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
						<section class="sidebar">
							<header>
								<h2>Nulla luctus eleifend</h2>
							</header>
							<ul class="style1">
								<li><a href="#">Maecenas luctus lectus at sapien</a></li>
								<li><a href="#">Donec dictum metus in sapien</a></li>
								<li><a href="#">Integer gravida nibh quis urna</a></li>
								<li><a href="#">Etiam posuere augue sit amet nisl</a></li>
								<li><a href="#">Mauris vulputate dolor sit amet nibh</a></li>
							</ul>
						</section>
					</div>
				
					<div class="9u skel-cell-important">
					<form action="" name="reservationForm">
						<div>
							<table id="receipt_header">
								<tr>
									<td id="receipt_state1">홈 > 기차 여행 패키지 > 예약완료</td>
									<td id="receipt_logo"  rowspan="2"></td>
								</tr>
								<tr>
									<td id="receipt_title">예약완료</td>
								</tr>
								<tr>
									<td id="receipt_state2" colspan="2">① 예약하기 ＞ ② 예약완료 ＞</td>
								</tr>
							</table>
						</div>
					
						<div>
							<table id="receipt_info">
								<tr><td id="receipt_info_title" colspan="6">■ 예약완료</td></tr>
								<tr>
									<td id="receipt_info_question">상품명</td>
									<td colspan="5" id="receipt_info_answer">(레일티켓)한복입고 떠나는 경복궁＇북촌 한옥마을 투어(당일)</td>
								</tr>
								<tr>
									<td id="receipt_info_question">상품코드</td>
									<td id="receipt_info_answer">F20180612033</td>
									<td id="receipt_info_question">출발일자</td>
									<td id="receipt_info_answer">2020년 6월 28일</td>
									<td id="receipt_info_question">예약인원</td>
									<td id="receipt_info_answer">1명</td>
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
									<td id="receipt_report_question">상품평</td>
									<td id="receipt_report_answer">KTX 108열차</td>
									<td id="receipt_report_question">객실등급</td>
									<td id="receipt_report_answer">일반실</td>
								</tr>
								<tr>
									<td id="receipt_report_question">이용기간</td>
									<td id="receipt_report_answer" colspan="3">2020년 6월 28일 (일)</td>

								</tr>

								<tr>
									<td id="receipt_report_question">출발역</td>
									<td id="receipt_report_answer">부산(06:10)</td>
									<td id="receipt_report_question">도착역</td>
									<td id="receipt_report_answer">서울(09:03)</td>
								</tr>
								<tr>
									<td id="receipt_report_question">이용인원</td>
									<td id="receipt_report_answer" colspan="3">
										성인 1명 어린이 1명 경로 1명 장애인 1명 동반유아 1명
									</td>
								</tr>
								<tr>
									<td id="receipt_report_question">좌석선택</td>
									<td id="receipt_report_answer">E08</td>
								</tr>
								<tr>
									<td id="receipt_report_num" rowspan="3">2</td>
									<td id="receipt_report_group" rowspan="3">북촌 한복대여권</td>
									<td id="receipt_report_question">상품명</td>
									<td id="receipt_report_answer" colspan="3">전통한복 대여권(2시간30분)</td>
								</tr>
								<tr>
									<td id="receipt_report_question">이용기간</td>
									<td id="receipt_report_answer" colspan="3">2020년 6월 28일 (일) 한복대여권(2시간 30분)</td>
								</tr>
								<tr>
									<td id="receipt_report_question">이용인원</td>
									<td id="receipt_report_answer">1명</td>
									<td id="receipt_report_question">이용수량</td>
									<td id="receipt_report_answer">1개 (기준 1인/최대1인)</td>
								</tr>
								<tr>
									<td id="receipt_report_num" rowspan="5">3</td>
									<td id="receipt_report_group" rowspan="5">오는열차</td>
									<td id="receipt_report_question">상품평</td>
									<td id="receipt_report_answer">KTX 163열차</td>
									<td id="receipt_report_question">객실등급</td>
									<td id="receipt_report_answer">일반실</td>
								</tr>
								<tr>
									<td id="receipt_report_question">이용기간</td>
									<td id="receipt_report_answer" colspan="3">2020년 6월 28일 (일)</td>

								</tr>

								<tr>
									<td id="receipt_report_question">출발역</td>
									<td id="receipt_report_answer">서울(20:00)</td>
									<td id="receipt_report_question">도착역</td>
									<td id="receipt_report_answer">부산(22:37)</td>
								</tr>
								<tr>
									<td id="receipt_report_question">이용인원</td>
									<td id="receipt_report_answer" colspan="3">
										성인 1명 어린이 1명 경로 1명 장애인 1명 동반유아 1명
									</td>
								</tr>
								<tr>
									<td id="receipt_report_question">좌석선택</td>
									<td id="receipt_report_answer" colspan="3">E08</td>
								</tr>
							</table>
						</div>
						<div><table id="receipt_cost"><tr><td>총 결제금액 : 15,800<td></tr></table></div>
						<div>
							<div id="traveler_title">■ 예약자 및 여행자 정보입력</div>
							<table id="travler_info">
								<tr>
									<td id="traveler_title_sub" colspan="4">▷ 예약자 정보</td>
								</tr>
								<tr>
									<td id="travler_info_question">예약자 이름</td>
									<td id="travler_info_name">노현호</td>
									<td id="travler_info_question">이메일</td>
									<td id="travler_info_email">admin@admin.com</td>
								</tr>
								<tr>
									<td id="travler_info_question">휴대전화</td>
									<td colspan="3" id="travler_info_tel">010-0000-0000</td>
								</tr>
							</table>
							<div>
								<table id="resetpayment">
									<tr>
										<td id="resetpayment_title" colspan="3"> ▷ 결제/취소 기한 </td>
									</tr>
									<tr>
										<td id="resetpayment_question">결제기한일</td>
										<td id="resetpayment_answer">2020-06-23 15:37</td>
										<td id="resetpayment_condition">2020-06-23 15:37 까지 결제하지 않으면 자동 취소됩니다.</td>
									</tr>
								</table>
								<div id="travler_button">
									<button type="button" id="showStatement">예약명세서</button>
									<button type="button" id="showstatement">예약내역</button>
									<button onclick="reservation()">확인</button>
									<button>결제하기</button>
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
				<td id="statement_info_answer" valign="top">노현호 고객님</td>
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
				<td id="statement_info_answer" valign="top">2020/09/23</td>
			</tr>
			<tr>
				<td id="statement_info_question" valign="top">예약번호</td>
				<td id="statement_info_answer" valign="top">20200623803396</td>
			</tr>
			<tr>
				<td id="statement_info_question1" valign="top">상품평</td>
				<td id="statement_info_answer" valign="top">(목포,광주송정 출발)장항역/국립생태원 ECO-磁패키지 (열차+입장권), 당일</td>
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
				<td rowspan="3" id="statement_report_date2">2020/06/25</td>
				<td id="statement_report_productName2">KTX 504열차</td>
				<td id="statement_report_productCount2">1인</td>
			</tr>
			<tr>
				<td id="statement_report_productName2">[대전충남]ECO-磁 국립생태원 패키지</td>
				<td id="statement_report_productCount2">1인</td>
			</tr>
			<tr>
				<td id="statement_report_productName2">무궁화호 1557열차</td>
				<td id="statement_report_productCount2">1인</td>
			</tr>
			<tr>
				<td colspan="3" id="statement_report_cost1">총 결제금액</td>
			</tr>
			<tr>
				<td colspan="3" id="statement_report_cost2">18,000원</td>
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
	
	<div id="breakdow_dialog">
	<form action="showBreakdownForm">
		<table>
			<tr>
				<td id="statement_title" valign="top">예약명세서</td>
			</tr>
		</table>
	</form>
	</div>