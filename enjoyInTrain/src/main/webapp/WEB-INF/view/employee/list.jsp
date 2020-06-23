<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<link rel="stylesheet" href="<%=cp%>/resource/css/freeBoard.css" type="text/css">

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

#updatebtn{
	width: 50px; 
	height: 30px;  
	background-color: white; 
	border-color: #cccccc;
	float: right;
	border-radius: 10px;
	margin-right: 5px;
}

#deletebtn{
	width: 50px; 
	height: 30px;  
	background-color: white; 
	border-color: #cccccc;
	float: right;
	border-radius: 10px;
	margin-right: 5px;
}

.qu:hover{
	background: #f5fffa;
}

</style>

<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.submit();
}
</script>

<!-- Banner -->
<div id="banner">
	<div class="container"></div>
</div>
<!-- /Banner -->

<!-- Main -->
<div id="page">
			
			<!-- 메인 내용 -->
			<div class="9u skel-cell-important">
			
				<section>
					<header>
						<h2 style="padding-left: 500px;">직원리스트</h2>
					</header>
					
					<div style="padding-left: 500px;">
						<table style="width: 100%; border-spacing: 0px; margin: 0px auto; border-collapse: collapse;">
							<tbody class="board-list">
							<tr height="35" style="border-bottom: 1px solid #cccccc;">
					
								<td align="left" width="50%">
									${dataCount}개(${page}/${total_page} 페이지)
								</td>
						
								<td align="right">
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
							</tr>
						</table>
						
						<table class="menu-heght1">
							<tr class="menu-heght2"> 
								<th width="60">번호</th>
								<th width="100">이름</th>
								<th width="100">직책</th>
								<th width="80">생년월일</th>
								<th width="60">입사일</th>
								<th width="50">재직여부</th>
							</tr>
						 <c:forEach var="dto" items="${list}">
							<tr class="listname1" style="text-align: center;"> 
								<td>${dto.listNum}</td>
								<td>
									<a href="${articleUrl}&num=${dto.emCode}"> ${dto.emName}</a>
								</td>
								<td>${dto.ptCategory} (${dto.ptCode})</td>
								<td>${dto.emBirth}</td>
								<td>${dto.hireDate}</td>
								<td>${dto.emcheck==1?'재직':'퇴사'}</td>
							</tr>
						</c:forEach>
						</table>
				
						<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
						   <tr height="35">
							<td align="center">
									${dataCount==0?"등록된 직원이 없습니다.":paging}
								</td>
							</tr>
						</table>
				
						<table style="width: 100%; border-spacing: 0px;">
							<tr height="35">
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
	<!-- /Main -->
</div>
<!-- /Main -->