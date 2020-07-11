<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<link rel="stylesheet" href="<%=cp%>/resource/css/notice.css" type="text/css">
<style>
.homepage #main{
	margin-top: 0em;
    padding-top: 0em;
}

</style>

<script type="text/javascript">

$(function() {
	var url = "<%=cp%>/admin/trainsales/month";
	
	$.getJSON(url, function(data) {  //java에 데이터 저장해놓은거 가져옴,
	//	console.log(data);
	Highcharts.chart('container', {
	    chart: {
	        renderTo: 'container',
	        type: 'column'
	    },
	    title: {
	        text: '월별 통계'
	    },
	    tooltip: {
	        shared: true
	    },
	    xAxis: {
	        categories: [
	            '1월',
	            '2월',
	            '3월',
	            '4월',
	            '5월',
	            '6월',
	            '7월',
	            '8월',
	            '9월',
	            '10월',
	            '11월',
	            '12월'
	        ],
	        crosshair: true
	    },
	    yAxis: [{
	        title: {
	            text: ''
	        }
	    }, {
	        title: {
	            text: ''
	        },
	        minPadding: 0,
	        maxPadding: 0,
	        max: 100,
	        min: 0,
	        opposite: true,
	        labels: {
	            format: "{value}%"
	        }
	    }],
	    series: [{
	        type: 'count',
	        name: 'count',
	        yAxis: 1,
	        zIndex: 10,
	        baseSeries: 1,
	        tooltip: {
	            valueDecimals: 2,
	            valueSuffix: '건'
	        }
	    }, {
	        name: 'totalPrice',
	        type: 'column',
	        zIndex: 2,
	        data: [755, 222, 151, 86, 72, 51, 36, 10]
	    }]
	});
	
	
)};

)};            

</script>


<!-- Main -->
<div id="adminpage">
	<div class="trainandtime">
		<a href="<%=cp%>/admin/trainsales/list">기차 매출</a><span>|</span> <a href="<%=cp%>/admin/trainsales/list">프로모션 매출</a>
	</div>
	
	<!-- Main -->
	<div id="main" class="container">
		<div class="row">
			<!-- 메인 내용 -->
			<div class="9u skel-cell-important">
			
				<section>
					<header>
						<h2>매출통계</h2>
						<span class="byline">SSSSS</span>
					</header>
					
					<div>
						

					</div>
				</section>
			</div>
		</div>
	</div>
	<!-- /Main -->
</div>
<!-- /Main -->