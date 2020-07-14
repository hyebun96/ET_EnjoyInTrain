<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/promotion.css" type="text/css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">

<script type="text/javascript">
function deleteReservation(prSeq) {
	var url = "<%=cp%>/admin/promotion/delete?prSeq="+prSeq+"&page=${page}";
	if(confirm("삭제하시겠습니까?")){
		location.href = url;
	}
}
</script>

<!-- Main -->
	<div id="adminpage">
		<div class="trainandtime">
			<a href="<%=cp%>/admin/travel/travel">프로모션 관리</a> <span>|</span> <a href="<%=cp%>/admin/promotion/list">프로모션 예약 관리</a>
		</div>
			<!-- Main -->
			<div id="main" class="container">
				<div class="row">
				<div class="Keyword">
					</div>
						<table class="salesTable" >
							<tr class="salesBar" style="color: white; font-weight: bold;">
								<td class="salesBar_num"> 번호 </td>
								<td class="salesBar_reservationNum">예약번호</td>
								<td class="salesBar_title"> 프로모션 제목 </td>
								<td class="salesBar_content"> 프로모션 포함 상품 </td>
								<td class="salesBar_price"> 가격 </td>
								<td class="salesBar_addPrice"> 추가 가격 </td>
								<td class="salesBar_userName"> 구매자 </td>
								<td class="salesBar_reservationDate">예약날짜</td>
								<td class="salesBar_paymentDate">결제유무</td>
								<td class="salesBar_button"></td>
							</tr>
							<c:forEach var="dto" items="${list}" varStatus="status">
									<tr class="salesList">
										<td class="salesList_num"> ${dto.listNum}</td>
										<td class="salesList_reservationNum"> ${dto.reservationNumber}</td>
										<td class="salesList_title"> ${dto.pmTitle}</td>
										<td class="salesList_content"> ${dto.product} </td>
										<td class="salesList_price"> ${dto.pmPrice} 원 </td>
										<td class="salesList_addPrice"> ${dto.prAddPrice} 원 </td>
										<td class="salesList_userName"> ${dto.crewName} </td>
										<td class="salesList_paymentDate"> ${dto.prReservationDate.substring(0, 10)}</td>
										<td class="salesList_button"> 
											<c:if test="${dto.prpayment==1}">
												결제완료
											</c:if> 
										</td>
										<td>
											<button type="button" onclick="deleteReservation('${dto.prSeq}');" style="height:25px; background: white; border: 2px solid black; border-radius: 5px; ">
												<i class="fas fa-trash-alt"></i>
											</button>
										</td>
									</tr>
							</c:forEach>
						</table>
						<div class="salesPaging">
							<div>${dataCount==0 ? "등록된 게시물이 없습니다.":paging}</div>
						</div>
					</div>
					
				</div>
			</div>
			<!-- Main -->
	<!-- /Main -->