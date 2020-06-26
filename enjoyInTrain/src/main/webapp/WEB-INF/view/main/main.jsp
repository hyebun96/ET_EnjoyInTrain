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
							<table class="mainreservation">
								<tr>
									<td>
										<select name="condition" class="selectmainreservation">
		                  					<option value="all" class="selectmainreservation1">출발역</option>
		                  					<option>어디</option>
		                  					<option>어디?</option>
		                  					<option>어디이</option>
		            					</select>
		            				</td>
		            				<td>
										<select name="condition" class="selectmainreservation">
		                  					<option value="all" class="selectmainreservation1">도착역::</option>
		                  					<option>어디</option>
		                  					<option>어디?</option>
		                  					<option>어디이</option>
		            					</select>
		            				</td>
								</tr>
								<tr>
									<td>
										<select name="condition" class="selectmainreservation">
		                  					<option value="all">날짜</option>
		                  					<option>날짜</option>
		                  					<option>날짜아</option>
		                  					<option>나알짜아</option>
		            					</select>
									</td>
									<td>
										<select name="condition" class="selectmainreservation">
		                  					<option value="all">시간</option>
		                  					<option>시간</option>
		                  					<option>시가안</option>
		                  					<option>시이가안</option>
		            					</select>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<button type="button" class="mainreservationbutton" onclick=""> ♬예메 조회 ▷ </button>
									</td>
								</tr>
							</table>
							<table class="mainreservationicon">
								<tr>
									<td>
										<a href="#"><img src="<%=cp%>/resource/images/mainicon1.png" alt="" width="50px;">
										<br>
										예매 조회
										</a>
									</td>
									<td>
										<a href="#"><img src="<%=cp%>/resource/images/mainicon1.png" alt="" width="50px;">
										<br>
										열차 시간표 조회
										</a>
									</td>
									<td>
										<a href="#"><img src="<%=cp%>/resource/images/mainicon1.png" alt="" width="50px;">
										<br>
										 고객센터
										 </a>
									</td>
									<td>
										<a href="#"><img src="<%=cp%>/resource/images/mainicon1.png" alt="" width="50px;">
										<br>
										 유실물 센터
										 </a>
									</td>
								</tr>
							</table>
							
						<div class="mainnotice2">
								<p class="subtitle">Enjoy in Train 공지사항
									<a href="<%=cp%>/notice/list" class="mainnoticebutton"> + 더보기 </a>
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
						</div>
							
						</section>
					</div>
					<div class="3uET">
						<section>
							<div class="maintop1">
							<a href="#"><img src="<%=cp%>/resource/images/mainTrain.gif" alt="" width="600px"></a>
							
							</div>
							
							<div class="mainnotice2">
								<p class="subtitle">뭐넣지 이건	</p>
							<div class="maintop1">
								<table class="z">
									<tr>
										<td>
											aa
										</td>
										<td>
											bb
										</td>
									</tr>
									<tr>
										<td>
											cc
										</td>
										<td>
											dd
										</td>
									</tr>
								</table>
							</div>
						</div>
						
						
						</section>
					</div>

					
				</div>
			</div>
			<!-- /Extra -->
				
			<!-- Main -->
			<div class="maindesign">
					<div class="mainfirst">
							<img src="<%=cp%>/resource/images/ex6.PNG" alt="" width="500" height="500" style="opacity: 1">
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
			
			
			<div class="maindesign1">
					<div class="mainfirst1">
							<a href="<%=cp%>/notice/list" class="button">More ▷</a>
							<img src="<%=cp%>/resource/images/ex5.png" alt="" width="400" height="400" style="opacity: 1">
					</div>
					<div class="mainsecond1">

								<h2><b>즐거운 여행이 더 즐거워지는 방법 !?</b></h2>
								<br>
								기차여행도 내 맘대로 만든다! <br>
								세상 단 하나뿐인 나만의 기차여행을 시작해보자!<br>
								고객이 원하는 여행 콘텐츠를 선택하는 여행상품.<br>
							
					</div>
			</div>
			
			
			
			<div class="maindesign">
					<div class="mainfirst">
							<img src="<%=cp%>/resource/images/ex7.PNG" alt="" width="500" height="500" style="opacity: 1">
							<a href="<%=cp%>/notice/list" class="button">More ▷</a>
					</div>
					<div class="mainsecond">

								<h2><b>청</b>춘은</h2>
								<h2><b>바</b>로</h2>
								<h2><b>지</b>금!</h2>
								<br>
							만25세 ~ 35세 의 청춘들을 위한 할인제도<br>
							-- 기타 : 힘내라 노인<br>
							-- 용기내라 청춘<br>
							-- 굳세워라 중년<br>
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
	
