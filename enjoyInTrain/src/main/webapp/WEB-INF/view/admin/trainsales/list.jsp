<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<link rel="stylesheet" href="<%=cp%>/resource/css/notice.css" type="text/css">
<style>
.homepage #main{
	margin-top: 0em;
    padding-top: 0em;
}

.alert-info {
    border: 1px solid #9acfea;
    border-radius: 4px;
    background-color: #d9edf7;
    color: #31708f;
    padding: 15px;
    margin-top: 10px;
    margin-bottom: 20px;
}

tr.over {
	background: #f5fffa;
	cursor: pointer;
}

.boxTF{
	width: 150px;
}


#btn{
	width: 80px; 
	height: 30px; 
	margin-top: 20px; 
	background-color: white; 
	border-color: #cccccc;
	border-radius: 10px;
	
}

#btnsearch{
	width: 50px; 
	height: 30px; 
	margin-top: 20px; 
	background-color: white; 
	border-color: #cccccc;
}


.listname1 td{
	color: black;
}

.listname1:hover{
	background: #f5fffa;
}

.row a{
	cursor: pointer;
    text-decoration: none;
    color: black;
}

</style>

<!-- Main -->
<div id="adminpage">
	<div class="trainandtime">
		<a href="<%=cp%>/admin/trainsales/list">기차매출</a><span>|</span> <a href="<%=cp%>/admin/trainsales/list">프로모션매출</a>
	</div>
	
	<!-- Main -->
	<div id="main" class="container">
		<div class="row">
			<!-- 메인 내용 -->
			<div class="9u skel-cell-important">
			
				<section>
					<header>
						<h2>매출통계</h2>
						<span class="byline">SSSSS</span>
					</header>
					
					<div>
						

					</div>
				</section>
			</div>
		</div>
	</div>
	<!-- /Main -->
</div>
<!-- /Main -->