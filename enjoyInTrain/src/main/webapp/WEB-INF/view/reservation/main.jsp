<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<style>

.tabs li{
		font-weight:bold;
		background:#EAEAEA; 
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
  background-color: #fefefe;
  margin: auto;
  padding: 10px;
  border: 1px solid #888;
  width: 400px;
  height: 500px;
}

.modal-content2 {
  background-color: #fefefe;
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

table td{
	padding-left:20px;
	padding-right: 20px;
	padding-top: 10px;
}

</style>

<!-- The Modal -->
<div id="myModal" class="modal">
  <!-- Modal content -->
  <div style="background: #08298A;" class="modal-content">
  	<div style="text-align:center;  margin-bottom: 10px;">
    <span  style="line-height:17px; font-size:17px; color: white; font-weight: bold;">노선선택</span><span class="close">&times;</span>
    </div>
	    <div style="padding:10px; height:90%; background: white;">
	    	<c:set var="i" value="0"/>
		    <table style="height:250px; width: 100%;">
		    	<tr>
		    		<c:forEach var="dto" items="${list}">
		    			<td style=" height:35px; padding:5px; width: 30%;">
		    				<button type="button" value="${dto.sName}" class="stationBtn" style="border:1px solid #D5D5D5;  height:100%; width: 100%;">${dto.sName}</button></td>
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


<script type="text/javascript">
$(function(){
	if(${directRv}==true){
		listPage(1);
	}
});

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

function ajaxHTML(url, type, query, selector) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,success:function(data) {
			if($.trim(data)=="error") {
				listPage(1);
				$(selector).html(data);
				return false;
			}	
			$(selector).html(data);
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

//출발역 도착역 바꾸기
function stationch(){
	var startSt=$("#startSt").val();
	var endSt=$("#endSt").val();
	$("#startSt").val(endSt);
	$("#endSt").val(startSt);
}

function listPage(page) {
	var adult=$("#adult").val();
	var child=$("#child").val();
	var senior=$("#senior").val();
	var disabled1=$("#disabled1").val();
	var disabled2=$("#disabled2").val();
	var cnt=adult+child+senior+disabled1+disabled2;
	var startSt=$("#startSt").val();
	var endSt=$("#endSt").val();
	
	if(cnt==0){
		alert("승객 인원을 1명 이상 선택하십시오.");
		return;
	}
	
	if(startSt==endSt){
		alert("출발역과 도착역이 같습니다	");
		return;
	}
	
	var url="<%=cp%>/reservation/list";
	var query=$("form[name=reservationForm]").serialize();
	var selector = "#listcontent";
	ajaxHTML(url, "post", query, selector);
}



</script>
	<!-- Main -->
		<div id="page" >
				
			<!-- Main -->
			<div id="main" class="container" style="margin-top: 0; padding-top: 0;">
				<div class="row">
					<div class="9u skel-cell-important">
						<section>
							<header>
								<form action="" name="reservationForm" method="post">
								<h2>기차예약</h2>
								<span class="byline">reservation</span>
								<div style="width: 1200px; ">
									<div style="width: 100%; ">
										<ul class="tabs" style="font-size:17px; text-align:center; width: 100%; border:1px solid #D5D5D5;">
											<li style="background:#08298A; color:white; border-right: 1px solid #D5D5D5; line-height:40px; height:40px; width:100%; float: left">승차권 조회</li>
										</ul>
										<table style="font-size:13px; width:100%; border: 1px solid #D5D5D5;">
											<tr>
												<td colspan="3" >
													<div>
														<div style="float: left;">
															<input style="font-size: 13px;" type="text" value="${directRv==true?dto.startSt:firstSt}" name="startSt" id="startSt">
															<button type="button" style="border:none; background: #08298A;" class="myBtn" >
																<i class="fas fa-map-marker-alt" style="margin:4px; font-size: 17px; color: white;"></i>
															</button>
															
														</div>
														<i onclick="stationch();" style="color:gray; margin-left:10px; margin-right:10px; float: left; font-size: 25px;" class="fas fa-exchange-alt"></i>
														<div style="float: left; margin-right: 10px;" >
															<input style="font-size: 13px;" type="text" value="${directRv==true?dto.endSt:lastSt}" name="endSt" id="endSt">
															<button type="button" class="myBtn" style="border:none; background: #08298A;" >
																<i class="fas fa-map-marker-alt" style="margin:4px; font-size: 17px; color: white;"></i>
															</button>
														</div>
														
														<select name="day" id="day" style="height: 28px;">
															<c:forEach var="day" items="${daylist}">
																<option ${day==dto.day?'selected="selected"':''} value="${day}">${day}</option>
															</c:forEach>
														</select>
																						
														<select name="time" id="time" style="height: 28px;">
															<c:forEach var="n" begin="0" end="22" step="2">
																<option ${n==dto.time?'selected="selected"':''}>${n<10?"0":""}${n}</option>
															</c:forEach>
														</select>
															시
													</div>
												</td>
											</tr>
											<tr>
												<td colspan="3">
													<b style="color: #4C4C4C; margin-right: 10px;">· 열차종류</b>  
													<input type="radio" checked="checked" value="all" name="tCategory">전체
													<input type="radio" value="KTX" name="tCategory">KTX
													<input type="radio" value="ITX" name="tCategory">ITX
													<input type="radio" value="mugunghwa" name="tCategory">무궁화
												</td>
											</tr>
											<tr>
											</tr>
											<tr>
												<td colspan="3">
													<b style=" margin-right: 10px; color: #4C4C4C">· 인원정보</b> 
													<select name="adult" id="adult" style="font-size: 13px;">
														<c:forEach var="i" begin="0" end="9" step="1">
															<option ${i==1?'selected="selected"':''} value="${i}">어른(만 13세 이상)${i}명</option>
														</c:forEach>
													</select>
													<select name="child" id="child" style="font-size: 13px;">
														<c:forEach var="i" begin="0" end="9" step="1">
															<option value="${i}">어린이(만 6~12세 이상)${i}명</option>
														</c:forEach>
													</select>
													<select name="senior" id="senior" style="font-size: 13px;">
														<c:forEach var="i" begin="0" end="9" step="1">
															<option value="${i}">경로(만 65세 이상)${i}명</option>
														</c:forEach>
													</select>
													<select name="disabled1" id="disabled1" style="font-size: 13px;">
														<c:forEach var="i" begin="0" end="9" step="1">
															<option value="${i}">중증장애인 ${i}명</option>
														</c:forEach>
													</select>
													<select name="disabled2" id="disabled2" style="font-size: 13px;">
														<c:forEach var="i" begin="0" end="9" step="1">
															<option value="${i}">경증장애인 ${i}명</option>
														</c:forEach>
													</select>
												</td>
											</tr>
											<tr>
											</tr>
											<tr>
												<td style="border-right:1px solid #D5D5D5; padding-bottom: 10px; font-size: 12px; text-align: right;">
													<label>'중증':장애의 정도가 심한 장애인 (구1-3급)</label><br>
													<label>'경증':장애의 정도가 심하지 않은 장애인 (구4-6급)</label>
												</td>
											</tr>
										</table>
									</div>
									<div style="text-align: center; ">
										<button type="button" onclick="listPage(1);" style="font-weight:bold; font-size:15px; border-radius:5px; width:100px; height:30px; background: #08298A; color: white; border: none;">조회하기</button>
									</div>
									<div style="margin-top:20px; width: 100%;" id="listcontent"></div>
								</div>
								</form>
							</header>
						</section>
					</div>
					
				</div>
			</div>
			<!-- Main -->
		</div>
	<!-- /Main -->