<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/notice.css" type="text/css">
<!-- Banner -->
		<div id="banner">
			<div class="container">
			</div>
		</div>
	<!-- /Banner -->

	<!-- Main -->
		<div id="page">

			<!-- Extra -->
			<div id="marketing" class="container" >
				<div class="row">
					<div class="3uET">
						<section>
							<header>
								<h2>New Promotion</h2>
							</header>
							<p class="subtitle">다양한 프로모션 상품정보를 확인해보세요!
							<a href="<%=cp%>/main" class="button">More ▷</a>
							</p>
							<div class="maintop1">
							<a href="#"><img src="<%=cp%>/resource/images/ex2.PNG" alt="" width="260px;"></a>
							</div>
						</section>
					</div>
					<div class="3uET">
						<section>
							<header>
								<h2>Notice or Event</h2>
							</header>
							<p class="subtitle">Enjoy in Train 공지사항
							<a href="<%=cp%>/main" class="button">More ▷</a>
							</p>
							<div class="maintop1">
							<table class="mainnoticetable">
							<c:forEach var="dto" items="${list}">
								<tr class="mainnotice">
									<td>
											▷ <a href="${articleUrl}&noticeNum=${dto.noticeNum}">${dto.noticeTitle}</a>
									</td>
								</tr>
							</c:forEach>
							</table>
							</div>
						</section>
					</div>
					<div class="3uET">
						<section>
							<header>
								<h2>Communication</h2>
							</header>
							<p class="subtitle">실시간 지역별 추천 오픈 채팅방 ! 
							<a href="<%=cp%>/main" class="button">More ▷</a>
							</p>
							<div class="maintop1">
							<a href="#"><img src="<%=cp%>/resource/images/ex4.PNG" alt="" width="260px"></a>
							
							</div>
						</section>
					</div>
					
				</div>
			</div>
			<!-- /Extra -->
				
			<!-- Main -->
			<div class="maindesign">
					<div class="mainfirst">
							<img src="<%=cp%>/resource/images/ex3.PNG" alt="" width="600" height="600" style="opacity: 0.8">
							<a href="<%=cp%>/notice/list" class="button">More ▷</a>
					</div>
					<div class="mainsecond">

								<h2><b>(레일티켓)한복입고 떠나는 경복궁/북촌 한옥마을 투어</b></h2>
								<br>
							한복입고 떠다는 경복궁 ' 한옥마을 투어<br>
							-- KTX왕복승차권 + 한복남 한복 대여권이 결합된 자유여행상품입니다.<br>
							-- 한복대여권 수량은 열차표를 구매하시는 고객님의 수량과 똑같이 구매하셔야 합니다.<br>
							-- 추천 코스 밑 자세한 내용은 해당 글 을 통해 확인 가능합니다.<br>
					</div>
			</div>
			
			
			<!-- Main -->
			
			
			<div class="6u">
				<div class="3u">a
			
			
			
			
			
			<div class="maindesign">
					<div class="mainfirst">
							<img src="<%=cp%>/resource/images/ex3.PNG" alt="" width="400" height="400" style="opacity: 0.8">
							<a href="<%=cp%>/notice/list" class="button">More ▷</a>
					</div>
					<div class="mainsecond">
						@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
					</div>
					
					
					<div class="mainthird">
						##########################################
					</div>
			</div>
			
				</div>
			</div>
		</div>
	<!-- /Main -->
		
		
			
			
	<!-- Featured -->
		<div id="featured">
			<div class="container">
				<div class="row">
					<section class="4u">
						<div class="box">
							<a href="#" class="image left"><img src="<%=cp%>/resource/images/pics04.jpg" alt=""></a>
							<h3>Etiam posuere augue</h3>
							<p>Donec nonummy magna quis risus eleifend. </p>
							<a href="#" class="button">More ▷</a>
						</div>
					</section>
					<section class="4u">
						<div class="box">
							<a href="#" class="image left"><img src="<%=cp%>/resource/images/pics05.jpg" alt=""></a>
							<h3>Etiam posuere augue</h3>
							<p>Donec nonummy magna quis risus eleifend. </p>
							<a href="#" class="button">More ▷</a>
						</div>
					</section>
					<section class="4u">
						<div class="box">
							<a href="#" class="image left"><img src="<%=cp%>/resource/images/pics06.jpg" alt=""></a>
							<h3>Etiam posuere augue</h3>
							<p>Donec nonummy magna quis risus eleifend. </p>
							<a href="#" class="button">More ▷</a>
						</div>
					</section>
				</div>
				<div class="divider"></div>
			</div>
		</div>
	<!-- /Featured -->
	
	<!-- Footer -->
		
			<div class="container">
				<div class="row">
					<div class="3u">
						<section>
							<h2>Maecenas lectus</h2>
							<div class="balloon">
								<blockquote>&ldquo;&nbsp;&nbsp;Donec leo, vivamus ullamcorper fermentum nibh in augue pulvinar ullamcorper metus praesent a lacus at urna congue ullamcorper  rutrum.&nbsp;&nbsp;&rdquo;<br>
									<br>
									<strong>&ndash;&nbsp;&nbsp;John Smith</strong></blockquote>
							</div>
							<div class="ballon-bgbtm">&nbsp;</div>
						</section>
					</div>
					<div class="3u">
						<section>
							<h2>Donec dictum</h2>
							<ul class="default">
								<li>
									<h3>Mauris vulputate dolor sit amet</h3>
									<p><a href="#">Donec leo, vivamus fermentum nibh in augue praesent a lacus at urna congue rutrum.</a></p>
								</li>
								<li>
									<h3>Fusce ultrices fringilla metus</h3>
									<p><a href="#">Donec leo, vivamus fermentum nibh in augue praesent a lacus at urna congue rutrum.</a></p>
								</li>
								<li>
									<h3>Donec dictum metus in sapien</h3>
									<p><a href="#">Donec leo, vivamus fermentum nibh in augue praesent a lacus at urna congue rutrum.</a></p>
								</li>
							</ul>
						</section>
					</div>
					<div class="3u">
						<section>
							<h2>Nulla leifend</h2>
							<p>Donec placerat odio vel elit. Nullam ante orci, pellentesque eget, tempus quis, ultrices in, est. Curabitur sit amet nulla. Nam in massa. Sed vel tellus. Curabitur sem urna, consequat.</p>
							<ul class="style5">
								<li><a href="#"><img src="<%=cp%>/resource/images/pics07.jpg" alt=""></a></li>
								<li><a href="#"><img src="<%=cp%>/resource/images/pics08.jpg" alt=""></a></li>
								<li><a href="#"><img src="<%=cp%>/resource/images/pics09.jpg" alt=""></a></li>
								<li><a href="#"><img src="<%=cp%>/resource/images/pics10.jpg" alt=""></a></li>
								<li><a href="#"><img src="<%=cp%>/resource/images/pics11.jpg" alt=""></a></li>
								<li><a href="#"><img src="<%=cp%>/resource/images/pics12.jpg" alt=""></a></li>
							</ul>
							<a href="#" class="button">More Collections</a>
						</section>
					</div>
					<div class="3u">
						<section>
							<h2>Luctus eleifend</h2>
							<p><strong>Aliquam erat volutpat. Pellentesque tristique ante ut risus. </strong></p>
							<p>Quisque dictum. Integer nisl risus, sagittis convallis, rutrum id, elementum congue, nibh. Suspendisse dictum porta lectus. Donec placerat odio vel elit.</p>
							<p>Donec placerat odio vel elit. Nullam ante orci, pellentesque eget, tempus quis, ultrices in, est. Curabitur sit amet nulla. Nam in massa. Sed vel tellus. Curabitur sem urna, consequat.</p>
							<a href="#" class="button">More Collections</a>
						</section>
					</div>
				</div>
			</div>
	<!-- /Footer -->
	
