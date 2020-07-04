<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">

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

.listname1{
	padding-left: 20px;
}


.btn{
	width: 80px; 
	height: 30px; 
	margin-top: 20px; 
	background-color: white; 
	border-color: #cccccc;
	border-radius: 10px;
}

.btn1{
	width: 80px; 
	height: 25px; 
	margin-top: 20px; 
	background-color: white; 
	border-color: #cccccc;
	border-radius: 10px;
}

.btnsearch{
	width: 55px; 
	height: 25px;  
	margin-top: 20px; 
	background-color: white; 
	border-color: #cccccc;
	border-radius: 10px;
}

.menu-heght1{
	width: 100%; 
	border-spacing: 0px; 
	margin: 0px auto; 
	border-collapse: collapse;

}

.menu-heght1{
	height=35; 
	border-bottom: 1px solid #cccccc;
}

.qu:hover{
	background: #f5fffa;
}

ul.tabs {
	margin: 0;
	padding: 0;
	float: left;
	list-style: none;
	height: 35px;
	border-bottom: 1px solid #dddddd;
	width: 100%;
}
ul.tabs li {
	float: left;
	margin: 0;
	cursor: pointer;
	padding: 0px 21px ;
	height: 35px;
	line-height: 35px;
	overflow: hidden;
	position: relative;
	background: #ffffff;
}
ul.tabs li:hover {
	background: #e7e7e7;
}	
ul.tabs li.active{
	font-weight: 700;
	border: 1px solid #dddddd;
	border-bottom-color:  transparent;
}

a {
	color: black;
    text-decoration: none;
}

.\39 u {
    width: 65%;
}

</style>

<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">

<script type="text/javascript">
$(function(){
	var emcheck="${emcheck}";
	if(emcheck=="") emcheck="1";
	
	$("#tab-"+emcheck).addClass("active");

	$("ul.tabs li").click(function() {
		emcheck = $(this).attr("data-emcheck");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});
		
		$("#tab-"+emcheck).addClass("active");
		
		var url = "<%=cp%>/employee/list?emcheck="+emcheck;
		location.href=url;
	});
});


function searchList() {
	var f=document.searchForm;
	f.submit();
}
</script>



<!-- Main -->
<div id="adminpage">
				<div class="trainandtime">
					<a href="<%=cp%>/employee/list">직원관리</a> <span>|</span> <a href="<%=cp%>/admin/crewManage/list">회원관리</a>
				</div>
	<!-- Main -->
	<div id="main" class="container">
		<div class="row">
			
			
			<!-- 메인 내용 -->
			<div class="9u skel-cell-important">
			
				<section>
					<header>
						<h2>직원리스트</h2>
					</header>
					
					<div>		
						<div style="clear: both;">
							<ul class="tabs">
								<li id="tab-1" data-emcheck="1">재직</li>
								<li id="tab-0" data-emcheck="0">퇴사</li>
							</ul>
						</div>
										
						<table style="width: 100%; border-spacing: 0px; margin:0px auto; border-collapse: collapse;">						
						<thead class="menu-heght1">
			 				 <tr align="center" height="40" style="border-bottom: 1px solid #cccccc;"> 
								<th width="40">번호</th>
								<th width="80">이름</th>
								<th width="80">직책</th>
								<th width="80">생년월일</th>
								<th width="70">입사일</th>
							</tr>
						</thead>
						<tbody  class="listname1">
							<c:forEach var="dto" items="${list}">
								<tr align="center" height="35" data-num="${dto.emCode}" class="listname1" style="text-align: center; border-bottom: 1px solid #cccccc;"> 
									<td>${dto.listNum}</td>
									<td>
										<a href="${articleUrl}&emCode=${dto.emCode}"> ${dto.emName}</a>
									</td>
									<td>${dto.ptCategory} (${dto.ptCode})</td>
									<td>${dto.emBirth}</td>
									<td>${dto.hireDate}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				
					<table style="width: 100%; border-spacing: 0px;">
						<tr height="35">
							<td align="center">
								${dataCount==0?"등록된 게시물이 없습니다.":paging}
							</td>
						 </tr>
					</table>
			
					<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
			   			<tr height="40">
			    			<td align="left" width="150">
								${dataCount}개(${page}/${total_page} 페이지)
							</td>
						
							<td align="center">
								<form name="searchForm" action="<%=cp%>/employee/list" method="post">
									<button type="button" class="btn1" onclick="javascript:location.href='<%=cp%>/employee/list';">새로고침</button>
									<select name="condition" class="selectField">
										<option value="all" ${condition=="all"?"selected='selected'":""}>전체</option>
										<option value="emName" ${condition=="emName"?"selected='selected'":""}>이름</option>
										<option value="ptCategory" ${condition=="ptCategory"?"selected='selected'":""}>직책</option>
										<option value="hireDate" ${condition=="hireDate"?"selected='selected'":""}>입사일</option>
									</select>
									<input type="text" name="keyword" value="${keyword}" class="boxTF" width="50">
									<button type="button" class="btnsearch" onclick="searchList()">검색</button>
								</form>
							</td>
							
							<td align="right" width="100">
								<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/employee/create';">직원등록</button>
							</td>
							</tr>
						</table>
						
					</div>
				</section>
			</div>
			<!-- /메인내용 -->
		</div>
	</div>
</div>