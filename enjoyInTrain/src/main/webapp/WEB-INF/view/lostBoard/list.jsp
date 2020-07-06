<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/lostboardlist.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/notice.css" type="text/css">
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
							<h2>Customer</h2>
						</header>
						<ul class="style1">
							<li><a href="<%=cp%>/qna/main">QnA</a></li>
							<li><a href="<%=cp%>/lostBoard/list">유실물</a></li>
							<li><a href="<%=cp%>/freeBoard/list">자유게시판</a></li>
							<li><a href="<%=cp%>/suggest/list">고객의소리</a></li>
						</ul>
					</section>
				</div>
					
				
					<div class="9u skel-cell-important">
							<header>
								<h2>유실물</h2>
								<span class="byline">Lost | 유실물 신고 게시판</span>
							</header>
							<ul>
								<li id="board_page">${dataCount}개(${page}/${total_page} 페이지)</li>
							</ul>
							<ul id="board_form1">
								<li class="board_form1_1">번호</li>
								<li class="board_form1_2">제목</li>
								<li class="board_form1_3">작성자</li>
								<li class="board_form1_4">작성일</li>
								<li class="board_form1_5">조회수</li>
							</ul>
							<ul id="board_form2"  >
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
						<form name="searchForm" action="<%=cp%>/lostBoard/list" method="post">
							<ul id="board_button">
								<li id="board_button_reset">
									<button type="button" onclick="javascript:location.href='<%=cp%>/lostBoard/list?page=1';" class="noticebtn">새로고침</button>
								</li>
								<li class="board_button_option, noticebtn" >
									<select name="condition" class="selectField, noticebtn">
										<option value="all" ${condition=="all"?"selected='selected'":""}>전체</option>
										<option value="lostCreated" ${condition=="lostCreated"?"selected='selected'":""}>작성일</option>
										<option value="lostContent" ${condition=="lostContent"?"selected='selected'":""}>내용</option>
										<option value="lostTitle" ${condition=="lostTitle"?"selected='selected'":""}>제목</option>
									</select>
								</li>
								<li id="board_button_word">
									<input type="text" name="keyword" value="${keyword}" class="noticeinput">
								</li>
								<li id="board_button_search">
									<button type="button" onclick="search()" class="noticebtn">검색</button>
								</li>
								<li id="board_button_send">
									<button type="button" onclick="javascript:location.href='<%=cp%>/lostBoard/created';" class="noticebtn">글쓰기</button>
								</li>
							</ul>
						</form>
					</div>
					
				</div>
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->