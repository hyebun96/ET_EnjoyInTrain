<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<style>

.timetb td{
	border: 1px solid #D5D5D5;
	padding: 5px;
}

</style>
<script type="text/javascript">
//좌석모달창
$(function(){
	$(".seatBtn").click(function(){
		var trainCode=$(this).closest("tr").children(".tCode").text();  //기차코드 가져오기
		var trainName=$(this).closest("tr").children(".tName").text();  //기차종류 가져오기
		var stTime=$(this).closest("tr").children().children(".stTime").text();  //출발시간 가져오기
		var endTime=$(this).closest("tr").children().children(".endTime").text();  //도착시간 가져오기
		var url="<%=cp%>/reservation/seat";
		var query=$("form[name=reservationForm]").serialize();
		query+="&roomNum=1&total=${rsDto.total}";
		query+="&trainCode="+trainCode+"&trainName="+trainName+"&stTime="+stTime+"&endTime="+endTime;
		
		var selector="#modal-content2";
		ajaxHTML(url, "post", query, selector);
	});
});



</script>
<div id="myModal2" class="modal">
  <!-- Modal content -->
  <div style="background: #6f047f;" class="modal-content2" id="modal-content2">
  	
  </div>
</div>

<label style="font-size: 13px;">직통승차권 예약을 원하시는 고객은 예약하기 버튼을 클릭하여 주시기 바랍니다.</label>
<button style=" margin-bottom:10px; font-size: 13px;">KTX 편의시설정보 보기</button>
<table class="timetb" style="text-align:center; border:1px solid #D5D5D5; font-size: 13px;">
	<tr>
		<td style="text-align:left; background: #EAEAEA;" colspan="12"><b>· ${rsDto.startSt}->${rsDto.endSt} ${rsDto.day}</b></td>
	</tr>
	<tr>
		<td style="width: 100px;">구분</td>
		<td style="width: 100px;">열차종류</td>
		<td style="width: 100px;">열차번호</td>
		<td style="width: 100px;">출발역</td>
		<td style="width: 100px;">도착역</td>
		<td style="width: 100px;">특실</td>
		<td style="width: 100px;">일반실</td>
		<td style="width: 100px;">예약대기</td>
		<td style="width: 100px;">회원할인</td>
		<td style="width: 100px;">운행시간</td>
		<td style="width: 100px;">운임요금</td>
		<td style="width: 100px;">소요시간</td>
	</tr>
	
	<c:forEach var="dto" items="${list}">
		<tr>
			<td>직통</td>
			<td class="tName">${dto.trainName}</td>
			<td class="tCode">${dto.trainCode}</td>
			<td>
				${dto.departureSt}<br>
				<span class="stTime">${dto.departureTime}</span>
			</td>
			<td>
				${dto.arriveSt}<br>
				<span class="endTime">${dto.arriveTime}</span>
			</td>
			<td>
				<button style="border:none; background: #6f047f; color: white;">예약하기</button><br>
				<button class="seatBtn" type="button" style="border:none; background: #008299; color: white;">좌석선택</button>
			</td>
			<td>
				<button style="border:none; background: #6f047f; color: white;">예약하기</button><br>
				<button class="seatBtn" type="button" style="border:none; background: #008299; color: white;">좌석선택</button>
			</td>
			<td>-</td>
			<td>-</td>
			<td>
				<button>보기</button>
			</td>
			<td>
				<button>보기</button>
			</td>
			<td>
				${dto.totalTime}
			</td>
		</tr>
	</c:forEach>
</table>
