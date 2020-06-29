<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<link rel="stylesheet" href="<%=cp%>/resource/css/notice.css" type="text/css">
<style type="text/css">
.homepage #main{
   margin-top: 0em;
    padding-top: 0em;
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
								<font size="3px">News</font>
								<h2>게시판</h2>
							</header>
							<ul class="style11">
								<li><a href="<%=cp%>/qna/main">QnA</a></li>
								<li><a href="<%=cp%>/faq/list">FAQ</a></li>
								<li><a href="<%=cp%>/notice/list">공지사항</a></li>
								<li><a href="<%=cp%>/lostBoard/list">유실물</a></li>
								<li><a href="<%=cp%>/freeBoard/list">자유게시판</a></li>
								<li><a href="<%=cp%>/suggest/list">고객의소리</a></li>
							</ul>
						</section>
					</div>
				
					<div class="9u skel-cell-important">
						<section>
							<header>
								<h2>공지사항</h2>
								<span class="byline">Notice | Check news of new services and events</span>
							</header>
							
							
							<div style="clear: both;">
								<ul>
									<li class="notice_notice">ET 의 공지사항 과 이벤트 사항</li>
									<li>
										<form name="searchForm" action="<%=cp%>/notice/list" method="post">
		            						<select name="condition" class="selectField, noticebtn">
		                  						<option value="all" ${condition=="all"?"selected='selected'":""}>모두</option>
		                  						<option value="noticeTitle" ${condition=="noticeTitle"?"selected='selected'":""}>제목</option>
		                  						<option value="noticeContent" ${condition=="noticeContent"?"selected='selected'":""}>내용</option>
		                  						<option value="nCreated" ${condition=="nCreated"?"selected='selected'":""}>등록일</option>
		            						</select>
		          	  							<input type="text" name="keyword" value="${keyword}" class="noticeinput" width="300px">
		            							<button type="button" class="noticebtn" onclick="searchList()">검색</button>
		        					</form>
		        					</li>
								</ul>
							</div>
							
							<div id ="tab-content" style="clear: both; padding: 20px 0px 0px;">
							
							
							<table style="width: 100%; border-spacing: 0px; margin: 0px auto; border-collapse: collapse;">
								<tr class="noticebar">
									<td>번호 </td>
									<td>제목</td>
									<td>등록일</td>
									<td>조회수</td>
									<td>첨부</td>
								</tr>
										
								<tbody class="board-list">			
									<c:forEach var="dto" items="${list}">
										<tr class="question" data-num="${dto.noticeNum}" height="35" style="border-bottom: 1px solid #cccccc;">
											<td>${dto.noticeNum}</td>
											<td style="padding: 5px 0px;"><a href="${articleUrl}&noticeNum=${dto.noticeNum}">${dto.noticeTitle}</a>
												<c:if test="${dto.gap < 1}">
							               			<img src='<%=cp%>/resource/images/new.gif'>
							           			</c:if>
											</td>
											<td>${dto.nCreated}</td>
											<td>${dto.nHitCount}</td>
											<td>	
												<c:if test="${dto.fileCount != 0}">
                        							<a href="<%=cp%>/notice/zipdownload?noticeNum=${dto.noticeNum}"><i class="far fa-file"></i></a>
                   								</c:if>
                   								
                   							</td>
										</tr>
										
									</c:forEach>
									
										
								</tbody>
							</table>
							
							${dataCount==0 ? "게시글이 없습니다.":paging}
							
							</div>
							
							</section>
					</div>
					
				</div>
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->