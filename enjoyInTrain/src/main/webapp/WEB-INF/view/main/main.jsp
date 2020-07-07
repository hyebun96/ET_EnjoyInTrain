<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/notice.css" type="text/css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<style>
.img-box1{
	width: 100px;
  	display: inline-block;
}

.hover-box1{
  text-align:center;
  background:orange;
  color: white; 
}

p.title1{
  color: #fff;
  font-weight: bold;
  font-size: 16px;
}

.box1 .hover-box1{
  position:absolute;
  opacity:0;
  top:410px; left:510px;
  display:flex;
  justify-content: center;
  align-content: center;
  flex-direction: column;
}

.img-box1 .box1:hover .hover-box1{
  opacity:1;
  transform: translate(10px,10px);
}

</style>
<!-- Main -->
<div id="page1">
	<a style="display:scroll;position:fixed; bottom:40px;right:40px; font-size: 15px;" href="#" title="맨위로">
		<img src="<%=cp%>/resource/images/up.png" alt="" width="40px;">
	</a>
	
	<!-- Extra -->
	<div id="marketing" class="container" >
		<div class="row">
			<div class="3uET">
				<section>
					<table class="mainreservation">
						<tr>
							<td>
								<select name="condition" class="selectmainreservation">
                 					<option value="all">출발역</option>
	           					</select>
	           				</td>
	           				<td>
								<select name="condition" class="selectmainreservation">
	                 					<option value="all">도착역</option>
	           					</select>
	           				</td>
						</tr>
						<tr>
							<td style="padding: 20px; padding-top: 15px;" >
								<input type="text" name="startDate" onfocus="(this.type='date')" placeholder="예약날짜" style="width: 200px;">
							</td>
							<td>
								<select name="condition" class="selectmainreservation" style="margin: 0px 20px 0 20px;">
	                 				<option value="all">시간</option>
	           					</select>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<button type="button"  onclick=""  class="mainreservationbuttontd"><i class="fas fa-search"></i>&nbsp;&nbsp;간편조회하기 </button>
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
								<a href="<%=cp%>/qna/main"><img src="<%=cp%>/resource/images/qna.png" alt="" width="60px;">
								<br>
								QnA
								</a>
							</td>
							<td class="mainreservationicon1">
								<a href="<%=cp%>/lostBoard/list"><img src="<%=cp%>/resource/images/freeboard.png" alt="" width="60px;">
								<br>
								 자유게시판
								 </a>
							</td>
							<td class="mainreservationicon1">
								<a href="<%=cp%>/lostBoard/list"><img src="<%=cp%>/resource/images/lost.png" alt="" width="50px;">
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
						<img src="<%=cp%>/resource/images/mainTrain.gif" alt="" width="644px">
					</div>
					<div class="maintop1">
						<table class="z">
							<tr>
								<td class="maintop1_notice1">
									<div class="img-box1 box1" >
										  <img src="<%=cp%>/resource/images/promotion.jpg" width="300px" height="130px">
									</div>														
								</td>
								<td class="maintop1_notice2">
									<img src="<%=cp%>/resource/images/sound.jpg" alt="" width="312" height="130" style="opacity: 1; background-size: cover;" >
									
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
		<img src="<%=cp%>/resource/images/ex11.png" alt="" width="250px;" height="40px;" class="main00010" style="margin-left: -100px;">
	</div>

	<div class="maindesign" style="padding-bottom: 50px;">   <!-- mainhot --> 
		<div class="mainhot">
			<h2 style="float: left; font-weight: bold;">ET HOT PROMOTION</h2>
			<p style="clear:both; float: right; padding-right: 50px;">
				<a href="<%=cp%>/travel/main">더 많은 상품 보기<i class="fas fa-plus"></i></a>
			</p>
		</div>
		
		<c:forEach var="dto"  items="${travelList}">
		<div class="3u"  style="display: inline-block; width: 270px;   margin-left: 13px; margin-right: 13px;">
				<p style="width: 270px; height: 50px; font-weight: bold; ">${dto.pmTitle}</p>
				<p style="color: orange; font-weight: bold;"><fmt:formatNumber value="${dto.pmPrice}" pattern="#,###" /></p>
				<p>
					<a href="<%=cp%>/travel/travel?pmCode=${dto.pmCode}">
						<img src="<%=cp%>/uploads/travel/${dto.saveFileName}" style="width: 270px; height: 200px;">
					</a>
				</p>
		</div>
		</c:forEach>
		
	</div>
</div>
<!-- /Main -->
