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
			<c:if test="${not empty sessionScope.crew}">
				<a href="<%=cp%>/crew/logout">Logout</a> | <a href="#">정보수정이나 마이페이지</a>
			</c:if>
		</div>
				<!-- Logo -->
					<div id="logo">
						<a href="<%=cp%>/notice/list"><img src="<%=cp%>/resource/images/etmainlogo.png" width="200"></a>
					</div>
			<div class="container">
					
				
				<!-- Nav -->
					<nav id="nav">
						<ul>
							<li class="active"><a href="<%=cp%>/temp/index.jsp">Homepage</a></li>
							<li><a href="<%=cp%>/temp/left-sidebar.jsp">Left Sidebar</a></li>
							<li><a href="right-sidebar.html">Right Sidebar</a></li>
							<li><a href="no-sidebar.html">No Sidebar</a></li>
							<li><a href="<%=cp%>/exam">게시판예시</a></li>
						</ul>
						<ul>
							<li class="active"><a href="<%=cp%>/crew/crew">회원가입</a></li>
							<li><a href="<%=cp%>/qna/list">qna</a></li>
							<li><a href="<%=cp%>/faq/list">faq</a></li>
							<li><a href="<%=cp%>/notice/list">공지사항</a></li>
							<li><a href="<%=cp%>/lostBoard/list">유실물</a></li>
							<li><a href="<%=cp%>/freeBoard/list">자유게시판</a></li>
							<li><a href="#">신고</a></li>
						</ul>
					</nav>

			</div>
		</div>
	<!-- Header -->
