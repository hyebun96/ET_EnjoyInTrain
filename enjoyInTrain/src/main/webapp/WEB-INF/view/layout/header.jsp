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
			<a href="#">Login</a> | <a href="#">Join</a>
		</div>
			<div class="container">
					
				<!-- Logo -->
					<div id="logo">
						<h1><a href="#">Ex Machina</a></h1>
					</div>
				
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
							<li class="active"><a href="#">회원가입</a></li>
							<li><a href="#">qna</a></li>
							<li><a href="#">faq</a></li>
							<li><a href="#">공지사항</a></li>
							<li><a href="#">유실물</a></li>
							<li><a href="#">자유게시판</a></li>
							<li><a href="#">신고</a></li>
						</ul>
					</nav>

			</div>
		</div>
	<!-- Header -->
