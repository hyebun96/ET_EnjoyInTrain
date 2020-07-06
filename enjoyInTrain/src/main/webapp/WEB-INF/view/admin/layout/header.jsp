<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<!-- Header -->
		<div id="adminheader">
			<div class="adminmenulogo" style="padding-top: 50px;">
			<a href="<%=cp%>/admin"><img src="<%=cp%>/resource/images/logotest3.png" width="135px" height="90px;"></a>
			</div>
			
			<div class="adminloginForm">
					<a href="<%=cp%>/main">HOMEPAGE</a> | <a href="<%=cp%>/crew/logout">Logout</a>
			</div>
			
			
			<div class="container1">
				<!-- Nav -->
				<div class="adminmenu">
						<ul class="adminnav">
							<li class="adminnavbar"><a href="#">프로모션관리</a></li>
						</ul>
						<ul class="adminnav">
							<li class="adminnavbar"><a href="<%=cp%>/admin/sales/list">매출관리</a></li>
						</ul>
						<ul class="adminnav">
							<li class="adminnavbar"><a href="<%=cp%>/employee/list">직원/회원관리</a></li>
						</ul>
						<ul class="adminnav">
							<li class="adminnavbar"><a href="<%=cp%>/admin/notice/list">게시판관리</a></li>
						</ul>
						<ul class="adminnav">
							<li class="adminnavbar"><a href="<%=cp%>/admin/timetable/main">기차/시간표 추가/변경</a>
								<!-- 
								<ul class="adminnavbar4">
									<li><a href="<%=cp%>/admin/train/list">기차관리</a></li>
									<li><a href="<%=cp%>/admin/timetable/main">시간표관리</a></li>
								</ul>
								 -->
							</li>
						</ul>
				</div>
			</div>
		</div>
	<!-- Header -->
