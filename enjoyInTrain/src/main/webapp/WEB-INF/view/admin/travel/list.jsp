<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<style type="text/css">
#btn{
	border-radius: 10px;
	height: 30px;
}
#btn:hover{
	background: #21373F;
	color: white;
}
</style>

<table style="width: 100%; border-spacing: 0px; margin: 0px auto; border-collapse: collapse;">
	<tbody class="board-list">
		<tr>
			<td></td>
		</tr>
		
		<c:forEach var="dto" items="${list}">
			<tr id="question-${dto.categoryNum}" class="qu" data-num="${dto.pmCode}" height="35"
				style="border-bottom: 1px solid #cccccc;" >
				<td style="width: 200px;">
					<img src="<%=cp%>/uploads/travel/${dto.saveFileName}" width="200px" height="120px" style="margin: 15px 15px;">
				</td>
				<td style="width: 720px; font-size: 13px; padding-left: 20px;">
					<p><i class="fas fa-barcode"></i>&nbsp; ${dto.pmCode}</p>
					<p>${dto.pmTitle}</p>
					<p><i class="fas fa-won-sign"></i>&nbsp; <fmt:formatNumber value="${dto.pmPrice}" pattern="#,###" /></p>
				</td>
				<td>
					<button type="button" id="btn" class="btn"
						onclick="updateForm('${dto.pmCode}');">프로모션 수정</button><br>
					<button type="button" id="btn" class="btn"
						onclick="deletePromotion('${dto.pmCode}');">프로모션 삭제</button>
				</td>
			</tr>
		</c:forEach>
		
	</tbody>
</table>


