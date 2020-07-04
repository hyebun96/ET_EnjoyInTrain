<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<style type="text/css">
.homepage #main{
   margin-top: 0em;
    padding-top: 0em;
}

header .byline {
    display: block;
    margin: 0.5em 0 0 0;
    padding: 0 0 0.5em 0;
    text-transform: uppercase;
    font-size: 1.4em;
    padding-bottom: 30px;
}

.listLine{
    height: 40px;
    border-bottom: 1px solid #cccccc;
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
			<div id="main" class="container" style="margin-top: 0; padding-top: 0;">
				<div class="row">

				
					<div class="9u skel-cell-important">
						<section>
							<header>
								<form action="<%=cp%>/admin/suggest/list" name="suggestListForm" method="post">
								<h2>고객의 소리</h2>
								<span class="byline">불편/불만사항,칭찬사례,제안 등의 내용을 작성해주세요.</span>
								<select name="rows" onchange="suggestList();">
									<option value="5" ${rows==5?"selected='selected' ":"" }>5개씩출력</option>
									<option value="10" ${rows==10?"selected='selected' ":"" }>10개씩출력</option>
									<option value="20" ${rows==20?"selected='selected' ":"" }>20개씩출력</option>
								</select>
								<table style="width:900px; padding-top:10px; text-align:center;">
									<tr style="background: white; height:50px; border-bottom:1px solid #cccccc; border-width: 3px;">
										<td style="width: 40px;">번호</td>
										<td style="width: 100px;">카테고리</td>
										<td>제목</td>
										<td style="width: 100px;">작성자</td>
										<td style="width: 100px;">작성일</td>
										<td style="width: 100px;">처리단계</td>
										<td style="width: 50px;">조회수</td>
									</tr>
									<c:forEach var="dto" items="${list}">
										<tr class="listLine">
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
													<a href="${articleUrl}&sgCode=${dto.sgCode}">[re]${dto.sgTitle}</a>
												</c:if>
											</td>
											<td>${dto.crewName}</td>
											<td>${dto.sgCreated}</td>
											<td>${dto.anContent==null?"작성완료":"답변완료"}</td>
											<td>${dto.sgHitCount}</td>
										</tr>
									</c:forEach>
								</table>
								${dataCount==0?"등록된 게시물이 없습니다.":paging}
								<input type="hidden" name="rows" value="${rows}">
								</form>
							</header>
						</section>
					</div>
					
				</div>
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->