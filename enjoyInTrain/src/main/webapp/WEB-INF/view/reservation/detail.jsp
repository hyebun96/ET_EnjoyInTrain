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
	border-bottom: 1px solid #BDBDBD;
}
</style>

<script type="text/javascript">
$(function(){
	$(".refundBtn").click(function(){
		var trCode=$(this).attr("data-code");
		location.href="<%=cp%>/reservation/refundForm?trCode="+trCode;
	});
});

function info_print() {
	var initBody = document.body.innerHTML;
	
	window.onbeforeprint = function () {
	document.body.innerHTML = document.getElementById("test").innerHTML;
	}
	
	window.onafterprint = function () {
	document.body.innerHTML = initBody;
	}
	
	window.print();
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
								<form action="<%=cp%>/reservation/confirm"  name="unCrewForm" method="post">
								<h2>발권/취소</h2>
								<span class="byline">발권내역/취소</span>
								<div style="width: 1200px; text-align: center;">
								 	<table style="width:100%;  ">
								 		<tr style="height:40px; font-weight:bold; border-top: 2px solid black; background: #EAEAEA;">
								 			<td style="background: #0f0f69e8; color: white;" colspan="9">승차권 예약현황</td>
								 		</tr>
								 		<tr style="height:40px; font-weight:bold; background: #EAEAEA;">
								 			<td style="background: #d7e4f3a8">승차일</td>
								 			<td style="background: #d7e4f3a8">열차번호</td>
								 			<td style="background: #d7e4f3a8">출발역</td>
								 			<td style="background: #d7e4f3a8">도착역</td>
								 			<td style="background: #d7e4f3a8">출발시간</td>
								 			<td style="background: #d7e4f3a8">도착시간</td>
								 			<td style="background: #d7e4f3a8">금액</td>
								 			<td style="background: #d7e4f3a8">인원</td>
								 			<td style="background: #d7e4f3a8">취소/환불</td>
								 		</tr>
								 		<c:forEach items="${list}" var="dto">
									 		<tr style="height: 40px;">
									 			<td>${dto.trDate}</td>
									 			<td>${dto.trCategory}&nbsp;${dto.trainCode}</td>
									 			<td>${dto.startCode}</td>
									 			<td>${dto.endCode}</td>
									 			<td>${dto.stTime}</td>
									 			<td>${dto.endTime}</td>
									 			<td>${dto.promotion==1?'-':dto.trPrice}</td>
									 			<td>${dto.count}</td>
									 			<td>
									 				<c:if test="${dto.promotion==0}">
										 				<button type="button" style="border:none; background: #232375c2; color: white;" class="refundBtn" data-code="${dto.trCode}">환불하기</button>
									 				</c:if>
									 				<c:if test="${dto.promotion==1}">
									 					<button type="button" style="border:none; background: #aaa; color: white;">프로모션</button>
									 				</c:if>
									 			</td>
									 		</tr>
								 		</c:forEach>
								 	</table>
								 	<div style="text-align:left; border: 1px solid #BDBDBD; padding: 20px;">
								 		<span>· 역창구에서 승차권을 구입 시 본인을 확인할 수 있는 회원카드나 신분증을 제시해야 합니다.</span><br>
										<span>· 결제한 승차권을 취소할 시 위약금을 수수합니다.</span><br>
										<span>· 이용자는 개인정보 수집/이용에 동의하지 않을 권리가 있으나, 거부 시 승차권 예약이 불가합니다.</span><br>
								 	</div>
								 	<br>
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