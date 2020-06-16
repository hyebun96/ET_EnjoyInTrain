<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
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
				
					<div class="9u skel-cell-important">
					<ul>
						<li>${dataCount}개(${page}/${total_page} 페이지)</li>
					</ul>
						<ul>
							<li style="float: left; width: 100px">번호</li>
							<li style="float: left; width: 100px">제목</li>
							<li style="float: left; width: 100px">작성자</li>
							<li style="float: left; width: 100px">작성일</li>
							<li style="float: left; width: 100px">조회수</li>
						</ul>
							<ul>
								<c:forEach var="dto" items="${list}">
									<li style="float: left; width: 100px; clear: both;">${dto.listNum}</li>
									<li style="float: left; width: 100px">
										<a href="${articleUrl}&lostNum=${dto.lostNum}">${dto.lostTitle}</a>
										<c:if test="${dto.gap < 1}">
							               <img src='<%=cp%>/resource/images/new.gif'>
							           	</c:if>
									</li>
									<li style="float: left; width: 100px">${dto.crewId}</li>
									<li style="float: left; width: 100px">${dto.lostCreated}</li>
									<li style="float: left; width: 100px">${dto.lostHitCount}</li>
								</c:forEach>
							</ul>
						<ul>
							<li> ${dataCount==0 ? "등록된 게시물이 없습니다.":paging}</li>
					
							<li>
								<select id="condition" style="clear: both; float: left;">
									<option value=""></option>
									<option value="all">전체</option>
									<option value="lostCreated">작성일</option>
									<option value="lostContent">내용</option>
									<option value="lostTitle">제목</option>
									<option value="crewId">작성자</option>
								</select>
							</li>
						
							<li style="float: left;">
								<input type="text" id="keyword">
							</li>
							<li style="float: left;">
								<button type="button" onclick="search()">검색</button>
							</li>
							<li>
								<button type="button" onclick="javascript:location.href='<%=cp%>/lostBoard/created';">글쓰기</button>
							</li>
						</ul>
					</div>
					
				</div>
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->