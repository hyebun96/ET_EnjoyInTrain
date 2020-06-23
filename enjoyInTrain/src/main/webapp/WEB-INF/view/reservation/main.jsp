<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<style>
.tabs li:hover{
		background: gray;
		color: white;
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
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
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
  <div class="modal-content">
    <span class="close">&times;</span>
    <c:forEach var="dto" items="${list}">
    	<button class="stationBtn" value="${dto.sName}">${dto.sName}</button>
    </c:forEach>
  </div>
</div>

<script type="text/javascript">
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

function stationch(){
	var startSt=$("#startSt").val();
	var endSt=$("#endSt").val();
	$("#startSt").val(endSt);
	$("#endSt").val(startSt);
}

function ajaxHTML(url, type, query, selector) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,success:function(data) {
			if($.trim(data)=="error") {
				listPage(1);
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
	$("#tab-general").addClass("active");
	listPage(1);

	$("ul.tabs li").click(function() {
		tab = $(this).attr("data-tab");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});
		
		$("#tab-"+tab).addClass("active");
		
		// listPage(1);
		reloadBoard();
	});
});

// 새로고침
function reloadBoard() {
	var f=document.reservationForm;
	
	listPage(1);
}

function listPage(page) {
	var $tab = $(".tabs .active");
	var tab = $tab.attr("data-tab");
	
	var url="<%=cp%>/reservation/"+tab+"/main";
	var query="";
	var selector = "#tab-content";
	
	ajaxHTML(url, "get", query, selector);
}

</script>
	<!-- Banner -->
		<div id="banner">
			<div class="container">
			</div>
		</div>
	<!-- /Banner -->

	<!-- Main -->
		<div id="page">
				
			<!-- Main -->
			<div id="main" class="container" style="margin-top: 0; padding-top: 0;">
				<div class="row">
					<div class="3u">
						<section class="sidebar">
							<header>
								<h2>Feugiat Tempus</h2>
							</header>
							<ul class="style1">
								<li><a href="#">Maecenas luctus lectus at sapien</a></li>
								<li><a href="#">Etiam rhoncus volutpat erat</a></li>
								<li><a href="#">Donec dictum metus in sapien</a></li>
								<li><a href="#">Nulla luctus eleifend purus</a></li>
								<li><a href="#">Maecenas luctus lectus at sapien</a></li>
							</ul>
						</section>
						<section class="sidebar">
							<header>
								<h2>Nulla luctus eleifend</h2>
							</header>
							<ul class="style1">
								<li><a href="#">Maecenas luctus lectus at sapien</a></li>
								<li><a href="#">Donec dictum metus in sapien</a></li>
								<li><a href="#">Integer gravida nibh quis urna</a></li>
								<li><a href="#">Etiam posuere augue sit amet nisl</a></li>
								<li><a href="#">Mauris vulputate dolor sit amet nibh</a></li>
							</ul>
						</section>
					</div>
				
					<div class="9u skel-cell-important">
						<section>
							<header>
								<form action="" name="reservationForm" method="post">
								<h2>기차예약</h2>
								<span class="byline">reservation</span>
								<div style="width: 800px; ">
									<div style="width: 100%; ">
										<ul class="tabs" style=" text-align:center; width: 100%; border:1px solid gray;">
											<li style=" width:33%; float: left" id="tab-general" data-tab="general" >일반승차권 조회</li>
											<li style="width:33%; float: left" id="tab-group" data-tab="group">단체승차권 조회</li>
											<li style=" width:34%; float: left" id="tab-discount" data-tab="discount">할인승차권 조회</li>
										</ul>
										<table  style="width:100%; border: 1px solid gray;">
											<tr>
												<td colspan="3">
													<div style="float: left;">
														<input type="text" value="" id="startSt">
														<button type="button" class="myBtn" >지역선택</button>
													</div>
													<button style="float: left;" type="button" onclick="stationch();"><-></button> 
													<div>
														<input type="text" value="" id="endSt">
														<button type="button" class="myBtn">지역선택</button>
													</div>
													<select>
														<option>2020/06/22(월)</option>
														<option>2020/06/23(화)</option>
														<option>2020/06/24(수)</option>
													</select>
																					
													<select>
														<c:forEach var="n" begin="0" end="22" step="2">
															<option>${n}</option>
														</c:forEach>
													</select>
														시
													<button>캘린더</button>
												</td>
											</tr>
											<tr>
												<td colspan="3">
													*여정경로  
													<input type="radio">직통
													<input type="radio">환승
													<input type="radio">왕복
												</td>
											</tr>
											<tr>
												<td colspan="3">
													*인원정보 
													<select>
														<option>어른(만 13세 이상)0명</option>
														<option>어른(만 13세 이상)1명</option>
													</select>
													<select>
														<option>어린이(만 6~12세 이상)0명</option>
														<option>어린이(만 6~12세 이상)1명</option>
													</select>
													<select>
														<option>경로(만 65세 이상)0명</option>
														<option>걍로(만 65세 이상)1명</option>
													</select>
													<select>
														<option>중증장애인 0명</option>
														<option>중증장애인 1명</option>
													</select>
													<select>
														<option>경로장애인 0명</option>
														<option>경로장애인 1명</option>
													</select>
												</td>
											</tr>
											<tr>
												<td colspan="3">
													*좌석종류
													<select>
														<option>1인석</option>
														<option>창즉좌석</option>
														<option>내즉좌석</option>
													</select>
													<select>
														<option>일반</option>
														<option>휠체어</option>
													</select>
												</td>
											</tr>
										</table>
									</div>
									<div style="width: 100%;" id="tab-content"></div>
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