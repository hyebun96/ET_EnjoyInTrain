<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<style>

.tabs li{
		font-weight:bold;
		background:#EAEAEA; 
	}


/* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  padding-top: 100px; /* Location of the box */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
  background-color: #fefefe;
  margin: auto;
  padding: 10px;
  border: 1px solid #888;
  width: 400px;
  height: 500px;
}

.modal-content2 {
  background-color: #fefefe;
  margin: auto;
  padding: 10px;
  border: 1px solid #888;
  width: 800px;
  height: 600px;
}

/* The Close Button */
.close {
  color: #aaaaaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}

</style>

<script type="text/javascript">
var stateButton="start";

function ajaxHTML(url, type, query, selector) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,success:function(data) {
			if($.trim(data)=="error") {
				return false;
			}
			$(selector).html(data);
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

function reservation() {
	var f = document.reservationForm;
	var adult = parseInt(f.adult.value);
	var child = parseInt(f.child.value);
	var oldMan = parseInt(f.oldMan.value);
	var adult1 = parseInt(f.adult1.value);
	var child1 = parseInt(f.child1.value);
	var oldMan1 = parseInt(f.oldMan1.value);
	var prPersonnel = parseInt(f.prPersonnel.value);

	if((adult+child+oldMan)!=prPersonnel){
		alert("가는 열차 이용인원을 제대로 선택하여 주세요");
		return;
	}
	
	if(!f.prStartRoom.value){
		alert("가는 열차 좌석을 선택하여주세요.");
		return;
	}
	
	if((adult1+child1+oldMan1)!=prPersonnel){
		alert("오는 열차 이용인원을 제대로 선택하여 주세요");
		return;
	}
	
	if(!f.prEndRoom.value){
		alert("오는 열차 좌석을 선택하여주세요.");
		return;
	}
	
	if(!f.agreed1.checked){
		$("#agreed1").css("color", "blue");
		$("#agreed1").css("font-weight", "bold");
		return;
	}
	
	if(!f.agreed2.checked){
		$("#agreed2").css("color", "blue");
		$("#agreed2").css("font-weight", "bold");
		return;
	}
	
	if(!f.agreed3.checked){
		$("#agreed3").css("color", "blue");
		$("#agreed3").css("font-weight", "bold");
		return;
	}
	
	if(!f.traveler.value){
		f.traveler.focus();
		return;
	}
	
	if(!f.year.value){
		f.year.focus();
		return;
	}
	
	if(!f.month.value){
		f.month.focus();
		return;
	}
	
	if(!f.day.value){
		f.day.focus();
		return;
	}
	
	if(!f.email1.value){
		f.email1.focus();
		return;
	}	
	
	if(!f.email2.value){
		f.email2.focus();
		return;
	}
	
	if(!f.tel1.value){
		f.tel1.focus();
		return;
	}
	
	if(!f.tel2.value){
		f.tel2.focus();
		return;
	}
	
	if(!f.tel3.value){
		f.tel3.focus();
		return;
	}
	
	if(!f.Agreement.checked){
		$("#Agreement").css("color", "blue");
		$("#Agreement").css("font-weight", "bold");
		return;
	}

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
			$(".addPrice").hide();
		}
	});
});

$(function(){
	var roomGrade1 = "${roomGrade1}";
	if(roomGrade1=="특실") {
		$(".addPrice1").show();
	}
	
	$(".roomGrade1").change(function(){
		roomGrade = $(this).val();
		
		if(roomGrade=="특실") {
			$(".addPrice1").show();
		} else {
			$(".addPrice1").hide();
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
		
		$select=$(".oldMan");
		$select.empty();
		for(var i=0; i<=n; i++) {
			$select.append("<option value='"+i+"'>경로 "+i+"명</option>");
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
		
		$select=$(".oldMan1");
		$select.empty();
		for(var i=0; i<=n; i++) {
			$select.append("<option value='"+i+"'>경로 "+i+"명</option>");
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
		stateButton="start";
		
		var trainCode=$(this).closest("table").find(".startTrianCode").val();  //기차코드 가져오기
		var trainName=$(this).closest("table").find(".startTrianCode").attr("data-trainName");	//기차종류 가져오기
		var stTime=$(this).closest("table").find(".startTime").val();  //출발시간 가져오기
		var endTime=$(this).closest("table").find(".endTime").val(); //도착시간 가져오기
		var roomGrade=$(this).closest("table").find(".roomGrade").val(); //좌석 등급 가져오기
		var url="<%=cp%>/booking/seat";
		var query="roomNum=1&total=${prPersonnel}";
		query+="&trainCode="+trainCode+"&trainName="+trainName+"&stTime="+stTime+"&endTime="+endTime;
		query+="&day=${pmStartDate1}&tCategory="+trainName;
		query+="&startSt=${startDto.startStation}";
		query+="&endSt=${startDto.endStation}";
		if(roomGrade=='특실'){
			query+="&roomGrade="+"특실";
		}else{
			query+="&roomGrade="+"일반실";
		}
		query+="&firstPage=true";
		query+="&"+$("form[name=reservationForm]").serialize();
		var selector="#modal-content2";
		ajaxHTML(url, "post", query, selector);
	});
});

$(function(){
	$(".seatButton1").click(function(){
		stateButton="end";
		
		var trainCode=$(this).closest("table").find(".endTrianCode").val();  //기차코드 가져오기
		var trainName=$(this).closest("table").find(".endTrianCode").attr("data-trainName");	//기차종류 가져오기
		var stTime=$(this).closest("table").find(".startTime1").val();  //출발시간 가져오기
		var endTime=$(this).closest("table").find(".endTime1").val(); //도착시간 가져오기
		var roomGrade=$(this).closest("table").find(".roomGrade1").val(); //좌석 등급 가져오기
		var url="<%=cp%>/booking/seat";
		var query="roomNum=1&total=${prPersonnel}";
		query+="&trainCode="+trainCode+"&trainName="+trainName+"&stTime="+stTime+"&endTime="+endTime;
		// query+="&day=${pmStartDate}";
		query+="&day=${pmStartDate2}&tCategory="+trainName;
		query+="&startSt=${endDto.startStation}";
		query+="&endSt=${endDto.endStation}";
		if(roomGrade=='특실'){
			query+="&roomGrade="+"특실";
		}else{
			query+="&roomGrade="+"일반실";
		}
		query+="&firstPage=true";
		query+="&"+$("form[name=reservationForm]").serialize();
		var selector="#modal-content2";
		ajaxHTML(url, "post", query, selector);
	});
});

$(function(){
	$("ul.tabs li").click(function() {
		var tab = $(this).attr("data-tab");
		if(tab=="0") {
			$(".memberAgreement1").show();
			$(".memberAgreement2").hide();
		} else if(tab=="1") {
			$(".memberAgreement1").hide();
			$(".memberAgreement2").show();
		}
		
	});
});


</script>
<link rel="stylesheet" href="<%=cp%>/resource/css/booking.css" type="text/css">
	<!-- Main -->
		<div id="page">
				
			<!-- Main -->
			<div id="main" class="container">
			<div class="reservation_top">
				<div class="reservation_main">
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
										<input type="hidden" name="trainName" value="${start.trainName}">
									</td>
									<td class="reservation_report_question">객실등급</td>
									<td class="reservation_report_answer">
										<select name="roomGrade" class="roomGrade" >
											<option value="일반" ${roomGrade=="일반"?"selected='selected'":""}>일반</option>
											<option value="특실" ${roomGrade=="특실"?"selected='selected'":""}>특실</option>
										</select>
										<span class="addPrice" style="display: none;"> + ${start.prAddPrice * prPersonnel}</span>
										<input type="hidden" name="prAddPrice" value="${start.prAddPrice * prPersonnel}">
									</td>
								</tr>
								<tr>
									<td class="reservation_report_question">이용기간</td>
									<td class="reservation_report_answer" colspan="3">${pmStartDate}</td>

								</tr>

								<tr>
									<td class="reservation_report_question">출발역</td>
									<td class="reservation_report_answer">${startDto.startStation}(${start.startTime})
										<input type="hidden"  name="startStation" value="${startDto.startStation}">
										<input type="hidden" class="startTime" name="startTime" value="${start.startTime }">
									</td>
									<td class="reservation_report_question">도착역</td>
									<td class="reservation_report_answer">${startDto.endStation}(${start.endTime})
										<input type="hidden" name="endStation"  value="${startDto.endStation}">
										<input type="hidden" class="endTime" name="endTime" value="${start.endTime }">
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
									<td class="reservation_report_answer">
										<button type="button" class="seatButton" style="background: #82909D; color: white; border: none; font-weight: bold; height: 30px;">좌석선택</button>  
										<span id="startSeatInfoView"></span>
										<input type="hidden" name="prStartRoom" value="">
										<input type="hidden" name="prStartTrainSeat" value="">
									</td>
									
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
										<input type="hidden" name="trainCode1" class="endTrianCode" value="${endDto.trainCode}" data-trainName="${end.trainName}">
										<input type="hidden" name="trainName1" value="${end.trainName}">
									</td>
									<td class="reservation_report_question">객실등급</td>
									<td class="reservation_report_answer">
										<select name="roomGrade1" class="roomGrade1">
											<option value="일반" ${roomGrade1=="일반"?"selected='selected'":""}>일반</option>
											<option value="특실" ${roomGrade1=="특실"?"selected='selected'":""}>특실</option>
										</select>
										<span class="addPrice1" style="display: none;"> + ${end.prAddPrice1 * prPersonnel}</span>
											<input type="hidden" name="prAddPrice1" value="${end.prAddPrice1 * prPersonnel}">
									</td>
								</tr>
								<tr>
									<td class="reservation_report_question">이용기간</td>
									<td class="reservation_report_answer" colspan="3">${pmEndDate}
									<input type="hidden" name="pmEndDate" value="${pmEndDate}">
									</td>

								</tr>

								<tr>
									<td class="reservation_report_question">출발역</td>
									<td class="reservation_report_answer">${endDto.startStation}(${end.startTime})
										<input type="hidden" name="startStation1" value="${endDto.startStation}">
										<input type="hidden" class="startTime1" name="startTime1" value="${end.startTime}">
									</td>
									<td class="reservation_report_question">도착역</td>
									<td class="reservation_report_answer">${endDto.endStation}(${end.endTime})
										<input type="hidden" name="endStation1" value="${endDto.endStation}">
										<input type="hidden" class="endTime1" name="endTime1" value="${end.endTime}">
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
									<td class="reservation_report_answer" colspan="3">
										<button type="button" class="seatButton1" style="background: #82909D; color: white; border: none; font-weight: bold; height: 10px; height: 30px;">좌석선택</button> 
										<span id="endSeatInfoView"></span>
										<input type="hidden" name="prEndRoom" value="">
										<input type="hidden" name="prEndTrainSeat" value="">
									</td>
								</tr>
							</table>
						</div>
					
							<div class="agreement">
								<div class="agreement_title">■ 약관동의</div>
								<div>
								<ul class="tabs">
									<li id="tab-0" data-tab="0">개인정보 수집 및 이용에 대한 안내</li>
									<li id="tab-1" data-tab="1">개인정보의 제 3자 제공 동의</li>
								</ul>
								</div>
								<div class="agreement_form">
									<table>
										<tr class="memberAgreement1">
											<td>
												[수집하는 개인정보의 항목]<br>
												가. 우리 공사는 승차권 구입, 원활한 고객상담, 각종 여행 상품 예약서비스를 제공하기 위해 아래와 같은 최소한의 개인<br>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;정보를 수집,이용합니다.
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 수집정보 : 성명, 연락처, 생년월일, 이메일, 성별<br>
												나. 서비스 이용과정에서 아래와 같은 정보들이 자동으로 생성되어 수집될 수 있습니다.<br>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- IP주소, 쿠키, 서비스 이용기록, 방문기록 등<br>
												다. 전자상거래 등에서의 소비자 보호에 관한 법률에 의해 예약 서비스 이용과정에서 아래와 같은 거래정보들이 수집될 수 있습니다.<br>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 결제 카드번호, 결제 승인번호<br><br>
												
												[개인정보 수집 및 이용 목적]<br>
												가. 서비스 제공에 관한 계약 이행 : 여행상품 구입<br>
												나. 불만처리 등 민원처리, 고지사항 전달, 분쟁조정을 위한 기록보전<br><br>
												
												[개인정보의 보유 및 이용기간]<br>
												가. 운영근거 : 정보주체동의<br>
												나. 보유기간 : 5년<br><br>
												
												[개인정보 수집, 이용에 동의하지 않으실 수 있습니다. 동의 거부시에는 예약서비스는 제한됩니다.]<br><br>
												
												개인정보 처리에 관한 자세한 사항은 EnjoyTrain 홈페이지 (http://localhost:9090/enjoyInTrain/)에 공개하고 있는 <br>
												"개인정보처리 방침" 을 참고하시기 바랍니다.
											</td>
										</tr>
										<tr class="memberAgreement2" style="display: none;">
											<td>
												○ 개인정보의 제 3자 제공<br>
												* EnjoyTrain은 정보주체의 개인정보를 제1조(개인정보의 처리 목적)에서 명시한 범위 내에서만 처리하며, 정보주체의 동의, 법률의<br>
												특별한 규정 등 『개인정보 보호법』 제 17조 및 제 18조에 해당하는 경우에만 개인정보를 제3자에게 제공합니다.<br>
												* EnjoyTrain은 다음과 같이 개인정보를 제 3자에게 제공하고 있습니다.<br>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. 철도회원 정보, 예약자 및 여행자 정보<br>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 제공받는 자 : 상품운영여행사<br>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 제공목적 : 예약 당해 상품 제공<br>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 제공근거 : 정보주체의 동의<br>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 제공항목 : 이름, 성별, 휴대전화, 생년월일, 이메일<br>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 제공받는 자의 이용기간 : 정보주체의 당해 상품 이용 종료 시점까지<br>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 수집 동의 거부 및 불이익 : 개인정보의 제 3자 제공에 동의하지 않을 권리가 있으나 거부 시 당해 상품 이용이 제한됩니다.<br>
											</td>
										</tr>
									</table>
								</div>
								<table class="agreement_check">
									<tr>
										<td>
											<input type="checkbox" name="agreed1"><span id="agreed1" > 약관에 동의합니다.</span>
										</td>
										<td>
											<input type="checkbox" name="agreed2"><span id="agreed2"> 개인정보 수집 및 이용에 동의합니다.</span>
										</td>
										<td>
											<input type="checkbox" name="agreed3"><span id="agreed3"> 개인정보의 제 3자 제공에 동의합니다.</span>
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
									<button type="button" onclick="javascript:location.href='<%=cp%>/travel/travel';"  
										style="background: #82909D; color: white; border: none; font-weight: bold; height: 30px;">취소하기</button>
									<button type="button" onclick="reservation()"
										style="background: #82909D; color: white; border: none; font-weight: bold; height: 30px;">예약하기</button>
								</div>
							</div>
						</div>	
					</form>
				</div>
			</div>
		</div>
			<!-- Main -->
	</div>
	
<div id="myModal2" class="modal">
	<!-- Modal content -->
	<div style="background: #716B6E;" class="modal-content2" id="modal-content2">
		
	</div>
</div>