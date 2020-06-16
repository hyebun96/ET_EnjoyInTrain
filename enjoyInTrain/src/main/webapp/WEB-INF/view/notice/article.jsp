<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">


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
								<h2>메뉴창1</h2>
							</header>
							<ul class="style1">
								<li><a href="<%=cp%>/notice/list">공지사항</a></li>
								<li><a href="<%=cp%>/notice/list">공지사항</a></li>
								<li><a href="<%=cp%>/notice/list">공지사항</a></li>
								<li><a href="<%=cp%>/notice/list">공지사항</a></li>
								<li><a href="<%=cp%>/notice/list">공지사항</a></li>
							</ul>
						</section>
						<section class="sidebar">
							<header>
								<h2>메뉴창2</h2>
							</header>
							<ul class="style1">
								<li><a href="<%=cp%>/notice/list">공지사항</a></li>
								<li><a href="<%=cp%>/notice/list">공지사항</a></li>
								<li><a href="<%=cp%>/notice/list">공지사항</a></li>
								<li><a href="<%=cp%>/notice/list">공지사항</a></li>
								<li><a href="<%=cp%>/notice/list">공지사항</a></li>
								
							</ul>
						</section>
					</div>
				
					<div class="9u skel-cell-important">
						<section>
							
							<div id="namul">
					<form name="noticeForm" method="post" enctype="multipart/form-data">
							
							<ul class="notice">
								<li class="notice-qeustion-left">등록일</li>
								<li class="notice-answer-short">${dto.nCreated}</li>
								<li class="notice-qeustion">게시물제목</li>
								<li class="notice-answer-long">${dto.noticeTitle}</li>
								<li class="notice-qeustion-left">조회수</li>
								<li class="notice-answer-short">${dto.nHitCount}</li>
								<li class="notice-content">${dto.noticeContent}</li>
							</ul>	
					
					<c:if test="${sessionScope.member.userId=='admin'}">				    
			          <button type="button" class="btn" onclick="updateBoard();">수정</button>
			       </c:if>
			       <c:if test="${sessionScope.member.userId=='admin'}">				    
			          <button type="button" class="btn" onclick="deleteBoard();">삭제</button>
			       </c:if>
			       
			        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/notice/list?${query}';">리스트</button>
			       
			        </form>
			        </div>
						</section>
					</div>
					
				</div>
			
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->