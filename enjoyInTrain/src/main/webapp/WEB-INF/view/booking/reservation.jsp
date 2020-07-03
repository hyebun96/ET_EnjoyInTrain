<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript">
function reservation() {
	var f = document.reservationForm;
	
	f.action="<%=cp%>/booking/${mode}";
	
	f.submit();
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

$(function(){
	var roomGrade = "${roomGrade}";
	if(roomGrade=="특실") {
		$(".addPrice").show();
	}
	
	$(".roomGrade").change(function(){
		roomGrade = $(this).val();
		
		if(roomGrade=="특실") {
			$(".addPrice").show();
		} else {
			$(".addPrice").hclasse();
		}
	});
});

$(function(){
	var roomGrade = "${roomGrade}";
	if(roomGrade=="특실") {
		$(".addPrice1").show();
	}
	
	$(".roomGrade1").change(function(){
		roomGrade = $(this).val();
		
		if(roomGrade=="특실") {
			$(".addPrice1").show();
		} else {
			$(".addPrice1").hclasse();
		}
	});
});

$(function(){
	
	$(".adult").change(function(){
		var total = ${prPersonnel};
		var result;
		var adult = $(this).val();
		var n = total-adult;
		var $select=$(".child");
		$select.empty();
		for(var i=0; i<=n; i++) {
				$select.append("<option value='"+i+"'>어린이 "+i+"명</option>");
		}
	});
	
	$(".child").change(function(){
		var total = ${prPersonnel};
		var result;
		var adult = $(this).parent().find(".adult").val();
		var child = $(this).val();
		var n = total-adult-child;
		var $select=$(".oldMan");
		$select.empty();
		for(var i=0; i<=n; i++) {
				$select.append("<option value='"+i+"'>경로 "+i+"명</option>");
		}
	});
	
});

$(function(){
	
	$(".adult1").change(function(){
		var total = ${prPersonnel};
		var result;
		var adult = $(this).val();
		var n = total-adult;
		var $select=$(".child1");
		$select.empty();
		for(var i=0; i<=n; i++) {
				$select.append("<option value='"+i+"'>어린이 "+i+"명</option>");
		}
	});
	
	$(".child1").change(function(){
		var total = ${prPersonnel};
		var result;
		var adult = $(this).parent().find(".adult1").val();
		var child = $(this).val();
		var n = total-adult-child;
		var $select=$(".oldMan1");
		$select.empty();
		for(var i=0; i<=n; i++) {
				$select.append("<option value='"+i+"'>경로 "+i+"명</option>");
		}
	});
	
});

$(function(){
	$(".seatButton").click(function(){
		var trainCode=$(this).closest("table").find(".startTrianCode").val();  //기차코드 가져오기
		var trainName=$(this).closest("table").find(".startTrianCode").attr("data-trainName");	//기차종류 가져오기
		var stTime=$(this).closest("table").find(".startTime").attr("data-startTime");  //출발시간 가져오기
		var endTime=$(this).closest("table").find(".endTime").attr("data-endTime"); //도착시간 가져오기
		var url="<%=cp%>/reservation/seat";
		var query=$("form[name=reservationForm]").serialize();
		query+="&roomNum=1&total=${rsDto.total}";
		query+="&trainCode="+trainCode+"&trainName="+trainName+"&stTime="+stTime+"&endTime="+endTime;
		
		var selector="#modal-content2";
		ajaxHTML(url, "post", query, selector);
	});
});


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
						<section class="sclassebar">
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
					<form name="reservationForm" method="post">
						<div>
							<table class="reservation_header">
								<tr>
									<td class="reservation_state1">홈 > 기차 여행 패키지 > 예약하기 > </td>
									<td class="reservation_logo"  rowspan="2"></td>
								</tr>
								<tr>
									<td class="reservation_title">예약하기</td>
								</tr>
								<tr>
									<td class="reservation_state2" colspan="2">① 예약하기 ＞ </td>
								</tr>
							</table>
						</div>
					
						<div>
							<table class="reservation_info">
								<tr><td class="reservation_info_title" colspan="6">■ 선택상품정보</td></tr>
								<tr>
									<td class="reservation_info_question">상품명</td>
									<td colspan="5" class="reservation_info_answer">${startDto.pmTitle}</td>
								</tr>
								<tr>
									<td class="reservation_info_question">상품코드</td>
									<td class="reservation_info_answer">${startDto.pmCode}
										<input type="hidden" name="pmCode" value="${startDto.pmCode}">
										<input type="hidden" name="prSeq" value="${startDto.prSeq}">
									</td> 
									<td class="reservation_info_question">출발일자</td>
									<td class="reservation_info_answer">${pmStartDate}
										<input type="hidden" name="pmStartDate" value="${pmStartDate}">
									</td>
									<td class="reservation_info_question">예약인원</td>
									<td class="reservation_info_answer">${prPersonnel}
										<input type="hidden" name="prPersonnel" value="${prPersonnel}">
									</td>
								</tr>
							</table>
							
							<table class="reservation_report">
								<tr>
									<td class="reservation_report_num">순서</td>
									<td class="reservation_report_group">상품그룹</td>
									<td class="reservation_report_info" colspan="4">상품상세</td>
								</tr>
								<tr> 
									<td class="reservation_report_num" rowspan="5">1</td>
									<td class="reservation_report_group" rowspan="5">가는열차</td>
									<td class="reservation_report_question">상품명</td>
									<td class="reservation_report_answer">${start.trainName} - ${startDto.trainCode}
										<input type="hidden" class="startTrianCode" name="trainCode" value="${startDto.trainCode}" data-trainName="${start.trainName}">
									</td>
									<td class="reservation_report_question">객실등급</td>
									<td class="reservation_report_answer">
										<select name="roomGrade" class="roomGrade">
											<option value="일반" ${roomGrade=="일반"?"selected='selected'":""}>일반</option>
											<option value="특실" ${roomGrade=="특실"?"selected='selected'":""}>특실</option>
										</select>
										재고 : 309
										<span class="addPrice" style="display: none;"> + ${dto.prAddPrice}</span>
										
									</td>
								</tr>
								<tr>
									<td class="reservation_report_question">이용기간</td>
									<td class="reservation_report_answer" colspan="3">${pmStartDate}</td>

								</tr>

								<tr>
									<td class="reservation_report_question">출발역</td>
									<td class="reservation_report_answer">${startDto.startStation}(${start.startTime})
										<input type="hidden" class="startTime" name="startStation" value="${startDto.startStation}" data-startTime="${start.startTime}">
									</td>
									<td class="reservation_report_question">도착역</td>
									<td class="reservation_report_answer">${startDto.endStation}(${start.endTime})
										<input type="hidden" class="endTime" name="endStation"  value="${startDto.endStation}" data-endTime="${start.endTime}">
									</td>
								</tr>
								<tr>
									<td class="reservation_report_question">이용인원</td>
									<td class="reservation_report_answer" colspan="3">
										<select name="adult" class="adult">
										   <c:forEach var="n" begin="0" end="${prPersonnel}">
										   		<option value="${n}" ${adult=="${n}"?"selected='selected'":""}>성인 ${n}명</option>
										   </c:forEach>
										</select>
										<select name="child" class="child">
											 <c:forEach var="n" begin="0" end="${prPersonnel}">
										   		<option value="${n}" ${child=="${n}"?"selected='selected'":""}>어린이 ${n}명</option>
										   </c:forEach>
										</select>
										<select name="oldMan" class="oldMan">
											 <c:forEach var="n" begin="0" end="${prPersonnel}">
										   		<option value="${n}" ${oldMan=="${n}"?"selected='selected'":""}>경로 ${n}명</option>
										   </c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<td class="reservation_report_question">좌석선택</td>
									<td class="reservation_report_answer"><button type="button" class="seatButton">좌석선택</button></td>
								</tr>
								<tr>
									<td class="reservation_report_num" rowspan="3">2</td>
									<td class="reservation_report_group" rowspan="3">${startDto.product}
										<input type="hidden" name="product" value="${startDto.product}">
									</td>
									<td class="reservation_report_question">상품내용</td>
									<td class="reservation_report_answer" colspan="3">${startDto.productContent}</td>
								</tr>
								<tr>
									<td class="reservation_report_question">이용기간</td>
									<td class="reservation_report_answer" colspan="3">${pmStartDate}</td>
								</tr>
								<tr>
									<td class="reservation_report_question">이용수량</td>
									<td class="reservation_report_answer" colspan="3">
										<select name="productUserCount">
											<c:forEach var="n" begin="1" end="${prPersonnel}">
										   		<option value="${n}" ${productUserCount=="${n}"?"selected='selected'":""}>${n}명</option>
										   </c:forEach>
										</select>
										(기준 1인/최대 ${prPersonnel} 인)
										<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;가격은 프로모션에 포함되어 있습니다.</span> 
									</td>
								</tr>
								<tr>
									<td class="reservation_report_num" rowspan="5">3</td>
									<td class="reservation_report_group" rowspan="5">오는열차</td>
									<td class="reservation_report_question">상품명</td>
									<td class="reservation_report_answer">${end.trainName} - ${endDto.trainCode}
										<input type="hidden" name="trainCode" class="endTrianCode" value="${endDto.trainCode}">
									</td>
									<td class="reservation_report_question">객실등급</td>
									<td class="reservation_report_answer">
										<select name="roomGrade" class="roomGrade1">
											<option value="일반" ${roomGrade=="일반"?"selected='selected'":""}>일반</option>
											<option value="특실" ${roomGrade=="특실"?"selected='selected'":""}>특실</option>
										</select>
										재고 : 309
										<span class="addPrice1" style="display: none;"> + ${dto.prAddPrice}</span>
									</td>
								</tr>
								<tr>
									<td class="reservation_report_question">이용기간</td>
									<td class="reservation_report_answer" colspan="3">${pmStartDate}
									</td>

								</tr>

								<tr>
									<td class="reservation_report_question">출발역</td>
									<td class="reservation_report_answer">${endDto.startStation}(${end.startTime})
										<input type="hidden" name="startStation" value="${endDto.startStation}">
									</td>
									<td class="reservation_report_question">도착역</td>
									<td class="reservation_report_answer">${endDto.endStation}(${end.endTime})
										<input type="hidden" name="endStation" value="${endDto.endStation}">
									</td>
								</tr>
								<tr>
									<td class="reservation_report_question">이용인원</td>
									<td class="reservation_report_answer" colspan="3">
										<select name="adult1" class="adult1">
										   <c:forEach var="n" begin="0" end="${prPersonnel}">
										   		<option value="${n}" ${adult1=="${n}"?"selected='selected'":""}>성인 ${n}명</option>
										   </c:forEach>
										</select>
										<select name="child1" class="child1">
											 <c:forEach var="n" begin="0" end="${prPersonnel}">
										   		<option value="${n}" ${child1=="${n}"?"selected='selected'":""}>어린이 ${n}명</option>
										   </c:forEach>
										</select>
										<select name="oldMan1" class="oldMan1">
											 <c:forEach var="n" begin="0" end="${prPersonnel}">
										   		<option value="${n}" ${oldMan1=="${n}"?"selected='selected'":""}>경로 ${n}명</option>
										   </c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<td class="reservation_report_question">좌석선택</td>
									<td class="reservation_report_answer" colspan="3"><button type="button" class="seatButton1">좌석선택</button></td>
								</tr>
							</table>
						</div>
					
							<div class="agreement">
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
							<div class="traveler_title">■ 예약자 및 여행자 정보입력</div>
							<table class="travler_info">
								<tr>
									<td class="traveler_title_sub" colspan="4">▷ 예약자 정보</td>
								</tr>
								<tr>
									<td class="travler_info_question">예약자 이름</td>
									<td class="travler_info_name">
										<input type="text" name="traveler" value="${dto.crewName}">
									</td>
									<td class="travler_info_question">생년월일</td>
									<td class="travler_info_birth">
										<input type="text" name="year" value="${fn:substring(dto.crewBirth, 0, 4)}">년
										<input type="text" name="month" value="${fn:substring(dto.crewBirth, 5, 7)}">월
										<input type="text" name="day" value="${fn:substring(dto.crewBirth, 8, 10)}">일
									</td>
								</tr>
								<tr>
									<td class="travler_info_question">휴대전화</td>
									<td class="travler_info_tel" colspan="3">
										<select name="tel1">
											<option value="010" ${tel1=="010"?"selected='selected'":""}>010</option>
											<option value="011" ${tel1=="011"?"selected='selected'":""}>011</option>
											<option value="016" ${tel1=="016"?"selected='selected'":""}>016</option>
											<option value="017" ${tel1=="017"?"selected='selected'":""}>017</option>
											<option value="018" ${tel1=="018"?"selected='selected'":""}>018</option>
											<option value="019" ${tel1=="019"?"selected='selected'":""}>019</option>
										</select>
										- <input type="text" name="tel2" value="${fn:substring(dto.crewTel, 4, 8)}">
										- <input type="text" name="tel3" value="${fn:substring(dto.crewTel, 9, 13)}">
									</td>
								</tr>
								<tr>
									<td class="travler_info_question">이메일</td>								
									<td class="travler_info_email" colspan="3">
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
							<div><input type="checkbox" name="Agreement">개인정보는 해당 상품 예약을 위한 목적으로만 활용되며 다른 목적으로는 일체 사용되지 않습니다. 개인정보활용에 동의하십니까?</div>

							<div>
								<div class="travler_button">
									<button type="button" onclick="javascript:location.href='<%=cp%>/travel/travel';">취소하기</button>
									<button type="button" onclick="embracing()">장바구니 담기</button>
									<button type="button" onclick="reservation()">예약하기</button>
								</div>
							</div>
						</div>	
					</form>
				</div>
			</div>
		</div>
			<!-- Main -->

		</div>
		
		<div class="startSeat_dialog">
			<form action="">
			<table style="margin: 40px auto; wclassth: 750px;">
				<c:forEach var="rows" begin="1" end="2">
					<tr style="text-align: center;">
						<td colspan="2">
							<c:forEach var="columns" begin="1" end="10">
									<a href="#"><img alt="" src="<%=cp%>/resource/images/seat.png" style="wclassth: 50px; height: 50px; margin-right: 10px;"></a>
							</c:forEach>
						</td>
					</tr>
				</c:forEach>
					<tr style="text-align: center; margin-top: 15px;">
						<td style="height: 40px;" colspan="2"><td>
					</tr>
				<c:forEach var="rows" begin="1" end="2">
					<tr style="text-align: center; margin-top: 15px;">
						<td colspan="2">
							<c:forEach var="columns" begin="1" end="10">
									<a href="#"><img alt="" src="<%=cp%>/resource/images/seat.png" style="width: 50px; height: 50px; margin-right: 10px;"></a>
							</c:forEach>
						</td>
					</tr>
				</c:forEach>
				<tr>
					<td style="text-align: left; height: 60px; line-height: 60px;"><a href="#">＜＜ 이전 칸 </a></td>
					<td style="text-align: right; height: 60px; line-height: 60px;"><a href="#">다음 칸  ＞＞ </a></td>
				</tr>
			</table>
			</form>
		</div>
<div id="myModal2" class="modal">
  <!-- Modal content -->
  <div style="background: #6f047f;" class="modal-content2" id="modal-content2">
  	
  </div>
</div>
