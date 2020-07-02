<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<style>
table td{
	border-left: 1px solid #BDBDBD;
}

table{
	border: 1px solid #BDBDBD;
}

</style>

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

function ajaxHTML(url, type, query, selector) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,success:function(data) {
			if($.trim(data)=="error") {
				listPage(1);
				$(selector).html(data);
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


</script>
	<!-- Main -->
		<div id="page" >
			<!-- Main -->
			<div id="main" class="container" style="margin-top: 0; padding-top: 0;">
				<div class="row">
					<div class="9u skel-cell-important">
						<section>
							<header>
								<form action="<%=cp%>/reservation/reservation" name="reservationForm" method="post">
								<h2>예약확인</h2>
								<span class="byline">confirm</span>
								<div style="width: 1200px; text-align: center;">
								<input type="hidden" value="${map.day}" name="trDate">
								<input type="hidden" value="${map.startSt}" name="startCode">
								<input type="hidden" value="${map.endSt}" name="endCode">
								<input type="hidden" value="${map.trainCode}" name="trainCode">
								<input type="hidden" value="${map.roomNum}" name="roomNum">
								<input type="hidden" value="${map.total}" name="total">
								 	<table style="width:100%;  ">
								 		<tr style="height:40px; background:#EAEAEA; border-top: 2px solid black;">
								 			<td><b>승차일자</b></td>
								 			<td><b>열차종류</b></td>
								 			<td><b>열차번호</b></td>
								 			<td><b>출발역</b></td>
								 			<td><b>도착역</b></td>
								 			<td><b>출발시각</b></td>
								 			<td><b>도착시각</b></td>
								 			<td><b>인원</b></td>
								 			<td><b>결제금액</b></td>
								 		</tr>
								 		<tr style="height: 40px;">
								 			<td>${map.day}</td>
								 			<td>${map.trainName}</td>
								 			<td>${map.trainCode}</td>
								 			<td>${map.startSt}</td>
								 			<td>${map.endSt}</td>
								 			<td>${map.stTime}</td>
								 			<td>${map.endTime}</td>
								 			<td>${map.total}</td>
								 			<td>${map.totalPay}</td>
								 		</tr>
								 	</table>
								 	<table style="width: 100%;">
								 		<tr style="height:40px; background:#EAEAEA; border-top: 2px solid black;">
								 			<td><b>객실등급</b></td>
								 			<td><b>좌석정보</b></td>
								 			<td><b>승객유형</b></td>
								 			<td><b>운임요금</b></td>
								 			<td><b>할인금액</b></td>
								 			<td><b>영수금액</b></td>
								 			<td><b>운임추가할인선택</b></td>
								 		</tr>
								 		<c:set var="i" value="0"/>
								 		<c:forEach items="${seatList}" var="num">
								 			<c:set var="i" value="${i+1}"/>
									 		<tr style="height: 40px; border-bottom: 1px solid #BDBDBD" >
									 			<td>${map.roomGrade}</td>
									 			<td>${map.roomNum}호실 ${num.seatNum}
									 				<input type="hidden" name="seatNum${i}" value="${num.seatNum}">
									 			</td>
									 			<td>${num.seatType}
									 				<input type="hidden" name="seatType${i}" value="${num.seatType}">
									 			</td>
									 			<td>${num.seatPay}
									 				<input type="hidden" name="seatPay${i}" value="${num.seatPay}">
									 			</td>
									 			<td>0</td>
									 			<td>${num.seatPay}</td>
									 			<td>
									 				<select>
									 					<option>1</option>
									 					<option>2</option>
									 				</select>
									 			</td>
									 		</tr>
								 		</c:forEach>
								 	</table>
								 	<button type="button" style="font-weight:bold; font-size:15px; border-radius:5px; width:100px; height:30px; background: #6f047f; color: white; border: none;">결제하기</button>
									<button type="button" style="font-weight:bold; font-size:15px; border-radius:5px; width:100px; height:30px; background: #6f047f; color: white; border: none;">다시계산</button>
									<button >좌석예약(테스트)</button>
								</div>
								</form>
							</header>
						</section>
					</div>
					
				</div>
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->