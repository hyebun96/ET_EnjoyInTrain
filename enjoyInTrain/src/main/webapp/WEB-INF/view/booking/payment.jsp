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
					</div>
				
					<div class="9u skel-cell-important">
						<div>
							<table id="payment_header">
								<tr>
									<td id="payment_state1">홈 > 기차 여행 패키지 > 예약하기 > 예약완료 > 결제</td>
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
										<span id="reservationNumber">${dto.reservationNumber}</span>
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
									<td id="payment_report_num2">${dto.reservationNumber}</td>
									<td id="payment_report_category2">패키지상품</td>
									<td id="payment_report_name2">${dto.pmTitle}</td>
									<td id="payment_report_pay2">${dto.pmPrice}원</td>
									<c:if test="${dto.prAddPrice!=0}">
										<tr>
											<td id="payment_report_num2"></td>
											<td id="payment_report_category2">패키지상품</td>
											<td id="payment_report_name2">${dto.pmTitle}</td>
											<td id="payment_report_pay2">${dto.pmPrice}원</td>
										<tr>
									</c:if>
								</tr>
								<tr>
									<td id="payment_report_cost1" colspan="3">총비용</td>
									<td id="payment_report_cost2">${dto.pmPrice + dto.prAddPrice}원</td>
								</tr>
							</table>
							<table id="payment_info">
								<tr><td id="payment_info_title" colspan="6">■ 결제정보</td></tr>
								<tr>
									<td id="payment_info_question">결제금액</td>
									<td colspan="5" id="payment_info_answer">${dto.pmPrice + dto.prAddPrice}원</td>
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
										<select>
											<c:forEach var="b" begin="2020" end="2030">
												<option value="${b}">${b}</option>
											</c:forEach>
										</select> 년
										<select name="cardMonth">
											<c:forEach var="a" begin="1" end="12" >
												<option value="${a}">${a}</option>
											</c:forEach>
										</select> 월
										
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