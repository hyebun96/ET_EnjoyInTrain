<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<style type="text/css">
#btn{
	border-radius: 150px; 
	border: 1px solid black; 
	margin: 0;
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
				style="border-bottom: 1px solid #cccccc;" onclick="javascript:articleForm('${dto.pmCode}');">
				<td style="width: 200px;">
					<img src="<%=cp%>/uploads/travel/${dto.saveFileName}" width="200px" height="120px" style="margin: 15px 15px;">
				</td>
				<td style="width: 720px; font-weight: bold; "> ${dto.pmTitle}<br>  
					<p style="color:orange;"><fmt:formatNumber value="${dto.pmPrice}" pattern="#,###" />&#126;</p>
				</td>
			</tr>
		</c:forEach>
		
	</tbody>
</table>


