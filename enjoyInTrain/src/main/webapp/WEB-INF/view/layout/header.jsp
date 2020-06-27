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
				<a href="#">My Page</a> | <a href="<%=cp%>/crew/logout">Logout</a>
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
								<ul>
									<li class="active"><a href="<%=cp%>/crew/crew">회원가입</a></li>
									<li><a href="<%=cp%>/qna/main">qna</a></li>
									<li><a href="<%=cp%>/faq/list">faq</a></li>
									<li><a href="<%=cp%>/notice/list">공지사항</a></li>
									<li><a href="<%=cp%>/lostBoard/list">유실물</a></li>
									<li><a href="<%=cp%>/freeBoard/list">자유게시판</a></li>
									<li><a href="<%=cp%>/suggest/list">고객의 소리</a></li>
								</ul>
							</li>
							<li class="navbar"><a href="<%=cp%>/travel/travel">Promotion</a>
								<ul>
									<li class="active"><a href="<%=cp%>/crew/crew">회원가입</a></li>
									<li><a href="<%=cp%>/qna/main">qna</a></li>
									<li><a href="<%=cp%>/faq/list">faq</a></li>
									<li><a href="<%=cp%>/notice/list">공지사항</a></li>
									<li><a href="<%=cp%>/lostBoard/list">유실물</a></li>
									<li><a href="<%=cp%>/freeBoard/list">자유게시판</a></li>
									<li><a href="<%=cp%>/suggest/list">고객의 소리</a></li>
								</ul>
							</li>
							
							<li>	
								<a href="<%=cp%>/main"><img src="<%=cp%>/resource/images/mainlogo.png" width="100"></a>
							</li>
							
							<li class="navbar"><a href="<%=cp %>/booking/receipt">Board</a>
								<ul>
									<li class="active"><a href="<%=cp%>/crew/crew">회원가입</a></li>
									<li><a href="<%=cp%>/qna/main">qna</a></li>
									<li><a href="<%=cp%>/faq/list">faq</a></li>
									<li><a href="<%=cp%>/notice/list">공지사항</a></li>
									<li><a href="<%=cp%>/lostBoard/list">유실물</a></li>
									<li><a href="<%=cp%>/freeBoard/list">자유게시판</a></li>
									<li><a href="<%=cp%>/suggest/list">고객의 소리</a></li>
								</ul>
							</li>
							<li class="navbar"><a href="<%=cp%>/exam">게시판예시</a>
								<ul>
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
