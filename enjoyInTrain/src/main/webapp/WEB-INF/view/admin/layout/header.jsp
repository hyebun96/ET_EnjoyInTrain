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
					<a href="<%=cp%>/main">HOMEPAGE</a> | <a href="<%=cp%>/crew/logout">Logout</a>
			</div>
			
			<!-- Logo --> 
			<div id="logo" style="padding-left: 15%;">
				<a href="<%=cp%>/main"><img src="<%=cp%>/resource/images/etmainlogo.png" width="200"></a>
			</div>
			
			<div class="container">
				<!-- Nav -->
					<nav id="nav">
						<ul>
							<li class="active"><a href="<%=cp%>/employee/list">직원관리</a></li>
							<li class="active"><a href="<%=cp%>/train/list">기차관리</a></li>
							<li class="active"><a href="#">직원관리</a></li>
							<li class="active"><a href="#">프로모션관리</a></li>
							<li class="active"><a href="#">매출관리</a></li>
							<li class="active"><a href="#">등등등</a></li>
						</ul>
					</nav>
			</div>
		</div>
	<!-- Header -->
