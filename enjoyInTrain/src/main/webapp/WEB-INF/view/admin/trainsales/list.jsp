<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
   String cp = request.getContextPath();
%>
<style>

td{
	border: 1px solid #cccccc;
	text-align: center;
	height: 40px;
}


</style>


<div align="center">
   	<table style="border: 1px soild #cccccc">
   		<tr style="border: 1px soild #cccccc; background: #21373f; color: white;">
   			<td width="120">일자</td>
   			<td width="100">예약 건수</td>
   			<td width="200">결제 금액</td>
   		</tr>
		<c:forEach items="${list}" var="dto">
	  		<tr>
	  			<td>${dto.trPayDate}</td>
	  			<td>${dto.count}</td>
	  			<td><fmt:formatNumber value="${dto.seatPay}" pattern="#,###"/></td>
	  		</tr>
		</c:forEach>
   	</table>
</div>