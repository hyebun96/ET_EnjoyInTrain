<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String cp=request.getContextPath();
%>
<style type="text/css">
.homepage #main{
   margin-top: 0em;
    padding-top: 0em;
}
</style>
<script type="text/javascript">
function embracing() {
	var f = document.reservationForm;
	
	f.action="<%=cp%>/booking/${mode}";
	
	f.submit();
    return true;
}

function reservation() {
	var f = document.resrvationForm
	
	f.action="<%=cp%>/booking/${mode}";
	
	f.submit();
    return true;
}

function changeEmail() {
    var f = document.reservationForm;
	    
    var str = f.selectEmail.value;
    if(str!="direct") {
        f.email2.value=str; 
        f.email2.readOnly = true;
        f.email1.focus(); 
    }
    else {
        f.email2.value="";
        f.email2.readOnly = false;
        f.email1.focus();
    }
}
</script>
<link rel="stylesheet" href="<%=cp%>/resource/css/reservation.css" type="text/css">
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
							<table id="reservation_header">
								<tr>
									<td id="reservation_state1">홈 > 예약하기</td>
									<td id="reservation_logo"  rowspan="2"></td>
								</tr>
								<tr>
									<td id="reservation_title">예약하기</td>
								</tr>
								<tr>
									<td id="reservation_state2" colspan="2">① 예약하기 ＞ ② 예약완료 ＞</td>
								</tr>
							</table>
						</div>
					
						<div>
							<table id="reservation_info">
								<tr><td id="reservation_info_title" colspan="6">■ 선택상품정보</td></tr>
								<tr>
									<td id="reservation_info_question">상품명</td>
									<td colspan="5" id="reservation_info_answer">${startDto.pmTitle}</td>
								</tr>
								<tr>
									<td id="reservation_info_question">상품코드</td>
									<td id="reservation_info_answer">${startDto.pmCode}</td>
									<td id="reservation_info_question">출발일자</td>
									<td id="reservation_info_answer">${startDto.pmStartDate}</td>
									<td id="reservation_info_question">예약인원</td>
									<td id="reservation_info_answer">${prPersonal}</td>
								</tr>
							</table>
							
							<table id="reservation_report">
								<tr>
									<td id="reservation_report_num">순서</td>
									<td id="reservation_report_group">상품그룹</td>
									<td id="reservation_report_info" colspan="4">상품상세</td>
								</tr>
								<tr>
									<td id="reservation_report_num" rowspan="5">1</td>
									<td id="reservation_report_group" rowspan="5">가는열차</td>
									<td id="reservation_report_question">상품명</td>
									<td id="reservation_report_answer">${startDto.trainCode}</td>
									<td id="reservation_report_question">객실등급</td>
									<td id="reservation_report_answer">
										<select>
											<option value="general">일반실</option>
											<option value="special">특실</option>
										</select>
										재고 : 309
									</td>
								</tr>
								<tr>
									<td id="reservation_report_question">이용기간</td>
									<td id="reservation_report_answer" colspan="3">${startDto.pmStartDate}</td>

								</tr>

								<tr>
									<td id="reservation_report_question">출발역</td>
									<td id="reservation_report_answer">${startDto.startStation}(06:10)</td>
									<td id="reservation_report_question">도착역</td>
									<td id="reservation_report_answer">${startDto.endStation}(09:03)</td>
								</tr>
								<tr>
									<td id="reservation_report_question">이용인원</td>
									<td id="reservation_report_answer" colspan="3">
										<select>
										   <c:forEach var="n" begin="0" end="${prPersonal}">
										   		<option value="${n}">성인${n}명</option>
										   </c:forEach>
										</select>
										<select>
											 <c:forEach var="n" begin="0" end="${prPersonal}">
										   		<option value="${n}">어린이${n}명</option>
										   </c:forEach>
										</select>
										<select>
											 <c:forEach var="n" begin="0" end="${prPersonal}">
										   		<option value="${n}">경로${n}명</option>
										   </c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<td id="reservation_report_question">좌석선택</td>
									<td id="reservation_report_answer"><button>좌석선택</button></td>
								</tr>
								<tr>
									<td id="reservation_report_num" rowspan="3">2</td>
									<td id="reservation_report_group" rowspan="3">${startDto.product}</td>
									<td id="reservation_report_question">상품명</td>
									<td id="reservation_report_answer" colspan="3">${startDto.product}</td>
								</tr>
								<tr>
									<td id="reservation_report_question">이용기간</td>
									<td id="reservation_report_answer" colspan="3">${startDto.product}</td>
								</tr>
								<tr>
									<td id="reservation_report_question">이용인원</td>
									<td id="reservation_report_answer">
										<select>
											 <c:forEach var="n" begin="0" end="${prPersonal}">
										   		<option value="${n}">${n}명</option>
										   </c:forEach>
										</select>
									</td>
									<td id="reservation_report_question">이용수량</td>
									<td id="reservation_report_answer">
										<select>
											<c:forEach var="n" begin="0" end="${prPersonal}">
										   		<option value="${n}">${n}명</option>
										   </c:forEach>
										</select>
										(기준 1인/최대 ${prPersonal} 인)
									</td>
								</tr>
								<tr>
									<td id="reservation_report_num" rowspan="5">3</td>
									<td id="reservation_report_group" rowspan="5">오는열차</td>
									<td id="reservation_report_question">상품명</td>
									<td id="reservation_report_answer">${endDto.trainCode}</td>
									<td id="reservation_report_question">객실등급</td>
									<td id="reservation_report_answer">
										<select>
											<option value="general">일반실</option>
											<option value="special">특실</option>
										</select>
										재고 : 309
									</td>
								</tr>
								<tr>
									<td id="reservation_report_question">이용기간</td>
									<td id="reservation_report_answer" colspan="3">2020년 6월 28일 (일)</td>

								</tr>

								<tr>
									<td id="reservation_report_question">출발역</td>
									<td id="reservation_report_answer">${endDto.startStation}(20:00)</td>
									<td id="reservation_report_question">도착역</td>
									<td id="reservation_report_answer">${endDto.endStation}(22:37)</td>
								</tr>
								<tr>
									<td id="reservation_report_question">이용인원</td>
									<td id="reservation_report_answer" colspan="3">
										<select>
										   <c:forEach var="n" begin="0" end="${prPersonal}">
										   		<option value="${n}">성인${n}명</option>
										   </c:forEach>
										</select>
										<select>
											 <c:forEach var="n" begin="0" end="${prPersonal}">
										   		<option value="${n}">어린이${n}명</option>
										   </c:forEach>
										</select>
										<select>
											 <c:forEach var="n" begin="0" end="${prPersonal}">
										   		<option value="${n}">경로${n}명</option>
										   </c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<td id="reservation_report_question">좌석선택</td>
									<td id="reservation_report_answer" colspan="3"><button>좌석선택</button></td>
								</tr>
							</table>
						</div>
					
							<div id="agreement">
								<div>약관동의</div>
								<table>
									<tr>
										<td>개인정보 수집 및 이용에 대한 안내</td>
										<td></td>
									</tr>
									<tr>
										<td>
											<input type="checkbox"> 약관에 동의합니다.
										</td>
										<td>
											<input type="checkbox"> 개인정보 수집 및 이용에 동의합니다.
										</td>
										<td>
											<input type="checkbox"> 개인정보의 제 3자 제공에 동의합니다.
										</td>
									</tr>
								</table>
							</div>
					
						<div>
							<div id="traveler_title">■ 예약자 및 여행자 정보입력</div>
							<table id="travler_info">
								<tr>
									<td id="traveler_title_sub" colspan="4">▷ 예약자 정보</td>
								</tr>
								<tr>
									<td id="travler_info_question">예약자 이름</td>
									<td id="travler_info_name">
										<input type="text" name="traveler" value="${dto.crewName}">
									</td>
									<td id="travler_info_question">생년월일</td>
									<td id="travler_info_birth">
										<input type="text" name="year" value="${fn:substring(dto.crewBirth, 0, 4)}">년
										<input type="text" name="month" value="${fn:substring(dto.crewBirth, 5, 7)}">월
										<input type="text" name="day" value="${fn:substring(dto.crewBirth, 8, 10)}">일
									</td>
								</tr>
								<tr>
									<td id="travler_info_question">휴대전화</td>
									<td id="travler_info_tel" colspan="3">
										<select name="tel1">
											<option value="010">010</option>
											<option value="011">011</option>
											<option value="016">016</option>
											<option value="017">017</option>
											<option value="018">018</option>
											<option value="019">019</option>
										</select>
										- <input type="text" name="tel2" value="${fn:substring(dto.crewTel, 4, 8)}">
										- <input type="text" name="tel3" value="${fn:substring(dto.crewTel, 9, 13)}">
									</td>
								</tr>
								<tr>
									<td id="travler_info_question">이메일</td>								
									<td id="travler_info_email" colspan="3">
										<input type="text" name="email1" value="${fn:split(dto.crewEmail,'@')[0]}"> @ 
										<input type="text" name="email2" value="${fn:split(dto.crewEmail,'@')[1]}">
										<select name="selectEmail" onchange="changeEmail()" >
											<option>선 택</option>
											<option value="direct" ${email2==""?"selected='selected'":""}>직접입력</option>
											<option value="nate.com" ${fn:split(dto.crewEmail,'@')[1]=="nate.com"?"selected='selected'":""}>nate.com</option>
											<option value="empal.com" ${fn:split(dto.crewEmail,'@')[1]=="empal.com"?"selected='selected'":""}>empal.com</option>
											<option value="hanmail.com" ${fn:split(dto.crewEmail,'@')[1]=="hanmail.com"?"selected='selected'":""}>hanmail.com</option>
											<option value="naver.com" ${fn:split(dto.crewEmail,'@')[1]=="naver.com"?"selected='selected'":""}>naver.com</option>
											<option value="yahoo.com" ${fn:split(dto.crewEmail,'@')[1]=="yahoo.com"?"selected='selected'":""}>yahoo.com</option>
											<option value="gogle.com" ${fn:split(dto.crewEmail,'@')[1]=="gogle.com"?"selected='selected'":""}>google.com</option>
										</select>
									</td>
								</tr>
							</table>
							<div><input type="checkbox">개인정보는 해당 상품 예약을 위한 목적으로만 활용되며 다른 목적으로는 일체 사용되지 않습니다. 개인정보활용에 동의하십니까?</div>

							<div>
								<div id="travler_button">
									<button type="button" onclick="javascript:location.href='<%=cp%>';">취소하기</button>
									<button onclick="embracing()">장바구니 담기</button>
									<button onclick="reservation()">바로예약</button>
								</div>
							</div>
						</div>	
					</form>
				</div>
			</div>
		</div>
			<!-- Main -->

		</div>