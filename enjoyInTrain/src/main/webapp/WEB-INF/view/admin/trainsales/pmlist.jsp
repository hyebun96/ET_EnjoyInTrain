<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.homepage #main{
	margin-top: 0em;
    padding-top: 0em;
}

</style>

<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery.min.js"></script>

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-3d.js"></script>

<script type="text/javascript">


$(function(){
	var url = "<%=cp%>/admin/trainsales/semi";
	$.getJSON(url,function(data){
		// console.log(data);
		
		Highcharts.chart('semiContainer', {
		    chart: {
		        plotBackgroundColor: null,
		        plotBorderWidth: 0,
		        plotShadow: false
		    },
		    title: {
		        text: '지역별매출<br>백분율<br>2020',
		        align: 'center',
		        verticalAlign: 'middle',
		        y: 60
		    },
		    tooltip: {
		        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
		    },
		    accessibility: {
		        point: {
		            valueSuffix: '%'
		        }
		    },
		    plotOptions: {
		        pie: {
		            dataLabels: {
		                enabled: true,
		                distance: -50,
		                style: {
		                    fontWeight: 'bold',
		                    color: 'white'
		                }
		            },
		            startAngle: -90,
		            endAngle: 90,
		            center: ['50%', '75%'],
		            size: '110%'
		        }
		    },
		    series: data
		});
	})
	
});

$(function(){
	var url = "<%=cp%>/admin/trainsales/semi2";
	$.getJSON(url,function(data){
		 console.log(data);
		
		Highcharts.chart('semi2Container', {
		    chart: {
		    	type: 'column'
		    },
		    title: {
		        text: '프로모션별 매출, 2020',
		        align: 'center',
		    },
		    tooltip: {
		        headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
		        pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y.0f}원</b> of total<br/>'
		
		    },
		    accessibility: {
		        announceNewData: {
		            enabled: true
		        }
		    },
		    xAxis: {
		        type: 'category'
		    },
		    yAxis: {
		        title: {
		            text: '금액'
		        }

		    },
		    legend: {
		        enabled: false
		    },
		    plotOptions: {
		        series: {
		            borderWidth: 0,
		            dataLabels: {
		                enabled: true
		            }
		        }
		    },
		    series: data
		});
	})
	
});

</script>

</head>
<body>

<!-- Main -->
<div id="adminpage">
	<div class="trainandtime">
		<a href="<%=cp%>/admin/trainsales/list">기차 매출</a><span>|</span> <a href="<%=cp%>/admin/trainsales/list">프로모션 매출</a>
	</div>
	
	<!-- Main -->
	<div id="main" class="container">
		<div class="row">
			<!-- 메인 내용 -->
			<div>
			
				<section>
					<header>
						<h2>프로모션 매출통계</h2>
					</header>

					<div style="clear: both;">
						<div id="semiContainer" style="width: 650px; height: 600px; float: left; margin: 10px;"></div>	
						<div id="semi2Container" style="width: 700px; height: 600px; float: left; margin: 10px; margin-left: 50px;"></div>	
					</div>
				</section>
			</div>
		</div>
	</div>
	<!-- /Main -->
</div>
<!-- /Main -->




</body>
</html>