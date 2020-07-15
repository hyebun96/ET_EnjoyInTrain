<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/notice.css" type="text/css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<script type="text/javascript">
function ajaxJSON(url, type, query, fn) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			fn(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}


$(function(){
	var st="";
	var modal = document.getElementById("myModal");
	$(".myBtn").click(function(){
		var span = document.getElementsByClassName("close")[0];
		modal.style.display = "block";
		st=$(this).closest("div").children("input");
		
		// When the user clicks on <span> (x), close the modal
		span.onclick = function() {
		  modal.style.display = "none";
		}
		
		// When the user clicks anywhere outside of the modal, close it
		window.onclick = function(event) {
		  if (event.target == modal) {
		    modal.style.display = "none";
		  }
		}
	});
	
	$(".stationBtn").click(function(){
		var sName=$(this).val();
		$(st).val(sName);
		modal.style.display = "none";
	});
});

$(function(){
	$("#directReservation").click(function(){
		var time=$("#time").val()
		if(time=="시간"){
			alert("시간을 선택해 주십시오.");
			return;
		}
		
		//열차종류=all, 인원정보=어른1
		var f=document.mainRvForm;
		f.submit();
	});
});

</script>

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

/* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  padding-top: 100px; /* Location of the box */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
  background-color: #44565B;
  margin: auto;
  padding: 10px;
  border: 1px solid #888;
  width: 400px;
  height: 500px;
}

.modal-content2 {
  background-color: #44565B;
  margin: auto;
  padding: 10px;
  border: 1px solid #888;
  width: 800px;
  height: 600px;
}

/* The Close Button */
.close {
  color: #aaaaaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}

</style>

<!-- The Modal -->
<div id="myModal" class="modal">
  <!-- Modal content -->
  <div style="background: #44565B;" class="modal-content">
  	<div style="text-align:center;  margin-bottom: 10px;">
    <span  style="line-height:17px; font-size:17px; color: white; font-weight: bold;">노선선택</span><span class="close">&times;</span>
    </div>
	    <div style="padding:10px; height:90%; background: white;">
	    	<c:set var="i" value="0"/>
		    <table style="height:250px; width: 100%;">
		    	<tr>
		    		<c:forEach var="dto" items="${stationList}">
		    			<td style=" height:35px; padding:5px; width: 30%;">
		    				<button type="button" value="${dto.sName}" class="stationBtn" style="background:#e1e8e76e; border:1px solid #D5D5D5;  height:100%; width: 100%;">${dto.sName}</button></td>
		    			<c:set var="i" value="${i+1}"/>
		    			<c:if test="${i%3==0}">
		    				</tr>
		    				<tr>
		    			</c:if>
		    		</c:forEach>
		    	</tr>
		    </table>
	    </div>
  </div>
</div>

<!-- Main -->
<div id="page1">
	<a style="display:scroll;position:fixed; bottom:40px;right:40px; font-size: 35px;" href="#" title="맨위로">
		▲
	</a>
	
	<!-- Extra -->
	<div id="marketing" class="container" >
		<div class="row">
			<div class="3uET">
				<section>
					<form name="mainRvForm" method="post" action="<%=cp%>/reservation/main">
						<input type="hidden" name="directRv" value="true">
						<table class="mainreservation">
							<tr>
								<td>
									<div class="selectmainreservation">
										<input style="width: 81%;" type="text" name="startSt" value="${firstSt}" id="startSt">
										<button type="button" style="border:none; background: #44565B;" class="myBtn">
											<i class="fas fa-map-marker-alt" style="padding:2.5px; padding-right:5px; padding-left:5px; margin:4px; font-size: 17px; color: white;"></i>
										</button>
									</div>
								</td>
								<td>
									<div class="selectmainreservation">
										<input style="width: 81%;" type="text" name="endSt" value="${lastSt}" id="endSt">
										<button type="button" style="border:none; background: #44565B;" class="myBtn">
											<i class="fas fa-map-marker-alt" style="padding:2.5px; padding-right:5px; padding-left:5px; margin:4px; font-size: 17px; color: white;"></i>
										</button>
									</div>
								</td>
							</tr>
							<tr>
								<td style="padding: 20px; padding-top: 15px;" >
									<input type="text" min="${day}" max="${maxday}" name="day" onfocus="(this.type='date')" value="${day}" placeholder="예약날짜" style="width: 200px;">
								</td>
								<td>
		           					<select  name="time" id="time" style="margin: 0px 20px 0 20px; height: 30px;" class="selectmainreservation">
										<option value="시간">시간</option>
										<c:forEach var="n" begin="0" end="22" step="2">
											<option>${n<10?"0":""}${n}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<button type="button" id="directReservation" onclick=""  class="mainreservationbuttontd"><i class="fas fa-search"></i>&nbsp;&nbsp;간편조회하기 </button>
								</td>
							</tr>
						</table>
					</form>
					<table class="mainreservationicon">
						<tr>
							<td class="mainreservationicon1">
								<c:if test="${not empty sessionScope.crew}">
								<a href="<%=cp%>/reservation/detail" style="font-size: 13px;"><img src="<%=cp%>/resource/images/card.png" alt="" width="75px;">
								<br>
								예매 조회
								</a>
								</c:if>
								<c:if test="${empty sessionScope.crew}">
								<a href="<%=cp%>/reservation/uncrew2" style="font-size: 13px;"><img src="<%=cp%>/resource/images/card.png" alt="" width="75px;">
								<br>
								예매 조회
								</a>
								</c:if>
							</td>
							<td class="mainreservationicon1">
								<a href="<%=cp%>/qna/main" style="font-size: 13px;"><img src="<%=cp%>/resource/images/qna.png" alt="" width="80px;">
								<br>
								QnA
								</a>
							</td>
							<td class="mainreservationicon1">
								<a href="<%=cp%>/freeBoard/list" style="font-size: 13px;"><img src="<%=cp%>/resource/images/freeboard.png" alt="" width="80px;">
								<br>
								 자유게시판
								 </a>
							</td>
							<td class="mainreservationicon1">
								<a href="<%=cp%>/lostBoard/list" style="font-size: 13px;"><img src="<%=cp%>/resource/images/lost.png" alt="" width="70px;">
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
									<a href="<%=cp%>/notice/article?page=1&noticeNum=11" class="button1"> + 자세히 보기 </a>
								</td>
								<td class="maintop1_notice2">
									&nbsp; 고객의 소리
									<a href="<%=cp%>/suggest/list" class="button1"> + 문의하기 </a>
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
