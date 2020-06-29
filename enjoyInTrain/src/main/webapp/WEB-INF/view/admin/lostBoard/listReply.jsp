<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<style type="text/css">
.homepage #main{
   margin-top: 0em;
    padding-top: 0em;
}
</style>
<link rel="stylesheet" href="<%=cp%>/resource/css/board.css" type="text/css">
    <div>
        <div id="reply_list_title_main">
	        <span id="reply_list_title_content">댓글 ${replyCount}개</span>
	        <span>&nbsp;&nbsp;[댓글 목록, ${pageNo}/${total_page} 페이지]</span>
        </div>
        <div style='float: right; text-align: right;'></div>
    </div>
	
	<c:forEach var="vo" items="${listReply}">
	    <ul>
	    	<li id="reply_list_id"><span><b>${vo.crewId}</b></span></li>
	    	<li id="reply_list_created"><span><b>${vo.created} </b></span>
	                <span class="deleteReply" style="cursor: pointer;" data-replyNum='${vo.lostReplyNum}' data-pageNo='${pageNo}'>| 삭제</span>
	    	</li>
	    </ul>
	    <ul>
	    	<li id="reply_list_content">${vo.content}</li>
	    </ul>
	    <ul>
	    	<li id="reply_list_button"><button type='button' class='btn btnReplyAnswerLayout' data-replyNum='${vo.lostReplyNum}'>답글 <span id="answerCount${vo.lostReplyNum}">${vo.answerCount}</span></button></li>
	    </ul>
	<div class='replyAnswer'>
		<ul>
			<li id='listReplyAnswer${vo.lostReplyNum}'></li>
		</ul>
		<ul id="reply_list_answer">
			<li id="reply_list_answer_sign">└</li>
			<li id="reply_list_answer_content">
				<textarea class='boxTA' style='width:96%; height: 70px; resize: none;'></textarea>
			</li>
            <li id="reply_list_answer_button">
                <button type='button' class='btn btnSendReplyAnswer' data-replyNum='${vo.lostReplyNum}'>답글 등록</button>
            </li>
		</ul>
	</div>
	</c:forEach>
	
              
		<div>
            <ul>
            	<li>${paging}</li>
            </ul>
		</div>
