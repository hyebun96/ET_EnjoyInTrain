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
								<h2>메뉴창1</h2>
							</header>
							<ul class="style1">
								<li><a href="<%=cp%>/notice/list">전체보기</a></li>
								<li><a href="<%=cp%>/notice/list">공지사항</a></li>
								<li><a href="<%=cp%>/notice/list">이벤트</a></li>
							</ul>
						</section>
					</div>
				
					<div class="9u skel-cell-important">
						<section>
							<header>
								<h2>공지사항</h2>
								<span class="byline">Notice | Check news of new services and events</span>
							</header>
							<div>
							
							 <div align="right">
							 
				<form name="searchForm" action="<%=cp%>/notice/list" method="post">
		            	<select name="condition" class="selectField">
		                  <option value="all" ${condition=="all"?"selected='selected'":""}>모두</option>
		                  <option value="noticeTitle" ${condition=="noticeTitle"?"selected='selected'":""}>제목</option>
		                  <option value="noticeContent" ${condition=="noticeContent"?"selected='selected'":""}>내용</option>
		                  <option value="nCreated" ${condition=="nCreated"?"selected='selected'":""}>등록일</option>
		            	</select>
		          	  <input type="text" name="keyword" value="${keyword}" class="boxTF">
		            	<button type="button" class="btn" onclick="searchList()">검색</button>
		        </form>
							 </div>
							</div>
							<ul class="noticebar">
								<li style="float: left; width: 100px;">번호</li>
								<li style="float: left; width: 100px;">제목</li>
								<li style="float: left; width: 100px;">등록일</li>
								<li style="float: left; width: 100px;">조회수</li>
								<li style="float: left; width: 100px;">첨부</li>
							</ul>
							<c:forEach var="dto" items="${list}">
							<ul style="clear: both;">
								<li style="width: 100px; float: left;">${dto.noticeNum}</li>
								<li style="width: 100px; float: left;"><a href="${articleUrl}&noticeNum=${dto.noticeNum}"> ${dto.noticeTitle}</a>
										<c:if test="${dto.gap < 1}">
							               <img src='<%=cp%>/resource/images/new.gif'>
							           	</c:if>
								</li>
								<li style="width: 100px; float: left;">${dto.nCreated}</li>
								<li style="width: 100px; float: left;">${dto.nHitCount}</li>
								<li style="width: 100px; float: left;">
									<c:if test="${dto.fileCount != 0}">
                        				<a href="<%=cp%>/notice/zipdownload?noticeNum=${dto.noticeNum}"><i class="far fa-file"></i></a>
                   					</c:if>
                   				</li>
							</ul>
							</c:forEach>
							${dataCount==0 ? "게시글이 없습니다.":paging}
							<c:if test="${sessionScope.crew.crewId=='a'}">
		         				 <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/notice/created';">글올리기</button>
		         			</c:if>
						</section>
					</div>
					
				</div>
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->