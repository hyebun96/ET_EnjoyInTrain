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
		if(${sessionScope.crew.crewId==null}){
			alert("좌석선택은 로그인 후 이용 가능합니다.");
			return;
		}
		
		var trainCode=$(this).closest("tr").children(".tCode").text();  //기차코드 가져오기
		var trainName=$(this).closest("tr").children(".tName").text();  //기차종류 가져오기
		var stTime=$(this).closest("tr").children().children(".stTime").text();  //출발시간 가져오기
		var endTime=$(this).closest("tr").children().children(".endTime").text();  //도착시간 가져오기
		var url="<%=cp%>/reservation/seat";
		var query=$("form[name=reservationForm]").serialize();
		query+="&total=${rsDto.total}";
		query+="&trainCode="+trainCode+"&trainName="+trainName+"&stTime="+stTime+"&endTime="+endTime;
		query+="&day=${rsDto.day}";
		if($(this).val()=='special'){
			query+="&roomGrade="+"특실";
		}else{
			query+="&roomGrade="+"일반실";
		}
		query+="&firstPage=true";
		var selector="#modal-content2";
		ajaxHTML(url, "post", query, selector);
	});
	
	$(".reservationBtn").click(function(){
		var trainCode=$(this).closest("tr").children(".tCode").text();  //기차코드 가져오기
		var trainName=$(this).closest("tr").children(".tName").text();  //기차종류 가져오기
		var stTime=$(this).closest("tr").children().children(".stTime").text();  //출발시간 가져오기
		var endTime=$(this).closest("tr").children().children(".endTime").text();  //도착시간 가져오기
		var query="";
		query+="&total=${rsDto.total}";
		query+="&trainCode="+trainCode+"&trainName="+trainName+"&stTime="+stTime+"&endTime="+endTime;
		query+="&day=${rsDto.day}";
		if($(this).val()=='special'){
			query+="&roomGrade="+"특실";
		}else{
			query+="&roomGrade="+"일반실";
		}
		query+="&directRv=true";
		if(${sessionScope.crew.crewId==null}){
			alert("미등록고객으로 예매를 진행합니다.");
			var f=document.reservationForm;
			f.action="<%=cp%>/reservation/uncrew?"+query;
			f.submit();
			return;
		}else{
			var f=document.reservationForm;
			f.action="<%=cp%>/reservation/confirm?"+query;
			f.submit();
			return;
		}
	});
});



</script>
<div id="myModal2" class="modal">
  <!-- Modal content -->
  <div style="background: #353866;" class="modal-content2" id="modal-content2">
  	
  </div>
</div>

<label style="font-size: 13px;">직통승차권 예약을 원하시는 고객은 예약하기 버튼을 클릭하여 주시기 바랍니다.</label>
<button style=" margin-bottom:10px; font-size: 13px;">KTX 편의시설정보 보기</button>
<table class="timetb" style="text-align:center; border:1px solid #D5D5D5; font-size: 13px;">
	<tr>
		<td style="text-align:left; background: #C1D8F3;" colspan="12"><b>· ${rsDto.startSt}->${rsDto.endSt} ${rsDto.day}</b></td>
	</tr>
	<tr>
		<td style="width: 120px;">구분</td>
		<td style="width: 120px;">열차종류</td>
		<td style="width: 120px;">열차번호</td>
		<td style="width: 120px;">출발역</td>
		<td style="width: 120px;">도착역</td>
		<td style="width: 120px;">특실</td>
		<td style="width: 120px;">일반실</td>
		<td style="width: 120px;">운행시간</td>
		<td style="width: 120px;">운임요금</td>
		<td style="width: 120px;">소요시간</td>
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
				<c:set var="sw" value="true"/>
				<c:forEach items="${special}" var="sp">
					<c:if test="${sw}">
						<c:if test="${sp==dto.trainCode}">
							<button type="button" style="border:none; background: gray; color: white;">&nbsp;&nbsp;매&nbsp;&nbsp;진&nbsp;&nbsp;</button><br>
							<c:set var="sw" value="false"/>
						</c:if>
					</c:if>
				</c:forEach>
				<c:if test="${sw}">
					<button class="reservationBtn" value="special" style="border:none; background: #353866; color: white;">예약하기</button><br>
					<button class="seatBtn" value="special" type="button" style="border:none; background: #C1D8F3; color:black;">좌석선택</button>
				</c:if>
			</td>
			<td>
				<c:set var="sw" value="true"/>
				<c:forEach items="${general}" var="sp">
					<c:if test="${sw}">
						<c:if test="${sp==dto.trainCode}">
							<button type="button" style="border:none; background: gray; color: white;">&nbsp;&nbsp;매&nbsp;&nbsp;진&nbsp;&nbsp;</button><br>
							<c:set var="sw" value="false"/>
						</c:if>
					</c:if>
				</c:forEach>
				<c:if test="${sw}">
					<button class="reservationBtn" value="general" style="border:none; background: #353866; color: white;">예약하기</button><br>
					<button class="seatBtn" value="general" type="button" style="border:none; background: #C1D8F3; color:black;">좌석선택</button>
				</c:if>
			</td>
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
