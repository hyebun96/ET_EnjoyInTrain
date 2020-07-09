<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/trainlist.css" type="text/css">
<style>
	#insertTrain_dialog input {
		width: 100px;
		margin-right: 5px;
	}
</style>

<script type="text/javascript">
$(function() {
	$("#insertTrain").click(function() {
		$("form[name=insertTrainForm]").each(function () {
			this.reset();
		});
		
		$("#insertTrain_dialog").dialog({
			modal: true,
			height: 400,
			width: 600,
			title: '기차 추가',
			close: function (event, ui) {
			}
		})
		
	});
});

$(function () {
	$("body").on("click", ".nextButton", function () {
		var $nextinput = $(this).closest("table").next();
		
		var isVisible = $nextinput.is(':visible');
		
		if(isVisible){
			$nextinput.hide();
		} else{
			$nextinput.show();
			
			var n = document.insertTrainForm.trainRoomCount.value;
			var s="";
			for(var i=1; i<=n; i++) {
				s+="<tr><td><label> 호실 : <input type='text' name='roomNums' value='"+i+"' readonly='readonly' ></label></td>";
				s+="<td id='roomSetting_grade'><select name='roomNames' >";
				s+="<option value='일반'>일반</option><option value='특실'>특실</option></select></td>"
				s+="<td><input type='text' name='seatRows'  placeholder='좌석(행)'></td>"
				s+="<td><input type='text' name='seatColumns'  placeholder='좌석(열)'></td></tr>"
			}
			s+="<tr><td><button type='button' onclick='send();'>등록</button></td></tr>";
			$("#roomSetting").html(s);
			
		}
	});
});

function send() {
    var f = document.insertTrainForm;

	var str = f.trCategory.value;
    if(!str) {
        alert("기차 코드를 입력하세요. ");
        f.trainCode.focus();
        return false;
    }
	


	f.action="<%=cp%>/admin/train/created";
	
	f.submit();

}
</script>


	<!-- Main -->
		<div id="adminpage">
			<div class="trainandtime">
				<a href="<%=cp%>/admin/train/list">기차관리</a> <span>|</span> <a href="<%=cp%>/admin/timetable/main">시간표관리</a>
			</div>
				
					<div class="trainandtime_train">
						
						<ul id="train_form1">
							<li class="train_subnum">번호</li>
							<li class="train_subwriter">기차종류</li>
							<li class="train_subcreated">칸갯수</li>
							<li class="train_subcount">좌석갯수</li>
						</ul>
						<ul id="train_form2"  >
							<c:forEach var="dto" items="${list}">
								<li id="train_subnum_list">${dto.trainSeq}</li>
								<li id="train_subwriter_list">${dto.trCategory}</li>
								<li id="train_subcreated_list">${dto.trainRoomCount}</li>
								<li id="train_subcount_list">${dto.trainSeatCount}</li>
							</c:forEach>
						</ul>
						<form name="searchForm" action="<%=cp%>/admin/train/list" method="post">
							<ul id="train_button">
								<li id="train_button_send">
									<button type="button" id="insertTrain">기차추가</button>
								</li>
								<li id="train_button_reset">
								<button type="button" onclick="javascript:location.href='<%=cp%>/admin/train/list?page=1';">새로고침</button>
								</li>
							</ul>
						</form>
						<ul>
							<li style="clear: both;" id="train-sample"> ${trainCount==0 ? "등록된 게시물이 없습니다.":paging}</li>
						</ul>
						
					</div>
					
				</div>


	<!-- /Main -->
	<div id="insertTrain_dialog">
		<form name="insertTrainForm" method="post">
			<div>
				<table>
					<tr>
						<td id="train_question">기차종류</td>
						<td id="train_answer"><input type="text" name="trCategory" ></td>
						<td id="train_question">칸수</td>
						<td id="train_answer">
							<select name="trainRoomCount">
								<c:forEach var="n" begin="0" end="20">
									<option value="${n}">${n}칸</option><
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td colspan="5"><button type="button" class="nextButton">다음 ></button></td>
					</tr>
				</table>
				<table id="roomSetting"></table>
			</div>
		</form>
		
		
	</div>
	