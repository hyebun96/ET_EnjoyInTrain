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

function send() {
	location.href='<%=cp%>/crew/mypage';
}


</script>
	<!-- Main -->
		<div id="page" >
			<!-- Main -->
			<div id="main" class="container" style="margin-top: 0; padding-top: 0;">
				<div class="row">
						<section>
							<header>
								<form action="<%=cp%>/reservation/confirm"  name="unCrewForm" method="post">
								<h2>프로모션 예약조회</h2>
								<span class="byline">프로모션 예약조회 및 상세정보</span>
								<div style="text-align: right; margin-bottom: 15px; "> 
									<button type="button" onclick="send();" style="background: #82909D; color: white; border: none; font-weight: bold; height: 30px;"> 자세히 > ></button>
								</div>
								<div style="width: 1200px; text-align: center;">
								 	<table style="width:100%;  ">
								 		<tr style="height:40px; font-weight:bold; border-top: 2px solid black; background: #EAEAEA;">
								 			<td style="background: #382a31; color: white;" colspan="7">프로모션 예약현황</td>
								 		</tr>
								 		<tr style="height:40px; font-weight:bold; background: #F7E8E4;">
								 			<td style="background: #F7E8E4">예약번호</td>
								 			<td style="background: #F7E8E4">프로모션명</td>
								 			<td style="background: #F7E8E4">이용기차</td>
								 			<td style="background: #F7E8E4">출발역</td>
								 			<td style="background: #F7E8E4">도착역</td>
								 			<td style="background: #F7E8E4">예약일</td>
								 			<td style="background: #F7E8E4">인원</td>
								 		</tr>
								 		<c:forEach items="${list}" var="dto">
									 		<tr style="height: 40px;">
									 			<td>${dto.reservationNumber}</td>
									 			<td>${dto.pmTitle}</td>
									 			<td>${dto.trainCode}</td>
									 			<td>${dto.startStation}</td>
									 			<td>${dto.endStation}</td>
									 			<td>${dto.prReservationDate}</td>
									 			<td>${dto.prPersonnel}</td>
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
			<!-- Main -->

		</div>
	<!-- /Main -->