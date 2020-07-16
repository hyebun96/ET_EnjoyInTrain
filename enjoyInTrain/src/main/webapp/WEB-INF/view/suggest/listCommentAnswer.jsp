<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<style>
.homepage #main {
	margin-top: 0em;
	padding-top: 0em;
}
</style>

			<!-- 메인 내용 -->
			<c:forEach var="dto" items="${listReplyAnswer}">
			    <div class='answer' style='padding: 0px 10px;'>
			        <div style='clear:both; padding: 10px 0px;'>
			            <div style='float: left; width: 5%;'>└</div>
			            <div style='float: left; width:95%;'>
			                <div style='float: left;'><b>${dto.crewName}</b></div>
			                <div style='float: right;'>
			                    <span>${dto.created}</span>
			                    <c:if test="${sessionScope.crew.crewId==dto.crewId}">
			                    	<span class='deleteReplyAnswer' style='cursor: pointer;' data-replyNum='${dto.num}' data-answer='${dto.answer}'>삭제</span>
			                    </c:if>
			                </div>
			            </div>
			        </div>
			        <div style='clear:both; padding: 5px 5px 5px 5%; border-bottom: 1px solid #ccc;'>
			            ${dto.content}
			        </div>
			    </div>			            
			</c:forEach>
			<!-- /메인내용 -->


<!-- /Main -->