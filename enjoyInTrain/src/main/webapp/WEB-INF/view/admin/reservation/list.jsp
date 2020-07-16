<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<link rel="stylesheet" href="<%=cp%>/resource/css/notice.css" type="text/css">
<style>
.homepage #main{
	margin-top: 0em;
    padding-top: 0em;
}

.listAll:hover{
	background: #f5fffa;
}

table td{
	//border-bottom: 1px solid #D5D5D5;
}
.refundSeatBtn{
	width: 60px;
	height: 20px;
	line-height: 15px;
	border-radius: 8px;
	background: white;
	
}
</style>

<script type="text/javascript">

$(function(){
	$(".listAll").click(function(){
		if($(this).attr("data-refund")==1){
			return;
		}
		
		var trCode=$(this).children(".trCode").children("input").val();
		var display=$(".seatList"+trCode).css("display");
		if(display=="none"){
			$(".seatList"+trCode).css("display","block");
		}else{
			$(".seatList"+trCode).css("display","none");
		}
	});
});

$(function(){
	$(".refundSeatBtn").click(function(){
		var trCode=$(this).attr("data-trCode");
		var rsSeatCode=$(this).attr("data-rsSeatCode");
		if(confirm("선택하신 승차권을 환불하시겠습니까?")==true){
			location.href="<%=cp%>/admin/reservation/refund?page=${page}&rows=${rows}&trCode="+trCode+"&rsseatCode="+rsSeatCode;
		}
	});
});
</script>


<!-- Main -->
<div id="adminpage">
	<div class="trainandtime">
		<a href="#">기차예약관리</a>
	</div>
	<!-- Main -->
	<div id="main" class="container">
		<div class="row">
			<!-- 메인 내용 -->
			<div class="9u skel-cell-important">
			
				<section>
					<header>
						<h2>기차예약관리</h2>
						<span class="byline">기차예약관리</span>
					</header>
					
					<div>
						<table style="margin:0 auto; text-align:center; width:1200px; border: 1px solid #D5D5D5; ">
							<tr style="height: 40px; background: #21373f; color: white;">
								<td>승차일</td>
								<td>열차종류</td>
								<td>열차번호</td>
								<td>출발역</td>
								<td>도착역</td>
								<td>아이디</td>
								<td>결제날짜</td>
								<td>금액</td>
								<td>포인트사용금액</td>
								<td>인원</td>
								<td>구매현황</td>
								<td>비고</td>
							</tr>
							<c:forEach items="${list}" var="dto">
								<tr class="listAll" style="height:40px;" data-refund="${dto.refund}">
									<td class="trCode trDate">
										<input type="hidden" value="${dto.trCode}" name="trCode">
										${dto.trDate}
									</td>
									<td>${dto.trCategory}</td>
									<td>${dto.trainCode}</td>
									<td>${dto.startCode}</td>
									<td>${dto.endCode}</td>
									<td>${dto.crewId}</td>
									<td>${dto.trPayDate}</td>
									<td>${dto.promotion==1?'-':dto.trPrice}</td>
									<td>${dto.promotion==1?'-':dto.trPointprice}</td>
									<td>${dto.count}</td>
									<td style="color: ${dto.refund==1?'red':'black'}">${dto.refund==1?'환불완료':'결제완료'}</td>
									<td>${dto.promotion==0?'':'프로모션'}</td>
								</tr>
								<tr>
									<td colspan="12">
										<div class="seatList${dto.trCode}" style="display:none;">
											<table style="width: 100%;">
												<tr style="height: 30px;">
													<td style="background: #325966; color: white;"></td>
													<td style="background: #325966; color: white;">좌석번호</td>
													<td style="background: #325966; color: white;">좌석타입</td>
													<td style="background: #325966; color: white;">칸번호</td>
													<td style="background: #325966; color: white;">좌석가격</td>
													<td style="background: #325966; color: white;">구매현황</td>
													<td style="background: #325966; color: white;">${dto.promotion==0?'환불':''}</td>
													<td style="background: #325966; color: white;"></td>
												</tr>
												<c:forEach items="${seatList}" var="seat">
													<c:if test="${seat.trCode==dto.trCode}">
														<tr style="height: 30px;">
															<td style="width: 15%;"></td>
															<td style="width: 12%">${seat.seatNum}</td>
															<td style="width: 12%">${seat.seatType}</td>
															<td style="width: 12%">${seat.roomNum}</td>
															<td style="width: 12%">${dto.promotion==1?'-':seat.seatPay}</td>
															<td style="color: ${seat.refund==1?'red':'black'}; width: 12%">${seat.refund==1?'환불완료':'결제완료'}</td>
															<td style="width: 10%;">
																<c:if test="${dto.promotion==0}">
																	<c:if test="${seat.refund!=1}">
																		<button class="refundSeatBtn" type="button"  data-rsSeatCode="${seat.rsseatCode}" data-trCode="${dto.trCode}">환불</button>
																	</c:if>
																</c:if>
															</td>
															<td style="width: 15%;"></td>
														</tr>
													</c:if>
												</c:forEach>
											</table>
										</div>
									</td>
								</tr>
							</c:forEach>
						</table>
						${dataCount==0?"예약내역이 없습니다.":paging}
					</div>
				</section>
			</div>
		</div>
	</div>
	<!-- /Main -->
</div>
<!-- /Main -->

	
