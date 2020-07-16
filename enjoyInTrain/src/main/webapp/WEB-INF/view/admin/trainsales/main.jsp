<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
   String cp = request.getContextPath();
%>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<link rel="stylesheet" href="<%=cp%>/resource/css/notice.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-3d.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/variable-pie.js"></script>
<script src="https://code.highcharts.com/modules/series-label.js"></script>

<style>
.homepage #main{
	margin-top: 0em;
    padding-top: 0em;
}


.btn{
	width: 80px; 
	height: 30px; 
	margin-top: 20px; 
	background: none;
	border: 1px solid #ccc;
	cursor: pointer;
	border-radius: 5px;

}


</style>

<script type="text/javascript">


$(function(){
	var tab = "${tab}";
	var year="${year}";
	var month="${month}";
	
	$("#tab-"+tab).addClass("active");
	
	var url="<%=cp%>/admin/trainsales/listDay";
	$(".containerList-body").load(url);
	
	chatDay();
	
	$("ul.tabs li").click(function() {
		tab = $(this).attr("data-tab");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});
		$("#tab-"+tab).addClass("active");
		
		$("select[name=searchYear]").val(year);
		$("select[name=searchMonth]").val(month);
		
		if(tab=="listDay") {
			$(".container-searchBody").show();
			$("select[name=searchMonth]").show();		
			chatDay();
			
		} else if(tab=="listMonth") {
			$(".container-searchBody").show();
			$("select[name=searchMonth]").hide();		
			 chatMonth();
			
		} else if(tab=="listYear"){
			$(".container-searchBody").hide();			
			chatYear();
			
		}else if(tab=="person"){
			$(".container-searchBody").hide();			
			$(".containerList-body").hide();			
			person();
		}
		
		var url="<%=cp%>/admin/trainsales/"+tab;

		$(".containerList-body").load(url);
	});
});

function searchList() {
	var $tab = $(".tabs .active");
	var tab = $tab.attr("data-tab");
	var url="<%=cp%>/admin/trainsales/"+tab;
	
	if(tab=="listDay") {
		var year=$("select[name=searchYear]").val();
		var month=$("select[name=searchMonth]").val();
		if(month.length==1) month="0"+month;
		
		url+="?keyword="+year+month;
		$(".containerList-body").load(url);
		
		chatDay();
	} else if(tab=="listMonth") {
		var year=$("select[name=searchYear]").val();
		url+="?keyword="+year;
		$(".containerList-body").load(url);
		
	    chatMonth();
		
	} else if(tab=="listYear"){
		$(".containerList-body").load(url);
		
		chatYear();

	}
}
</script>

<script type="text/javascript">
function chatDay() {
	var year=$("select[name=searchYear]").val();
	var month=$("select[name=searchMonth]").val();
	if(month.length==1) month="0"+month;
	
	var url="<%=cp%>/admin/trainsales/chatDay";
	url+="?keyword="+year+month;
	
	$.getJSON(url, function(data) {
			Highcharts.chart('containerChatBody', {
				chart: {
			        type: 'spline',
			    },				
			    
			    title: {
			        text: '[ 일자별 판매현황 ]'
			    },
			    
			    plotOptions: {
			        spline: {
			            marker: {
			                radius: 4,
			                lineColor: 'red',
			                lineWidth: 1
			            }
			        }
			    },
			    

			    xAxis: {  // x축
					categories : data.categories
			    },


			    yAxis: {  // y축
			        title:{
			        	text:'판매금액'
			        }
			        
			    },
			    series: [
			    	{
			    		marker: {
		    	            symbol: 'diamond',
		    	            radius: 4,
		    	            lineColor: 'black',
			                lineWidth: 1
		    	            
		    	        },
		    	        color: 'orange',
		    	        lineWidth: 5,
			    		name : '일자',
			    		data : data.series
			    		
			    	}]
			});
		
		});	
	
}

function chatMonth() {
	var year=$("select[name=searchYear]").val();
	var url="<%=cp%>/admin/trainsales/chatMonth";
	url+="?keyword="+year;
	
	$.getJSON(url, function(data) {
		Highcharts.chart('containerChatBody', {
			chart: {
				type: 'column'
		    },				
		    
		    title: {
		        text: '[ 월별 판매현황 ]'
		    },

		    xAxis: {  // x축
				type : 'category'
		    },

		    yAxis: {  // y축
		        title:{
		        	text:'판매금액'
		        }
		        
		    },
		    series: [
		    	{
		    		name : '월별',
		    		data : data.series
		    	}]
		});
	
	});		
}

function chatYear() {
	var url="<%=cp%>/admin/trainsales/chatYear";
	
	$.getJSON(url, function(data) {
		Highcharts.chart('containerChatBody', {
			chart: {
				type: 'column'
		    },				
		    
		    title: {
		        text: '[ 년도별 판매현황 ]'
		    },

		    xAxis: {  // x축
				type : 'category'
		    },

		    yAxis: {  // y축
		        title:{
		        	text:'판매금액'
		        }
		        
		    },
		    series: [
		    	{
		    		name : '년도별',
		    		data : data.series
		    	}]
		});
	});			
}

function person() {
	var url="<%=cp%>/admin/trainsales/person";
		console.date;
		$.getJSON(url, function(data) {
		Highcharts.chart('containerChatBody', {
		    chart: {
		        type: 'variablepie',
		      
		    },
		    tooltip: {
		        headerFormat: '',
		        pointFormat: '<span style=" color:{point.color}">\u25CF</span> <b> {point.name}</b><br/>' +
		          '건 수: <b>{point.y}건</b><br/>' +
		          '비 율: <b>{point.z:.2f}%</b><br/>'
		    },
		    title: {
		        text: '[ 승객 유형별 비율 ]'
		    },
		    series: data
		});
	});
	              
}

</script>

<!-- Main -->
<div id="adminpage">
	<div class="trainandtime">
		<a href="<%=cp%>/admin/trainsales/list">기차 매출</a><span>|</span> <a href="<%=cp%>/admin/trainsales/pmlist">프로모션 매출</a>
	</div>

	<!-- Main -->
	<div id="main" class="container">
		<div class="row">
			<!-- 메인 내용 -->
			<div class="9u skel-cell-important">
				<section>
					<header>
						<h2>기차 매출통계<br><br></h2>
					</header>
						<div style="clear: both;">
							<div>
							     <ul class="tabs" style="margin-bottom: 60px;">
									<li id="tab-listDay" data-tab="listDay">일별</li>
									<li id="tab-listMonth" data-tab="listMonth">월별</li>
									<li id="tab-listYear" data-tab="listYear">년별</li>
									<li id="tab-person" data-tab="person">승객 유형별</li>
								</ul>							
							</div>
							
							<div class="containerChat" style="clear: both; margin-top: 15px;">
						    	<div id="containerChatBody"></div>
						    </div>
							<div>
							    <div class="containerList" style="clear:both; padding-top: 15px;" align="center">
							    	<div class="containerList-search"style="height: 50px; line-height: 50px;">
							    	    <div class="container-searchBody">
								    		<select name="searchYear"  style="height: 30px; border-radius: 5px; width: 80px;">
								    			<c:forEach var="i" begin="${year-4}" end="${year}">
								    				<option value="${i}" ${year==i?"selected='selected'":"" }>${i}年</option>
								    			</c:forEach>
								    		</select>
								    		<select name="searchMonth"  style="height: 30px; border-radius: 5px; width: 60px; ">
								    			<c:forEach var="i" begin="1" end="12">
								    				<option value="${i}" ${month==i?"selected='selected'":"" }>${i}月</option>
								    			</c:forEach>
								    		</select>						    		
								    		<button type="button" onclick="searchList()" class="btn">검색</button>						    	    
							    	    </div>
							    	</div>
							    	<div class="containerList-body" style="margin-top: 20px;">
							    	</div>
							    	
							    </div>
							    
						    </div>
						    
						</div>
				</section>
				
			</div>
		</div>
	</div>
	<!-- /Main -->
</div>
<!-- /Main -->