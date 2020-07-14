<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<style type="text/css">
.btnConfirm {
	font-size: 15px; 
	border:none;
	color:#ffffff;
	background:#6f047f;
	width: 360px;
	height: 50px;
	line-height: 50px;
	border-radius:4px;
}
</style>

<!-- Banner -->
	<!-- /Banner -->

	<!-- Main -->
		<div id="page">
			<!-- Main -->
			<div id="main" class="container" style=" width: 1000px; border-top:3px solid #6f047f; height:400px;  margin-top: 50px; padding-top: 0;" >
			    <div style="margin: 0px auto; padding-top:90px; width:420px;">
			    	<div style="text-align: center;">
			        	<span style="font-weight: bold; font-size:27px; color: #424951;"><strong>경고 !</strong></span>
			        </div>
			        
			        <div class="messageBox">
			            <div style="line-height: 150%; padding-top: 35px; text-align: center;">
			                    해당 정보를 접근 할 수 있는 권한 이 없습니다.
			            </div>
			            <div style="margin-top: 20px; text-align: center;">
			                     <button type="button" onclick="javascript:location.href='<%=cp%>/';" class="btnConfirm">메인화면으로 이동</button>
			                </div>
			        </div>
			     </div>   
			</div>
			<!-- Main -->
		</div>
	<!-- /Main -->