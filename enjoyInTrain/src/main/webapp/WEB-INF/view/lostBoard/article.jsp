<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">
function deleteLostBoard() {
	<c:if test="${sessionScope.crew.crewId=='admin' || sessionScope.crew.crewId==dto.crewId}">
		var q = "lostNum=${dto.lostNum}&${query}";
		var url = "<%=cp%>/lostBoard/delete?"+q;
		
		if(confirm("위 자료를 삭제 하시겠습니까?")){
			location.href=url;
		}
	</c:if>
	<c:if test="${sessionScope.crew.crewId!='admin' && sessionScope.crew.crewId!=dto.crewId}">
	alert("게시물을 삭제할 수  없습니다.");
</c:if>
}	

function updateLostBoard() {
	<c:if test="${sessionScope.crew.crewId==dto.crewId}">
		var q = "lostNum=${dto.lostNum}&page=${page}";
		var url = "<%=cp%>/lostBoard/update?"+q;
		
		location.href = url;
	</c:if>
	
	<c:if test="${sessionScope.crew.crewId!=dto.crewId}">
		alert("게시물을 수정할 수  없습니다.");
	</c:if>
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
				<form action="" name="lostBoardForm" method="post" enctype="multipart/form-data">
					<div class="9u skel-cell-important">
						<ul>
							<li style="float: left; width: 100px; clear: both;">제목</li>
							<li style="float: left; width: 100px">${dto.lostTitle}</li>
							<li style="float: left; width: 100px; clear: both;">작성자</li>
							<li style="float: left; width: 100px">${dto.crewId}</li>
							<li style="float: left; width: 100px; clear: both;">${dto.lostCreated} | 조회 ${dto.lostHitCount}</li>
							<li style="float: left; width: 100px; clear: both;">내용</li>
							<li style="float: left;">
								${dto.lostContent}
								<c:if test="${dto.saveFileName!=null}">
									<img src="<%=cp%>/uploads/lostBoard/${dto.saveFileName}">
								</c:if>
							</li>
				
							
						</ul>
						<ul>
							<li>
								이전글 : 
									<c:if test="${not empty preReadDto}">
										<a href="<%=cp%>/lostBoard/article?${query}&lostNum=${preReadDto.lostNum}">${preReadDto.lostTitle}</a>
									</c:if>
							</li>
							<li>
								다음글 : 
									<c:if test="${not empty nextReadDto}">
										<a href="<%=cp%>/lostBoard/article?${query}&lostNum=${nextReadDto.lostNum}">${nextReadDto.lostTitle}</a>
									</c:if>
							</li>
						</ul>
					</div>
					<div>
						<ul>
							<li style="clear: both;">
								<button type="button" onclick="javascript:location.href='<%=cp%>/lostBoard/created';">글쓰기</button>
								<button type="button" onclick="javascript:location.href='<%=cp%>/lostBoard/list';">목록으로</button>
								<c:if test="${sessionScope.crew.crewId=='admin' || sessionScope.crew.crewId==dto.crewId}">
									<button type="button" onclick="updateLostBoard();">수정하기</button>
									<button type="button" onclick="deleteLostBoard();">삭제하기</button>
								</c:if>
							</li>
						</ul>
					</div>
				</form>

					
				</div>
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->