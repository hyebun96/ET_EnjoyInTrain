<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

    <div style='clear: both;'>
        <div style='float: left;'><span style='color: #3EA9CD; font-weight: bold;'>댓글 ${replyCount}개</span> <span>[댓글 목록, ${pageNo}/${total_page} 페이지]</span></div>
        <div style='float: right; text-align: right;'></div>
    </div>
	
	<c:forEach var="vo" items="${listReply}">
	    <ul>
	    	<li style="width:100px; padding:5px 5px; border:1px solid #cccccc; border-right:none;"><span><b>${vo.crewId}</b></span></li>
	    	<li style="width:100px; padding:5px 5px; border:1px solid #cccccc; border-right:none;"><span><b>${vo.created}</b></span></li>
	    </ul>
	           <c:if test="${vo.crewId == sessionScope.crew.crewId ||  sessionScope.crew.crewId == 'admin' }">
	                <span class="deleteReply" style="cursor: pointer;" data-replyNum='${vo.lostReplyNum}' data-pageNo='${pageNo}'>삭제</span>
	           	</c:if>
	    <ul>
	    	<li>${vo.content}</li>
	    </ul>
	    <ul>
	    	<li><button type='button' class='btn btnReplyAnswerLayout' data-replyNum='${vo.lostReplyNum}'>답글 <span id="answerCount${vo.lostReplyNum}">${vo.answerCount}</span></button></li>
	    </ul>
		<ul class='replyAnswer' style='display: none;'>
			<li id='listReplyAnswer${vo.lostReplyNum}' class='answerList' style='border-top: 1px solid #cccccc;'>
	            <li style='clear: both; padding: 10px 10px;'>
	                <li style='float: left; width: 5%;'>└</li>
		                <li style='float: left; width:95%'>
		                    <textarea cols='72' rows='12' class='boxTA' style='width:98%; height: 70px;'></textarea>
		                </li>
            </li>
            <li style='padding: 0px 13px 10px 10px; text-align: right;'>
                <button type='button' class='btn btnSendReplyAnswer' data-replyNum='${vo.lostReplyNum}'>답글 등록</button>
            </li>
		</ul>
	</c:forEach>
	
              
		<div>
            <ul>
            	<li>${paging}</li>
            </ul>
		</div>
