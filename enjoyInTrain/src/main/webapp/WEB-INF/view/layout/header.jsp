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
			Login | Join 
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
						</ul>
					</nav>

			</div>
		</div>
	<!-- Header -->
