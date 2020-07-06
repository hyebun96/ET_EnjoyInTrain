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
function deleteNotice() {
	  var q = "noticeNum=${dto.noticeNum}&${query}";
	  var url = "<%=cp%>/admin/notice/delete?" + q;

	  if(confirm("위 자료를 삭제 하시 겠습니까 ? "))
	  	location.href=url;
	}

function updateNotice() {
	  var q = "noticeNum=${dto.noticeNum}&page=${page}";
	  var url = "<%=cp%>/admin/notice/update?" + q;

	  location.href=url;
	
	}

</script>

<script type="text/javascript">

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
								<h2>공지사항</h2>
								<span class="byline">Notice | Check news of new services and events</span>
							</header>
							<div id="namul">
					
					<form name="noticeForm" method="post" enctype="multipart/form-data">
						<table class="noticearticle">
							<tr class="noticearticletitle">
								<td colspan="3" style="text-align: center;"> ${dto.noticeTitle} </td>
							</tr>
							<tr style="width: 865px;">
								<td>작성자 : 관리자</td>
								<td style="clear:both; float: right;">${dto.nCreated}&nbsp;|&nbsp;${dto.nHitCount}</td>
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
									 <a href="<%=cp%>/admin/notice/download?noticeFileNum=${vo.noticeFileNum}">${vo.originalFilename}</a>
									 </c:if>
									 』
								</td>
							</tr>
							</c:forEach>
							<tr>
								<td colspan="2" style="text-align: left;" class="articleReadDto">
								
								<c:if test="${not empty preReadDto}">
			           		   		<a href="<%=cp%>/admin/notice/article?${query}&noticeNum=${preReadDto.noticeNum}"> ＜＜이전 글 보기  ＿ ${preReadDto.noticeTitle}</a>
			       			 	</c:if>
			       			 	</td>
			       			 	
			       			 	<td colspan="2" style="text-align: right;"  class="articleReadDto">
			        			<c:if test="${not empty nextReadDto}">
			             			 <a href="<%=cp%>/admin/notice/article?${query}&noticeNum=${nextReadDto.noticeNum}">${nextReadDto.noticeTitle} ＿  다음 글 보기 ＞＞ </a>
			        			</c:if>
								 
								</td>
							</tr>

							<tr>
								<td colspan="4">
								<button type="button" class="articlebtn" onclick="javascript:location.href='<%=cp%>/admin/notice/list?${query}';">리스트</button>
								<c:if test="${sessionScope.crew.crewId=='a'}">	    
				          			<button type="button" class="articlebtn" onclick="updateNotice();">수정</button>
				          			<button type="button" class="articlebtn" onclick="deleteNotice();">삭제</button>
			          			</c:if>
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