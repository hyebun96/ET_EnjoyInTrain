<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/lostboardlist.css" type="text/css">
<style type="text/css">
.homepage #main{
   margin-top: 0em;
    padding-top: 0em;
}
</style>
<script type="text/javascript">

	function search() {
		var f=document.searchForm;
		f.submit();
	}
</script>


	<!-- Main -->
		<div id="adminpage">
				<div class="trainandtime">
					<a href="<%=cp%>/admin/notice/list">공지사항</a> <span>|</span> <a href="<%=cp%>/admin/qna/main">QnA</a>
					<span>|</span> <a href="<%=cp%>/admin/faq/list">FAQ</a> <span>|</span> <a href="<%=cp%>/admin/lostBoard/list">유실물</a>
					<span>|</span> <a href="<%=cp%>/admin/freeBoard/list">자유게시판</a> <span>|</span> <a href="<%=cp%>/admin/suggest/list">고객의소리</a>
				</div>
			<!-- Main -->
			<div id="main" class="container">
				<div class="row">
				
					<div class="9u skel-cell-important">
						<header>
							<h2>유실물</h2>
							<span class="byline">Lost things</span>
						</header>
					
					<form name="searchForm" action="<%=cp%>/admin/lostBoard/list" method="post">
							<ul id="board_button" style="padding-bottom: 20px;">
								<li id="board_button_option">
									<select name="condition" style="clear: both; float: left; height: 29px;">
										<option value="all" ${condition=="all"?"selected='selected'":""}>전체</option>
										<option value="lostCreated" ${condition=="lostCreated"?"selected='selected'":""}>작성일</option>
										<option value="lostContent" ${condition=="lostContent"?"selected='selected'":""}>내용</option>
										<option value="lostTitle" ${condition=="lostTitle"?"selected='selected'":""}>제목</option>
									</select>
								</li>
								<li id="board_button_word">
									<input type="text" name="keyword" value="${keyword}">
								</li>
								<li id="board_button_search">
									<button type="button" onclick="search()"
									style="background: white; width: 100px; height: 29px; border-radius: 10px; border: 1px solid #cccccc">검색</button>
								</li>
							</ul>
						</form>	
					
					
							<ul>
								<li id="board_page">${dataCount}개(${page}/${total_page} 페이지)</li>
							</ul>
							<ul id="board_form1">
								<li id="board_subnum">번호</li>
								<li id="board_subtitle">제목</li>
								<li id="board_subwriter">작성자</li>
								<li id="board_subcreated">작성일</li>
								<li id="board_subcount">조회수</li>
							</ul>
							<ul id="board_form2" >
								<c:forEach var="dto" items="${list}">
									<li id="board_subnum_list">${dto.listNum}</li>
									<li id="board_subtitle_list">
										<a href="${articleUrl}&lostNum=${dto.lostNum}">${dto.lostTitle}</a>
										<c:if test="${dto.gap < 1}">
							               <img src='<%=cp%>/resource/images/new.gif'>
							           	</c:if>
									</li>
									<li id="board_subwriter_list">${dto.crewId}</li>
									<li id="board_subcreated_list">${dto.lostCreated}</li>
									<li id="board_subcount_list">${dto.lostHitCount}</li>
								</c:forEach>
							</ul>
							<ul>
								<li style="clear: both;" id="board-sample"> ${dataCount==0 ? "등록된 게시물이 없습니다.":paging}</li>
							</ul>
						
					</div>
					
				</div>
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->