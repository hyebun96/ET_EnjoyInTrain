<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<script type="text/javascript">
function suggestList(){
	var f=document.suggestListForm;
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
			<div id="main" class="container" style="margin-top: 0; padding-top: 0;">
				<div class="row">
					<div class="3u">
						<section class="sidebar">
							<header>
								<h2>Feugiat Tempus</h2>
							</header>
							<ul class="style1">
								<li><a href="#">Maecenas luctus lectus at sapien</a></li>
								<li><a href="#">Etiam rhoncus volutpat erat</a></li>
								<li><a href="#">Donec dictum metus in sapien</a></li>
								<li><a href="#">Nulla luctus eleifend purus</a></li>
								<li><a href="#">Maecenas luctus lectus at sapien</a></li>
							</ul>
						</section>
						<section class="sidebar">
							<header>
								<h2>Nulla luctus eleifend</h2>
							</header>
							<ul class="style1">
								<li><a href="#">Maecenas luctus lectus at sapien</a></li>
								<li><a href="#">Donec dictum metus in sapien</a></li>
								<li><a href="#">Integer gravida nibh quis urna</a></li>
								<li><a href="#">Etiam posuere augue sit amet nisl</a></li>
								<li><a href="#">Mauris vulputate dolor sit amet nibh</a></li>
							</ul>
						</section>
					</div>
				
					<div class="9u skel-cell-important">
						<section>
							<header>
								<form action="<%=cp%>/suggest/list" name="suggestListForm" method="post">
								<h2>고객의 소리</h2>
								<span class="byline">어쩌구저쩌구</span>
								<select name="rows" onchange="suggestList();">
									<option value="5" ${rows==5?"selected='selected' ":"" }>5개씩출력</option>
									<option value="10" ${rows==10?"selected='selected' ":"" }>10개씩출력</option>
									<option value="20" ${rows==20?"selected='selected' ":"" }>20개씩출력</option>
								</select>
								<table style="width:900px; text-align:center; border: 1px solid gray;">
									<tr style="background: white;">
										<td style="width: 40px;">번호</td>
										<td style="width: 100px;">카테고리</td>
										<td>제목</td>
										<td style="width: 100px;">작성자</td>
										<td style="width: 100px;">작성일</td>
										<td style="width: 100px;">처리단계</td>
										<td style="width: 50px;">조회수</td>
									</tr>
									<c:forEach var="dto" items="${list}">
										<tr>
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
								<button type="button" onclick="javascript:location.href='<%=cp%>/suggest/created';">글올리기</button>
								</form>
							</header>
						</section>
					</div>
					
				</div>
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->