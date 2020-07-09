<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>


	<!-- Main -->
		<div id="adminpage">
				
			<!-- Main -->
			<div id="main" class="container">
				<div class="row">

				
					<div class="9u skel-cell-important">
					<div style="clear: both;">
							<ul class="tabs">
								<li id="tab-1" data-emcheck="1">프로모션</li>
								<li id="tab-0" data-emcheck="0">기      차</li>
							</ul>
						</div>
						<div>
							<select name="keyword">
								<option value="year" ${keyword=="year"?"selected='selected'":""}>년도별</option>
								<option value="month" ${keyword=="month"?"selected='selected'":""}>월 별</option>
								<option value="day" ${keyword=="day"?"selected='selected'":""}>일 별</option>
							</select>
						</div>
						<table style="width: 100%; border-spacing: 0px; margin: 0px auto; border-collapse: collapse;">
							<tr class="noticebar">
								<td> 번호 </td>
								<td> 프로모션 제목 </td>
								<td> 프로모션 포함 상품 </td>
								<td> 가격 </td>
								<td> 추가 가격 </td>
								<td> 구매자 </td>
							</tr>
							<c:forEach var="dto" items="${list}">
								<tr>
									<td> ${dto.listNum} </td>
									<td> ${dto.pmTitle}</td>
									<td> ${dto.product} </td>
									<td> ${dto.pmPrice} 원 </td>
									<td> ${dto.prAddPrice} 원 </td>
									<td> ${dto.crewId} </td>
								</tr>
							</c:forEach>
						</table>
						<div>${dataCount==0 ? "등록된 게시물이 없습니다.":paging}</div>
					</div>
					
				</div>
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->