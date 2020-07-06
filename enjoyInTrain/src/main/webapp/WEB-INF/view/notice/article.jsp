<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/notice.css" type="text/css">
<style type="text/css">
.homepage #main{
   margin-top: 0em;
    padding-top: 0em;
}
</style>
<script type="text/javascript">
function updateNotice() {
	  var q = "noticeNum=${dto.noticeNum}&page=${page}";
	  var url = "<%=cp%>/notice/update?" + q;

	  location.href=url;
	
	}

</script>

<script type="text/javascript">

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
								<h2>Board</h2>
							</header>
							<ul class="style1">
								<li><a href="<%=cp%>/notice/list">공지사항</a></li>
								<li><a href="<%=cp%>/faq/list">FAQ</a></li>

							</ul>
						</section>
					</div>
				
					<div class="9u skel-cell-important">
						<section>
							<header>
								<h2>공지사항</h2>
								<span class="byline">Notice | Check news of new services and events</span>
							</header>
							<div id="namul">
					<form name="noticeForm" method="post" enctype="multipart/form-data">
						<table class="noticearticle">
							<tr class="noticearticletitle">
								<td class="noticearticletitle1">제목  </td>
								<td colspan="3" style="text-align: left;"> ${dto.noticeTitle} </td>
							</tr>
							<tr class="noticearticletitle">
								<td class="noticearticletitle2">등록일</td>
								<td style="text-align: center;">${dto.nCreated}</td>
								<td class="noticearticletitle2">조회수</td>
								<td width="300px" style="text-align: center;">${dto.nHitCount}</td>
								
							</tr>
							<tr style="padding: 5px 5px;">
								<td class="notice-content" colspan="4">${dto.noticeContent}</td>
							</tr>
							
							<c:forEach var="vo" items="${listFile}">
							<tr class="articleReadDto1">
								<td style="width: 400px;" colspan="4">
									<font style="font-weight: 550;">첨부 파일  </font>
									『
									<c:if test="${not empty vo.noticeNum}">
									 <a href="<%=cp%>/notice/download?noticeFileNum=${vo.noticeFileNum}">${vo.originalFilename}</a>
									 </c:if>
									 』
								</td>
							</tr>
							</c:forEach>
							<tr>
								<td colspan="2" style="text-align: left;" class="articleReadDto">
								
								<c:if test="${not empty preReadDto}">
			           		   		<a href="<%=cp%>/notice/article?${query}&noticeNum=${preReadDto.noticeNum}"> ＜＜이전 글 보기  ＿ ${preReadDto.noticeTitle}</a>
			       			 	</c:if>
			       			 	</td>
			       			 	
			       			 	<td colspan="2" style="text-align: right;"  class="articleReadDto">
				        			<c:if test="${not empty nextReadDto}">
				             			 <a href="<%=cp%>/notice/article?${query}&noticeNum=${nextReadDto.noticeNum}">${nextReadDto.noticeTitle} ＿  다음 글 보기 ＞＞ </a>
				        			</c:if>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<button type="button" style="float: right; width: 120px;" class="articlebtn" onclick="javascript:location.href='<%=cp%>/admin/notice/list?${query}';">리스트</button>
								</td>
							</tr>   
						</table>
			        </form>
						
			        </div>
						</section>
					</div>
					
				</div>
			
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->