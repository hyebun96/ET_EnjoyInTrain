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

<script type="text/javascript"
	src="<%=cp%>/resource/se/js/HuskyEZCreator.js" charset="utf-8">
</script>

<!-- Banner -->
<div id="banner">
	<div class="container"></div>
</div>
<!-- /Banner -->

<!-- Main -->
<div id="page">

	<!-- Main -->
	<div id="main" class="container">
		<div class="row">

			<!-- 사이드 바 메뉴 -->
			<div class="3u">
				<section class="sidebar">
					<header>
						<h2>자유게시판</h2>
					</header>

					<ul class="style1">
						<li><a href="#">소메뉴1</a></li>
						<li><a href="#">소메뉴2</a></li>
						<li><a href="#">소메뉴3</a></li>
						<li><a href="#">소메뉴4</a></li>
						<li><a href="#">소메뉴5</a></li>
					</ul>
				</section>
			</div>
			<!-- /사이드바 메뉴 -->

			<!-- 메인 내용 -->
			<c:forEach var="vo" items="${listReplyAnswer}">
			    <div class='answer' style='padding: 0px 10px;'>
			        <div style='clear:both; padding: 10px 0px;'>
			            <div style='float: left; width: 5%;'>└</div>
			            <div style='float: left; width:95%;'>
			                <div style='float: left;'><b>${vo.crewName}</b></div>
			                <div style='float: right;'>
			                    <span>${vo.created}</span> |
			                    <c:if test="${sessionScope.crew.crewId==vo.crewId || sessionScope.crew.crewId=='admin'}">
			                    	<span class='deleteReplyAnswer' style='cursor: pointer;' data-replyNum='${vo.replyNum}' data-answer='${vo.answer}'>삭제</span>
			                    </c:if>
			                    <c:if test="${sessionScope.crew.crewId!=vo.crewId && sessionScope.crew.crewId!='admin'}">
			                    	<span class="notifyReply">신고</span>
			                    </c:if>
			                </div>
			            </div>
			        </div>
			        <div style='clear:both; padding: 5px 5px 5px 5%; border-bottom: 1px solid #ccc;'>
			            ${vo.content}
			        </div>
			    </div>			            
			</c:forEach>
			<!-- /메인내용 -->
		</div>
	</div>
	<!-- /Main -->
</div>
<!-- /Main -->