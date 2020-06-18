<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
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

</style>

<script type="text/javascript">

$(function(){
	$("#tab-${group}").addClass("active");
	
	$("ul.tabs li").click(function() {
		tab = $(this).attr("data-tab");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});
		
		$("#tab-"+tab).addClass("active");
		
		var url="<%=cp%>/faq/list?group="+tab;	
		location.href=url;
		
	});
});

$(function(){
	$(".board-list tr").hover(function(){
		$(this).addClass("over");
	}, function(){ // 마우스가 벗어나면
		$(this).removeClass("over");
	});
	
	$(".board-list tr").click(function(){
		
		if($(this).next("tr").is(":visible")){
			$(this).next("tr").hide();
		}else{
			$(this).next("tr").show();	
		}
		
	});
});

$(function(){
	$("#btn").click(function(){
		var url="<%=cp%>/faq/create;	
		location.href=url;
	});
});

</script>


	<!-- Banner -->
		<div id="banner">
			<div class="container">
			</div>
		</div>
	<!-- /Banner -->

	<!-- Main -->
		<div id="page">
				
			<!-- Main -->
			<div id="main" class="container">
				<div class="row">

					<div class="3u">
						<section class="sidebar">
							<header>
								<h2>F&nbsp;A&nbsp;Q</h2>
							</header>
							<ul class="style1">
								<li><a href="#">승차권구매</a></li>
								<li><a href="#">승차권이용</a></li>
								<li><a href="#">승차권환불</a></li>
								<li><a href="#">코레일멤버십</a></li>
								<li><a href="#">결제</a></li>
								<li><a href="#">기타</a></li>
							</ul>
						</section>
					</div>
				
					<div class="9u skel-cell-important">
						<section>
							<header>
								<h2>자주 묻는 질문</h2>
								<span class="byline">Frequently asked questions</span>
							</header>
							<div style="clear: both;">
								<ul class="tabs">
									<li id="tab-0" data-tab="0">전체</li>
									<c:forEach var="vo" items="${groupList}">
										<li id="tab-${vo.categoryNum}" data-tab="${vo.categoryNum}">${vo.category}</li>
									</c:forEach>
								</ul>
							</div>
							<div id ="tab-content" style="clear: both; padding: 20px 0px 0px;">
								
							<table style="width: 100%; border-spacing: 0px; margin: 0px auto; border-collapse: collapse;">
								<tbody class="board-list">
									<c:forEach var="dto" items="${list}">
										<tr align="center" data-num="${dto.faqNum}" height="35" style="border-bottom: 1px solid #cccccc;">
											<td>${dto.faqTitle}</td>
										</tr>
										<tr align="center" height="35" style="border-bottom: 1px solid #cccccc; display: none;" >
											<td>${dto.faqContent}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
								
							<table style="width: 100%; border-spacing: 0px;">
							   <tr height="35">
								<td align="right">
								       <button type="button" id="btn" style="width: 100px; height: 30px; margin-top: 20px; background-color: white; border-color: #cccccc">FAQ올리기</button>
								 </td>
							   </tr>
							</table>
							
							</div>
							
							</section>
					</div>
					
				</div>
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->