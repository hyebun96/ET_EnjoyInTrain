<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>


<!-- Header -->
		<div id="header">
		<div class="loginForm">
			<c:if test="${empty sessionScope.crew}">
				<a href="<%=cp%>/crew/login">Login</a> | <a href="<%=cp%>/crew/crew">Join</a>
			</c:if>
			<c:if test="${not empty sessionScope.crew && sessionScope.crew.crewId != 'a'}">
				<a href="<%=cp%>/crew/update">MyPage</a> | <a href="<%=cp%>/crew/logout">Logout</a>
			</c:if>
		 	<c:if test="${sessionScope.crew.crewId=='a'}">
                <a href="<%=cp%>/admin">관리자Page</a> | <a href="<%=cp%>/crew/logout">Logout</a>
            </c:if>
		</div>
				
			<div class="container1">
				<!-- Nav -->
				<div class="menu">
						<ul class="nav">
							<li class="navbar"><a href="<%=cp%>/temp/left-sidebar.jsp">Reservation</a>
								<ul class="navbar1">
									<li><a href="<%=cp%>/qna/main">예약 하기</a></li>
									<li><a href="<%=cp%>/faq/list">예약 조회</a></li>
									
								</ul>
							</li>
							<li class="navbar"><a href="<%=cp%>/travel/travel">Promotion</a>
								<ul class="navbar2">
									<li><a href="<%=cp%>/qna/main">프로모션 예약</a></li>
									<li><a href="<%=cp%>/faq/list">프로모션 예약 조회</a></li>
									<li><a href="<%=cp%>/notice/list">프로모션 이용안내</a></li>
									
								</ul>
							</li>
							
							<li>	
								<a href="<%=cp%>/main"><img src="<%=cp%>/resource/images/mainlogo.png" width="100" height="90px;"></a>
							</li>
							
							<li class="navbar"><a href="<%=cp %>/booking/receipt">Board</a>
								<ul class="navbar3">
									<li><a href="<%=cp%>/qna/main">qna</a></li>
									<li><a href="<%=cp%>/faq/list">faq</a></li>
									<li><a href="<%=cp%>/notice/list">공지사항</a></li>
									<li><a href="<%=cp%>/lostBoard/list">유실물</a></li>
									<li><a href="<%=cp%>/freeBoard/list">자유게시판</a></li>
									<li><a href="<%=cp%>/suggest/list">고객의 소리</a></li>
								</ul>
							</li>
							<li class="navbar"><a href="<%=cp%>/exam">게시판예시</a>
								<ul class="navbar4">
									<li class="active"><a href="<%=cp%>/crew/crew">회원가입</a></li>
									<li><a href="<%=cp%>/qna/main">qna</a></li>
									<li><a href="<%=cp%>/faq/list">faq</a></li>
									<li><a href="<%=cp%>/notice/list">공지사항</a></li>
									<li><a href="<%=cp%>/lostBoard/list">유실물</a></li>
									<li><a href="<%=cp%>/freeBoard/list">자유게시판</a></li>
									<li><a href="<%=cp%>/suggest/list">고객의 소리</a></li>
								</ul>
							</li>
						</ul>
					</div>
						<!-- 
						<ul>
							<li class="active"><a href="<%=cp%>/crew/crew">회원가입</a></li>
							<li><a href="<%=cp%>/qna/main">qna</a></li>
							<li><a href="<%=cp%>/faq/list">faq</a></li>
							<li><a href="<%=cp%>/notice/list">공지사항</a></li>
							<li><a href="<%=cp%>/lostBoard/list">유실물</a></li>
							<li><a href="<%=cp%>/freeBoard/list">자유게시판</a></li>
							<li><a href="<%=cp%>/suggest/list">고객의 소리</a></li>
						</ul>
						 -->
					

			</div>
		</div>
	<!-- Header -->
