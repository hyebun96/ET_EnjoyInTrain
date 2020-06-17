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

element.style{
	font-size: x-large;
}

.search-height1{
	width: 100%; 
	margin: 20px auto 10px; 
	border-spacing: 0px;
}

.search-height1 tr{
	height=35;
}

.menu-heght1{
	width: 100%; 
	border-spacing: 0px; 
	border-collapse: collapse;
}

.menu-heght2{
	align:center; 
	bgcolor:#eeeeee;
	height:35;
	border-top: 1px solid #cccccc; 
	border-bottom: 1px solid #cccccc;
	color: #787878;
}

.listname1{
	 align:center; 
	 bgcolor:#ffffff;
	 height: 35;
	 border-bottom: 1px solid #cccccc;
}

.nocontent1{
	 width: 100%; 
	 border-spacing: 0px;
	 height:35;
	 text-align:center;
}

.btn{
	background: white;
	border-color: #787878;
	border-width: 1px;
	height: 27px;
}

.menubottom1{
	 width: 100%; 
	 margin: 10px auto; 
	 border-spacing: 0px;"
}

.menubottom1 tr{
	  height:40;
}

.menubottom1 td{
	 width:100;
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
		
	<!-- Main -->
	<div id="main" class="container">
		<div class="row">
			
			<!-- 사이드 바 메뉴 -->
			<div class="3u">
				<section class="sidebar">
					<header>
						<h2>자유게시판</h2>
					</header>
					
					<ul class="style1">
						<li><a href="#">소메뉴1</a></li>
						<li><a href="#">소메뉴2</a></li>
						<li><a href="#">소메뉴3</a></li>
						<li><a href="#">소메뉴4</a></li>
						<li><a href="#">소메뉴5</a></li>					
					</ul>
				</section>
			</div>
			<!-- /사이드바 메뉴 -->
			
			<!-- 메인 내용 -->
			<div class="9u skel-cell-important">
			
				<section>
					<header>
						<h2>자유게시판</h2>
						<span class="byline" style="margin-top: 20px; ">일상이야기를 들려주세요.</span>
					</header>
					
					<div>
						<table class="search-height1">
							<tr>
								<td align="left" width="50%">
									${dataCount}개(${page}/${total_page} 페이지)
								</td>
						
								<td align="right">
									<form name="searchForm" action="<%=cp%>/freeBoard/list" method="post">
										<select name="condition" class="selectField">
											<option value="all" ${condition=="all"?"selected='selected'":""}>전체</option>
											<option value="fbTitle" ${condition=="fbTitle"?"selected='selected'":""}>제목</option>
											<option value="fbContent" ${condition=="fbContent"?"selected='selected'":""}>내용</option>
											<option value="crewName" ${condition=="crewName"?"selected='selected'":""}>작성자</option>
											<option value="fbCreated" ${condition=="fbCreated"?"selected='selected'":""}>등록일</option>
										</select>
										<input type="text" name="keyword" value="${keyword}" class="boxTF" width="50">
										<button type="button" class="btn" onclick="searchList()">검색</button>
									</form>
								</td>
							</tr>
						</table>
						
						<table class="menu-heght1">
							<tr class="menu-heght2"> 
								<th width="60">번호</th>
								<th width="200">제목</th>
								<th width="100">작성자</th>
								<th width="80">작성일</th>
								<th width="60">조회수</th>
								<th width="50">파일</th>
							</tr>
						 <c:forEach var="dto" items="${list}">
							<tr class="listname1"> 
								<td>${dto.listNum}</td>
								<td align="left" style="padding-left: 10px;">
									<a href="${articleUrl}&num=${dto.fbNum}">${dto.fbTitle}(${dto.replyCount})</a>
								</td>
								<td>${dto.crewName}</td>
								<td>${dto.fbCreated}</td>
								<td>${dto.fbHitCount}</td>
								<td>
									<c:if test="${dto.fileCount !=0}">
										<a href="<%=cp%>/freeBoard/download?num=${dto.fbNum}">
										<i class="far fa-file"></i></a>
									</c:if>
								</td>
							</tr>
						</c:forEach>
						</table>
				
						<table class="nocontent1">
							<tr>
								<td>
									${dataCount==0?"등록된 게시물이 없습니다.":paging}
								</td>
							</tr>
						</table>
				
						<table class="menubottom1">
							<tr>
								<td align="left">
									<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/freeBoard/list';">새로고침</button>
								</td>
								
								<td align="right">
									<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/freeBoard/created';">글올리기</button>
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