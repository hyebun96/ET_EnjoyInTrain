<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/notice.css" type="text/css">

	<!-- Main -->
		<div id="page1">
<a style="display:scroll;position:fixed;bottom:40px;right:40px; font-size: 15px;" href="#" title="맨위로"><img src="<%=cp%>/resource/images/up.png" alt="" width="40px;"></a>
			
			<div class="main0000">
				<img src="<%=cp%>/resource/images/mainlogo0000.png" alt="" width="500px;" height="100px;">
			</div>
			
			
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
									<td colspan="2" class="mainreservationbuttontd">
										<button type="button" class="mainreservationbutton" onclick=""> ♬예메 ▷ </button>
									</td>
								</tr>
							</table>
							<table class="mainreservationicon">
								<tr>
									<td class="mainreservationicon1">
										<a href="#"><img src="<%=cp%>/resource/images/card.png" alt="" width="50px;">
										<br>
										예매 조회
										</a>
									</td>
									<td class="mainreservationicon1">
										<a href="#"><img src="<%=cp%>/resource/images/railway.png" alt="" width="50px;">
										<br>
										열차 시간표 조회
										</a>
									</td>
									<td class="mainreservationicon1">
										<a href="#"><img src="<%=cp%>/resource/images/phone.png" alt="" width="50px;">
										<br>
										 고객센터
										 </a>
									</td>
									<td class="mainreservationicon1">
										<a href="#"><img src="<%=cp%>/resource/images/lost.png" alt="" width="50px;">
										<br>
										 유실물 센터
										 </a>
									</td>
								</tr>
							</table>
							
						<div class="mainnotice2">
							<div class="mainnoticeTitle">
								 <b>Enjoy in Train 공지사항</b>
								<a href="<%=cp%>/notice/list" class="mainnoticebutton"> + 더보기 </a>
							</div>
							<div class="maintop1">
								<table class="mainnoticetable">
									<c:forEach var="dto" items="${list}">
									<tr class="mainnotice">
										<td class="mainnoticetd">
											▶ &nbsp; <a href="${articleUrl}&noticeNum=${dto.noticeNum}">${dto.noticeTitle}</a>
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
							<a href="#"><img src="<%=cp%>/resource/images/mainTrain.gif" alt="" width="644px"></a>
							
							</div>
							
							
							<div class="maintop1">
								<table class="z">
									<tr>
										<td class="maintop1_notice1">
											<img src="<%=cp%>/resource/images/ex7.PNG" alt="" width="312" height="100" style="opacity: 1">
										</td>
										<td class="maintop1_notice2">
											<img src="<%=cp%>/resource/images/call.PNG" alt="" width="312" height="100" style="opacity: 1; background-size: cover;" >
											
										</td>
									</tr>
									
									<tr>
										<td class="maintop1_notice1">
											ET 만의 특별한 할인 제도
											<a href="<%=cp%>/notice/list" class="button1"> + 자세히 보기 </a>
										</td>
										<td class="maintop1_notice2">
											&nbsp; 고객의 소리
											<a href="<%=cp%>/notice/list" class="button1"> + 문의하기 </a>
										</td>
									</tr>
									
								</table>
							</div>

						
						
						</section>
					</div>

					
				</div>
			</div>
			<!-- /Extra -->
				
			<div class="main0001">
				<img src="<%=cp%>/resource/images/ex11.png" alt="" width="250px;" height="40px;" class="main00010">
			</div>
				
			<!-- Main -->

			
			
			<!-- Main -->
			
			
			<div class="maindesign">
					<div class="mainhot">
						ET HOT TOPIC
						<a href="<%=cp%>/notice/list"> + 더보기 </a>
						
					</div>
					<div class="mainfirst">
							<img src="<%=cp%>/resource/images/mainex01.png" alt="" width="200" height="200" style="opacity: 1">
							<br>
							<p><b>ET 와 함께 떠나는 기차 여행</b></p>
							전국 방방곡곡 ! 기차여행
							<div class="mainex0000">
							<a href="<%=cp%>/notice/list" class="button">자세히 보기 ▷</a>
							</div>
					</div>
					
					<div class="mainfirst">
							<img src="<%=cp%>/resource/images/mainex02.png" alt="" width="200" height="200" style="opacity: 1">
							<br>
							<p><b>기차여행 센터</b></p>
							기차여행 센터
							<div class="mainex0000">
							<a href="<%=cp%>/notice/list" class="button">자세히 보기 ▷</a>
							</div>
					</div>
					<div class="mainfirst">
							<img src="<%=cp%>/resource/images/mainex03.png" alt="" width="200" height="200" style="opacity: 1">
							<br>
							<p><b>ET 여행 상품 모음</b></p>
							ET로 떠나는 여행 상품 모음
							<div class="mainex0000">
							<a href="<%=cp%>/notice/list" class="button">자세히 보기 ▷</a>
							</div>
					</div>
					
					<div class="mainfirst">
							<img src="<%=cp%>/resource/images/test01.png" alt="" width="200" height="200" style="opacity: 1">
							<br>
							<p><b>당일 ! 충주 시티 투어</b></p>
							충주의 핫플레이스를 모아모아
							<div class="mainex0000">
							<a href="<%=cp%>/notice/list" class="button">자세히 보기 ▷</a>
							</div>
					</div>
					<div class="mainfirst">
							<img src="<%=cp%>/resource/images/ex7.PNG" alt="" width="200" height="200" style="opacity: 1">
							<br>
							<p><b>힘내라 노인!</b></p>
							ET 할인 제도
							<div class="mainex0000">
							<a href="<%=cp%>/notice/list" class="button">자세히 보기 ▷</a>
							</div>
					</div>
					<div class="mainfirst">
							<img src="<%=cp%>/resource/images/ex1.PNG" alt="" width="200" height="200" style="opacity: 1">
							<br>
							<p><b>나만의 기차여행 만들기</b></p>
							자신만의 여행을 만들어봐요
							<div class="mainex0000">
							<a href="<%=cp%>/notice/list" class="button">자세히 보기 ▷</a>
							</div>
					</div>
					<div class="mainfirst">
							<img src="<%=cp%>/resource/images/test01.png" alt="" width="200" height="200" style="opacity: 1">
							<br>
							<p><b>당일 ! 충주 시티 투어</b></p>
							충주의 핫플레이스를 모아모아
							<div class="mainex0000">
							<a href="<%=cp%>/notice/list" class="button">자세히 보기 ▷</a>
							</div>
					</div>
					<div class="mainfirst">
							<img src="<%=cp%>/resource/images/test01.png" alt="" width="200" height="200" style="opacity: 1">
							<br>
							<p><b>당일 ! 충주 시티 투어</b></p>
							충주의 핫플레이스를 모아모아
							<div class="mainex0000">
							<a href="<%=cp%>/notice/list" class="button">자세히 보기 ▷</a>
							</div>
					</div>
			
			</div>
			
			</div>
			

	<!-- /Main -->
		
		
			
		
	
