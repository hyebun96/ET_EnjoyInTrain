<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<style>
.homepage #main {
	margin-top: 0em;
	padding-top: 0em;
}
</style>

<script type="text/javascript"
	src="<%=cp%>/resource/se/js/HuskyEZCreator.js" charset="utf-8">
</script>

<script type="text/javascript">
function updateBoard(){
<c:if test ="${sessionScope.crew.crewId == dto.crewId}">
	var q = "num=${dto.fbNum}&page=${page}";
	var url = "<%=cp%>/freeBoard/update?"+q;
	location.href=url;
</c:if>

<c:if test="${sessionScope.crew.crewId!=dto.crewId}">
	alert("게시물을 수정할 수  없습니다.");
</c:if>
}

function deleteBoard() {
<c:if test="${sessionScope.crew.crewId=='admin' || sessionScope.crew.crewId==dto.crewId}">
	var q = "num=${dto.fbNum}&${query}";
	var url = "<%=cp%>/freeBoard/delete?" + q;
	
	if(confirm("위 자료를 삭제 하시 겠습니까 ? ")){
		location.href=url;
	}

</c:if>

<c:if test="${sessionScope.crew.crewId != 'admin' && sessionScope.crew.crewId != dto.crewId}">
	alert("게시물을 삭제할 수 없습니다.");
</c:if>

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
						<span class="byline" style="font-size: 3px; margin-top: 20px;">ffff.</span>
					</header>

					<div>
						<table
							style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
							<tr height="35"
								style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
								<td colspan="2" align="center">${dto.fbTitle}</td>
							</tr>

							<tr height="35" style="border-bottom: 1px solid #cccccc;">
								<td width="50%" align="left" style="padding-left: 5px;">이름
									: ${dto.crewName}</td>
								<td width="50%" align="right" style="padding-right: 5px;">
									${dto.fbCreated} | 조회 ${dto.fbHitCount}</td>
							</tr>

							<tr>
								<td colspan="2" align="left" style="padding: 10px 5px;"
									valign="top" height="200">${dto.fbContent}</td>
							</tr>

							<tr style="border-bottom: 1px solid #cccccc;">
								<td colspan="2" height="40" style="padding-bottom: 15px;"
									align="center">
									<button type="button" class="btn btnSendBoardLike" title="좋아요">
										<i class="fas fa-hand-point-up"></i>&nbsp;&nbsp;<span
											id="boardLikeCount">${dto.fbLikeCount}</span>
									</button>
								</td>
							</tr>

							<c:forEach var="vo" items="${listFile}">
							<tr height="35" style="border-bottom: 1px solid #cccccc;">
								<td colspan="2" align="left" style="padding-left: 5px;">
									첨&nbsp;&nbsp;부 : 
									<a href="<%=cp%>/freeBoard/download?fbFileNum=${vo.fbFileNum}">${vo.originalFileName}</a>
									(<fmt:formatNumber value="${vo.fileSize/1024}" pattern="0.00"/>kByte)	
								</td>
							</tr>
							</c:forEach>

							<tr height="35" style="border-bottom: 1px solid #cccccc;">
								<td colspan="2" align="left" style="padding-left: 5px;">
									이전글 : 
									<c:if test="${not empty preReadDto}">
										<a href="<%=cp%>/freeBoard/article?${query}&num=${preReadDto.fbNum}">${preReadDto.fbTitle}</a>
									</c:if>
								</td>
							</tr>

							<tr height="35" style="border-bottom: 1px solid #cccccc;">
								<td colspan="2" align="left" style="padding-left: 5px;">
									다음글 : 
									<c:if test="${not empty nextReadDto}">
										<a href="<%=cp%>/freeBoard/article?${query}&num=${nextReadDto.fbNum}">${nextReadDto.fbTitle}</a>
									</c:if>
								</td>
							</tr>
						</table>

						<table
							style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
							<tr height="45">
								<td width="300" align="left">
									<c:if
										test="${sessionScope.crew.crewId==dto.crewId}">
										<button type="button" class="btn" onclick="updateBoard();">수정</button>
									</c:if> 
									
									<c:if
										test="${sessionScope.crew.crewId==dto.crewId || sessionScope.crew.crewId=='admin'}">
										<button type="button" class="btn" onclick="deleteBoard();">삭제</button>
									</c:if>
								</td>

								<td align="right">
									<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/freeBoard/list?${query}';">리스트</button>
								</td>
							</tr>
						</table>
					</div>

					<div>
						<table
							style='width: 100%; margin: 15px auto 0px; border-spacing: 0px;'>
							<tr height='30'>
								<td align='left'><span style='font-weight: bold;'>댓글쓰기</span><span>
										- 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가 주세요.</span></td>
							</tr>
							<tr>
								<td style='padding: 5px 5px 0px;'><textarea class='boxTA'
										style='width: 99%; height: 70px;'></textarea></td>
							</tr>
							<tr>
								<td align='right'>
									<button type='button' class='btn btnSendReply'
										style='padding: 10px 20px;'>댓글 등록</button>
								</td>
							</tr>
						</table>
						<div id="listReply"></div>
					</div>
				</section>
			</div>
			<!-- /메인내용 -->

		</div>
	</div>
	<!-- /Main -->

</div>
<!-- /Main -->