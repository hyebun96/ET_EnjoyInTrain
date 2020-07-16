<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript">

$(function(){
	$("#myModal2").show();
	$(".dlgClose").click(function(){
		$("#myModal2").hide();
	});
});

$(function(){
	$(".roomBtn").click(function(){
		if($(this).attr('data-select')==1){
			return;
		}
		
		var url="<%=cp%>/booking/seat";
		var roomNum=$(this).val();
		var query=$("form[name=seatForm]").serialize();
		query+="&roomNum="+roomNum;
		query+="&firstPage=false";
		var selector="#modal-content2";
		ajaxHTML(url, "post", query, selector);
	});
});

var cnt=0;
var seatArray = new Array();  //선택한 좌석 배열
$(function(){
	$(".seatClick").click(function(){
		var $i=$(this).parent('div').children('i');
		var colNum=$(this).children(".colNum").val();
		var rowNum=$(this).children(".rowNum").val();
		var seatNum=colNum+rowNum;
		var selectSeat=$("#selectSeat").val();
		
		//선택되어있지않은 좌석 선택시
		if($i.attr('data-select')==0){
			if(cnt>=${map.total}){
				alert("요청하신 승객수 ${map.total}명을 초과하였습니다.");
				return;
			}
			$i.attr('data-select','1');
			$i.attr("class","fas fa-user seatClick");
			$i.css("color","#716B6E");
			if(selectSeat.length==0){
				$("#selectSeat").val(selectSeat+seatNum);
			}else{
				$("#selectSeat").val(selectSeat+","+seatNum);
			}
			cnt=cnt+1;
			
			seatArray[cnt-1]=seatNum;  //선택한 좌석을 배열에 저장
		}  //부모의 i 태그 color 색 바꾸기
		//이미선택되어있는좌석 선택시
		else if($i.attr('data-select')==1){
			$i.attr('data-select','0');
			$i.attr("class","far fa-user");
			$i.css("color","#BDBDBD");
			var seatNumindex=selectSeat.indexOf(seatNum);
			var selectSeat1=selectSeat.substring(0,seatNumindex-1);
			var selectSeat2=selectSeat.substring(seatNumindex+seatNum.length+1);
			if(seatNumindex+seatNum.length==selectSeat.length){
				var selectSeat1=selectSeat.substring(0,seatNumindex-2);
				$("#selectSeat").val(selectSeat1);
			}else{
				$("#selectSeat").val(selectSeat1+selectSeat2);
			}
			cnt=cnt-1;
		}
		return;
	});
});

function confirmBtn(){
	if(seatArray.length!=${map.total}){
		alert("선택하신 좌석수가 요청하신 승객수 ${map.total}명과 일치하지 않습니다.");
		return;
	}	
	
	var roomInfo="${map.roomNum} 호실";
	var seatInfo=$("#selectSeat").val();
	
	if(stateButton=="start") {
		$("#startSeatInfoView").html(roomInfo+","+seatInfo);
		$("form[name=reservationForm] input[name=prStartRoom]").val("${map.roomNum}");
		$("form[name=reservationForm] input[name=prStartTrainSeat]").val(seatInfo);
	} else if(stateButton=="end") {
		$("#endSeatInfoView").html(roomInfo+","+seatInfo);
		$("form[name=reservationForm] input[name=prEndRoom]").val("${map.roomNum}");
		$("form[name=reservationForm] input[name=prEndTrainSeat]").val(seatInfo);
	}
	
	$("#myModal2").hide();
}

</script>
<div style="text-align:center;  margin-bottom: 10px;">
    <span  style="line-height:17px; font-size:17px; color: white; font-weight: bold;">노선선택</span><span class="close dlgClose">&times;</span>
</div>
<div style="font-size:13px; padding:10px; height:90%; background: white; text-align: center;">
<form method="post" name="seatForm">
<input type="hidden" name="startSt" value="${map.startSt}">
<input type="hidden" name="endSt" value="${map.endSt}">
<input type="hidden" name="day" value="${map.day}">
<input type="hidden" name="time" value="${map.time}">
<input type="hidden" name="tCategory" value="${map.tCategory}">
<input type="hidden" name="path" value="${map.path}">
<input type="hidden" name="adult" value="${map.adult}">
<input type="hidden" name="child" value="${map.child}">
<input type="hidden" name="oldman" value="${map.oldman}">
<input type="hidden" name="adult1" value="${map.adult1}">
<input type="hidden" name="child1" value="${map.child1}">
<input type="hidden" name="oldman1" value="${map.oldman1}">
<input type="hidden" name="seat" value="${map.seat}">
<input type="hidden" name="seat2" value="${map.seat2}">
<input type="hidden" name="total" value="${map.total}">
<input type="hidden" name="trainCode" value="${map.trainCode}">
<input type="hidden" name="trainName" value="${map.trainName}">
<input type="hidden" name="stTime" value="${map.stTime}">
<input type="hidden" name="endTime" value="${map.endTime}">
<input type="hidden" name="roomGrade" value="${dto.roomGrade}">
	<div style="text-align: left; margin-bottom: 10px;">
		<span>· 요청하신 <b>승객 ${map.total}명</b>의 원하시는 좌석을 선택하여 주십시오.</span><br>
	    <span>· 발매가 가능한 좌석을 선택하실 수 있습니다.</span><br>
	    <span>· 원하시는 좌석을 선택 후 [선택좌석 선택하기] 버튼을 클릭하시면 선택이 완료됩니다. (복수선택 가능)</span><br>
	    <span>· 원하지 않는 좌석이 선택된 경우에는 좌석을 한번 더 클릭하시면 취소됩니다.</span><br>
	</div>
    <div style="width:100%; height:70px; border: 1px solid gray; white-space:nowrap; overflow-x: scroll;" >
	    <c:forEach items="${list}" var="vo">
	    	<c:set var="sw" value="true"/>
		    	<c:forEach items="${fullSeatlist}" var="fullList">
		    		<c:if test="${sw}">
			    		<c:if test="${fullList==vo.roomNum}">
			    			<button type="button" data-select="1" value="${vo.roomNum}" class="roomBtn" 
					    		style="border-color:#BDBDBD; color:black; margin-top:5px; background:#BDBDBD; font-size: 12px;">
					    		${vo.roomGrade}<br>${vo.roomNum}호차
					    	</button>
					    	<c:set var="sw" value="false"/>
			    		</c:if>
		    		</c:if>
		    	</c:forEach>
		    <c:if test="${sw}">
				<button type="button" value="${vo.roomNum}" class="roomBtn" 
				    style="color:${vo.roomNum==dto.roomNum?'white':'black'}; margin-top:5px; background:${vo.roomNum==dto.roomNum?'#716B6E':'white'}; font-size: 12px;">
				    ${vo.roomGrade}<br>${vo.roomNum}호차
				</button>
		    </c:if>
	    </c:forEach>
    </div>
    <div style="text-align:right; margin: 10px;">
    	<i style=" color:#716B6E; font-size: 25px;" class="fas fa-user seatClick"></i>
    	<span style="font-size: 13px;">선택좌석</span>
    	<i style=" color:#BDBDBD; font-size: 25px;" class="fas fa-user seatClick"></i>
    	<span style="font-size: 13px;">선택불가</span>
    	<i style=" color:#BDBDBD; font-size: 25px;" class="far fa-user"></i>
    	<span style="font-size: 13px;">선택가능</span>
    </div>
    <div>
    	<hr>
		<div style="margin-bottom: 5px;">
		<c:forEach var="i" begin="1" end="${dto.seatRow*dto.seatColumn}" step="1">
			<div style="margin-left:5px; margin-right:5px; font-size:13px; display:inline-block; position: relative; text-align: center;" >
		    	<span class="seatClick"  style="border:none; background:none; line-height:35px; height:35px; width:30px; position: absolute; color: black;">
		    		<b>${i%dto.seatColumn==0?dto.seatColumn:i%dto.seatColumn}</b>
		    		<input type="hidden" class="colNum" value="${i%dto.seatColumn==0?dto.seatColumn:i%dto.seatColumn}">
		    		<c:choose>
    					<c:when test="${Math.floor(i/dto.seatColumn)==0||(i/dto.seatColumn==1)}">
					        <b>A</b>
					        <input type="hidden" class="rowNum" value="A">
					    </c:when>
					    <c:when test="${Math.floor(i/dto.seatColumn)==1||(i/dto.seatColumn==2)}">
					        <b>B</b>
					        <input type="hidden" class="rowNum" value="B">
					    </c:when>
					    <c:when test="${Math.floor(i/dto.seatColumn)==2||(i/dto.seatColumn==3)}">
					        <b>C</b>
					        <input type="hidden" class="rowNum" value="C">
					    </c:when>
					    <c:when test="${Math.floor(i/dto.seatColumn)==3||(i/dto.seatColumn==4)}">
					        <b>D</b>
					        <input type="hidden" class="rowNum" value="D">
					    </c:when>
					</c:choose>
		    	</span>
		    	<c:set var="sw" value="true"/>
		    	<c:forEach items="${rvlist}" var="rv">
		    		<c:if test="${sw}">
			    		<c:if test="${rv==i}">
					    	<i data-select="2" style=" color:#BDBDBD; font-size: 35px;" class="fas fa-user seatClick"></i>
					    	<c:set var="sw" value="false"/>
			    		</c:if>
		    		</c:if>
		    	</c:forEach>
			    <c:if test="${sw}">
					   <i data-select="0" style=" color:#BDBDBD; font-size: 35px;" class="far fa-user seatCk"></i>
			    </c:if>
		    </div>
			<c:if test="${i%dto.seatColumn==0}">
				</div>
				<div style="margin-bottom: 5px;">
			</c:if>
			<c:if test="${i%(dto.seatColumn*2)==0&&i!=dto.seatColumn*dto.seatRow}">
				<p style="margin: 5px; margin-bottom: 10px;">
					<b><span>${map.startSt}</span></b>
					<c:forEach begin="1" end="13" step="1">
						<i style="margin-left: 15px; margin-right: 15px;" class="fas fa-chevron-right"></i>
					</c:forEach>
					<b><span>${map.endSt}</span></b>
				</p>
			</c:if>
	    </c:forEach>
		</div>
		<hr>
    </div>
    <div style="width: 100%;">
		<div style="padding-left:20px; width: 50%; text-align: left; float: left;">
			<b><span style="font-size: 15px;">선택좌석:&nbsp;${map.roomNum}호차&nbsp;<input type="text" readonly="readonly" id="selectSeat" style="border: none; font-weight: bold;" ></span></b>
		</div>
		<div style="padding-right:20px; width: 50%;text-align: right; float: left;">
			<button type="button" onclick="confirmBtn();" style="font-weight:bold; font-size:15px; border-radius:5px; width:150px; height:30px; background: #716B6E; color: white; border: none;">선택좌석 선택하기</button>
		</div>
	</div>
</form>
</div>
