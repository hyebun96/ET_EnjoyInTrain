<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
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
	margin: 5px 0px;
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

#btn{
	width: 100px; 
	height: 30px; 
	margin-top: 20px; 
	background-color: white; 
	border-color: #cccccc;
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
	
	$(".board-list #question").click(function(){
		
		if($(this).next("tr").is(":visible")){
			$(this).next("tr").hide();
		}else{
			$(this).next("tr").show();	
		}
		
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
								<li><a href="<%=cp%>/notice/list">공지사항/이벤트</a></li>
								<li><a href="<%=cp%>/freeBoard/list">자유게시판</a></li>
								<li><a href="<%=cp%>/qna/main">QNA</a></li>
								<li><a href="<%=cp%>/faq/list">FAQ</a></li>
								<li><a href="<%=cp%>/lostBoard/list">유실물</a></li>
							</ul>
						</section>
					</div>
				
					<div class="9u skel-cell-important">
						<section>
							<header>
								<h2>F&nbsp;A&nbsp;Q</h2>
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
										<tr id="question" data-num="${dto.faqNum}" height="35" style="border-bottom: 1px solid #cccccc;">
											<td style="padding: 5px 0px;"><i class="fas fa-question-circle"></i>&nbsp;&nbsp;${dto.faqTitle}
												<c:if test="${sessionScope.crew.crewId=='a'}">
													<button type="button" id="deletebtn" class="btn" onclick="javascript:location.href='<%=cp%>/faq/delete?num=${dto.faqNum}';"><i class="fas fa-trash-alt"></i></button><button type="button" id="updatebtn" class="btn" onclick="javascript:location.href='<%=cp%>/faq/update?num=${dto.faqNum}';"><i class="fas fa-wrench"></i></button>
												</c:if>
											</td>
										</tr>
										<tr  height="35" style="background-color:#e7e7e7; border-bottom: 1px solid #cccccc; display: none;" >
											<td style="padding: 10px 0px;">&nbsp;<i class="fas fa-subway"></i>&nbsp;&nbsp;${dto.faqContent}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
								
							<table style="width: 100%; border-spacing: 0px;">
							   <tr height="35">
								<td align="right">
									<c:if test="${sessionScope.crew.crewId=='a'}">
								       <button style="border-radius: 10px;" type="button" id="btn" class="btn" onclick="javascript:location.href='<%=cp%>/faq/created';">FAQ올리기</button>
								    </c:if>   
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