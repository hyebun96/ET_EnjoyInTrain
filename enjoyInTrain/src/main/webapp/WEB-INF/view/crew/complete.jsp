<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<!-- Banner -->
		<div id="banner">
			<div class="container">
			</div>
		</div>
	<!-- /Banner -->
 
	<!-- Main -->
		<div id="page">
			<!-- Main -->
			<div id="main" class="container" style="width: 700px; margin-top: 0; text-align:center; border:1px soild #cccccc; padding-top: 0;" >
			${message}
			<button type="button" onclick="javascript:location.href='<%=cp%>/';">메인화면으로 이동</button>
			</div>
			<!-- Main -->
		</div>
	<!-- /Main -->