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

.listLine{
    height: 35px;
    border-bottom: 1px solid #cccccc;
}

.listLine a{
	margin-left: 30px;
}


</style>
<script type="text/javascript">
function suggestList(){
	var f=document.suggestListForm;
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
			<!-- Main -->
			<div id="main" class="container" style="margin-top: 0; padding-top: 0;">
				<div class="row">
				
					<div class="9u skel-cell-important">
						<section>
							<header>
								<h2>고객의 소리</h2>
								<span class="byline">불편/불만사항,칭찬사례,제안 등의 내용을 작성해주세요.</span>
							</header>
							
								<form action="<%=cp%>/suggest/list" name="suggestListForm" method="post">
								<select name="rows" onchange="suggestList();" class="selectField, noticebtn" style="width: 150px; margin-bottom: 20px;">
									<option value="5" ${rows==5?"selected='selected' ":"" }>5개씩출력</option>
									<option value="10" ${rows==10?"selected='selected' ":"" }>10개씩출력</option>
									<option value="20" ${rows==20?"selected='selected' ":"" }>20개씩출력</option>
								</select>
								<div id ="tab-content" style="clear: both; padding: 20px 0px 0px;">
								<table style="width: 100%; border-spacing: 0px; margin: 0px auto; border-collapse: collapse; text-align: center;">
									<tr class="noticebar">
										<td>번호</td>
										<td>카테고리</td>
										<td>제목</td>
										<td>작성자</td>
										<td>작성일</td>
										<td>처리단계</td>
										<td>조회수</td>
									</tr>
									
									<tbody class="board-list">	
									<c:forEach var="dto" items="${list}">
										<tr class="question" height="35" style="border-bottom: 1px solid #cccccc;">
											<td>${dto.listNum}</td>
											<td>${dto.sgCategory}</td>
											<td style="text-align: left;">
												<c:forEach var="n" begin="1" end="${dto.dept}" >
													&nbsp;&nbsp;&nbsp;
												</c:forEach>
												<c:if test="${dto.dept==0}">
													<a href="${articleUrl}&sgCode=${dto.sgCode}">${dto.sgTitle}</a>
												</c:if>
												<c:if test="${dto.dept!=0}">
													<a href="${articleUrl}&sgCode=${dto.sgCode}">ㄴ [re]${dto.sgTitle}</a>
												</c:if>
											</td>
											<td>${dto.crewName}</td>
											<td>${dto.sgCreated}</td>
											<td>${dto.anContent==null?"작성완료":"답변완료"}</td>
											<td>${dto.sgHitCount}</td>
										</tr>
									</c:forEach>
									</tbody>
									
								</table>
								</div>
								${dataCount==0?"등록된 게시물이 없습니다.":paging}
								<input type="hidden" name="rows" value="${rows}">
								</form>
							
						</section>
					</div>
					
				</div>
			</div>
			<!-- Main -->
			</div>
			