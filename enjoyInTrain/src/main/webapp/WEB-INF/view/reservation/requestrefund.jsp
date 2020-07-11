<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>


<style>
table{
	border: 1px solid #BDBDBD;
}
table td{
	border-right: 1px solid #BDBDBD;
}
table tr{
}
</style>

<script type="text/javascript">
function refundBtn(){
	if(confirm("선택하신 승차권을 환불하시겠습니까?")==true){
		var f=document.refundForm;
		f.submit();
		return;
	}else{
		return;
	}
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
								<h2>환불</h2>
								<span class="byline">REFUND</span>
								<div style="width: 1200px; text-align: center;">
								<form action="<%=cp%>/reservation/refund" method="post" name="refundForm">
								 	<input type="hidden" value="${trCode}" name="trCode">
								 	<table style="width:100%;">
								 		<tr style="height:40px; font-weight:bold; border-top: 2px solid black; background: #EAEAEA;">
								 			<td style="background: #CEE3F6;">승차일</td>
								 			<td style="background: #CEE3F6;">열차종류</td>
								 			<td style="background: #CEE3F6;">열차번호</td>
								 			<td style="background: #CEE3F6;">출발역</td>
								 			<td style="background: #CEE3F6;">도착역</td>
								 			<td style="background: #CEE3F6;">출발시간</td>
								 			<td style="background: #CEE3F6;">도착시간</td>
								 			<td style="background: #CEE3F6;">결제금액</td>
								 		</tr>
									 		<tr style="height:40px; border-bottom: 1px solid #BDBDBD">
									 			<td>${rv.trDate}</td>
									 			<td>${rv.trCategory}</td>
									 			<td>${rv.trainCode}</td>
									 			<td>${rv.startCode}</td>
									 			<td>${rv.endCode}</td>
									 			<td>${rv.stTime}</td>
									 			<td>${rv.endTime}</td>
									 			<td>${rv.trPrice}</td>
									 		</tr>
								 	</table>
								 	<table style="width:100%;  ">
								 		<tr style="height:40px; font-weight:bold; border-top: 2px solid black; background: #EAEAEA;">
								 			<td style="background: #CEE3F6;">열차번호</td>
								 			<td style="background: #CEE3F6;">객실등급</td>
								 			<td style="background: #CEE3F6;">좌석정보</td>
								 			<td style="background: #CEE3F6;">승객유형</td>
								 			<td style="background: #CEE3F6;">환불금액</td>
								 		</tr>
								 		<c:forEach items="${list}" var="dto">
									 		<tr style="height:40px; border-bottom: 1px solid #BDBDBD">
									 			<td>${dto.trainCode}</td>
									 			<td>${dto.roomGrade}</td>
									 			<td>${dto.roomNum}호차 ${dto.seatNum}</td>
									 			<td>${dto.seatType}</td>
									 			<td>${dto.seatPay}
									 				<input type="hidden" value="${dto.rsseatCode}" name="rsseatCode">
									 			</td>
									 		</tr>
								 		</c:forEach>
								 	</table>
								 	<br>
								 	<button type="button" onclick="refundBtn()" style="font-weight:bold; font-size:15px; border-radius:5px; width:200px; height:30px; background: #08298A; color: white; border: none;">환불 최종 완료하기</button>
								 	<br>
								</form>
								</div>
							</header>
						</section>
					</div>
				</div>
			</div>
			<!-- Main -->
		</div>
	<!-- /Main -->