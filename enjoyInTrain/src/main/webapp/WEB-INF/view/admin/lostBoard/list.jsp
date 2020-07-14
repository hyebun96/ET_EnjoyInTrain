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
						<section>
							<header>
								<h2>유실물</h2>
								<span class="byline">Lost | Lost property</span>
							</header>
							
							
							<div style="clear: both;">
								<ul>
									
									<li>
										<form name="searchForm" action="<%=cp%>/lostBoard/list" method="post">
		            						<select name="condition" class="selectField, noticebtn">
		                  						<option value="all" ${condition=="all"?"selected='selected'":""}>전체</option>
												<option value="lostCreated" ${condition=="lostCreated"?"selected='selected'":""}>작성일</option>
												<option value="lostContent" ${condition=="lostContent"?"selected='selected'":""}>내용</option>
												<option value="lostTitle" ${condition=="lostTitle"?"selected='selected'":""}>제목</option>
		            						</select>
		          	  							<input type="text" name="keyword" value="${keyword}" class="noticeinput" width="300px">
		            							<button type="button" class="btn" onclick="search()" style="background: white; width: 100px; height: 29px; border-radius: 10px; border: 1px solid #cccccc">검색</button>
		        					</form>
		        					</li>
								</ul>
							</div>
							
							<div id ="tab-content" style="clear: both; padding: 20px 0px 0px;">
							
							
							<table style="width: 100%; border-spacing: 0px; margin: 0px auto; border-collapse: collapse;">
								<tr class="noticebar">
									<td>번호 </td>
									<td>제목</td>
									<td>작성자</td>
									<td>작성일</td>
									<td>조회수</td>
								</tr>
										
								<tbody class="board-list">			
									<c:forEach var="dto" items="${list}">
										<tr class="question" data-num="${dto.listNum}" height="35" style="border-bottom: 1px solid #cccccc;">
											<td>${dto.listNum}</td>
											<td style="padding: 5px 0px; text-align: left;"><a href="${articleUrl}&lostNum=${dto.lostNum}">${dto.lostTitle}</a>
												<c:if test="${dto.gap < 1}">
							               			 <img src='<%=cp%>/resource/images/new.gif'>
							           			</c:if>
											</td>
											<td>${dto.crewName}</td>
											<td>${dto.lostCreated}</td>
											<td>${dto.lostHitCount}</td>
											
										</tr>
										
									</c:forEach>
									
										
								</tbody>
							</table>
							<button type="button" onclick="javascript:location.href='<%=cp%>/admin/lostBoard/created';" class="noticebtn" style="float: right; margin-top: 20px;">글쓰기</button>
							${dataCount==0 ? "등록된 게시물이 없습니다.":paging}
							
							</div>
							
							</section>
					</div>
					
				</div>
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->