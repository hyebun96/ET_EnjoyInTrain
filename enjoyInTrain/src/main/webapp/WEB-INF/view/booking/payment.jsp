<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/payment.css" type="text/css">
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
						<div>
							<table id="payment_header">
								<tr>
									<td id="payment_state1">홈 > 여행상품 > 여행상품 > 여행상품 결제</td>
									<td id="payment_logo"  rowspan="2"></td>
								</tr>
								<tr>
									<td id="payment_title">여행상품 결제</td>
								</tr>
								<tr>
									<td id="payment_state2" colspan="2">① 예약하기 ＞ ② 예약완료 ＞ ③ 결제 ＞</td>
								</tr>
							</table>
							<table id="payment_appear">
								<tr>
									<td> 예약번호 
										<span id="reservationNumber">20200623803272</span> 
										<span id="paymentstate">예약내역</span> 입니다.
									</td>
								</tr>
							</table>
						</div>
						<div>
							<table id="payment_report">
								<tr><td id="payment_report_title" colspan="6">■ 예약 내역</td></tr>
								<tr>
									<td id="payment_report_num1">예약번호</td>
									<td id="payment_report_category1">분류</td>
									<td id="payment_report_name1">상품명</td>
									<td id="payment_report_pay1">요금</td>
								</tr>
								<tr>
									<td id="payment_report_num2">20200623803272</td>
									<td id="payment_report_category2">패키지상품</td>
									<td id="payment_report_name2">(목포,광주송정 출발)장항역/국립생태원 ECO-螟패키지 (열차+입장권), 당일</td>
									<td id="payment_report_pay2">18,000원</td>
								</tr>
								<tr>
									<td id="payment_report_cost1" colspan="3">총비용</td>
									<td id="payment_report_cost2">18,000원</td>
								</tr>
							</table>
							<table id="payment_info">
								<tr><td id="payment_info_title" colspan="6">■ 결제정보</td></tr>
								<tr>
									<td id="payment_info_question">결제금액</td>
									<td colspan="5" id="payment_info_answer">18,000원</td>
								</tr>
								<tr>
									<td id="payment_info_question">카드선택</td>
									<td colspan="5" id="payment_info_answer">
										<input type="radio" name="cardGroup"> 개인카드
										<input type="radio" name="cardGroup"> 법인카드
									</td>
								</tr>
								<tr>
									<td id="payment_info_question">카드번호</td>
									<td colspan="5" id="payment_info_cardNum">
										<input type="text" name="cardNum1"> -
										<input type="text" name="cardNum2"> -
										<input type="text" name="cardNum3"> -
										<input type="text" name="cardNum4">
									</td>
								</tr>
								<tr>
									<td id="payment_info_question">유효기간</td>
									<td colspan="5" id="payment_info_answer">
										<select name="cardMonth">
											<option value="1">1월</option>
											<option value="2">2월</option>
											<option value="3">3월</option>
											<option value="4">4월</option>
											<option value="5">5월</option>
											<option value="6">6월</option>
											<option value="7">7월</option>
											<option value="8">8월</option>
											<option value="9">9월</option>
											<option value="10">10월</option>
											<option value="11">11월</option>
											<option value="12">12월</option>
										</select> 월
										<select>
											<option value="2020">2020</option>
											<option value="2021">2021</option>
											<option value="2022">2022</option>
											<option value="2023">2023</option>
											<option value="2024">2024</option>
										</select>
									</td>
								</tr>
								<tr>
									<td id="payment_info_question">할부개월</td>
									<td colspan="5" id="payment_info_answer">
										<select>
											<option value="1">일시불</option>
											<option value="2">2개월</option>
											<option value="3">3개월</option>
											<option value="4">4개월</option>
											<option value="5">5개월</option>
										</select>
									</td>
								</tr>
								<tr>
									<td id="payment_info_question">비밀번호</td>
									<td colspan="5" id="payment_info_pwd">
										<input type="password"> **
									</td>
								</tr>
								<tr>
									<td id="payment_info_question">인증번호</td>
									<td colspan="5" id="payment_info_num">
										<input type="text">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (주민등록번호 앞 6자리 또는 무기명식 법인카드는 사업자등록번호 10자리)
									</td>
								</tr>
							</table>
							<div id="payment_button"><button>결제하기 ＞</button></div>
						</div>
					</div>
					
				</div>
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->