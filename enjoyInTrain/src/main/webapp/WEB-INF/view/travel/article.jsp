<%@page import="org.springframework.data.mongodb.core.aggregation.ArrayOperators.In"%>
<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<link rel="stylesheet" href="<%=cp%>/resource/jquery/css/smoothness/jquery-ui.min.css" type="text/css">

<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/js/util-jquery.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/js/util.js"></script>
<%
	request.setCharacterEncoding("utf-8");

	Calendar cal = Calendar.getInstance();
	
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH) + 1;
	
	String sy = request.getParameter("year");
	String sm = request.getParameter("month");
	
	if(sy!=null){
		year = Integer.parseInt(sy);
	}
	if(sm!=null){
		year = Integer.parseInt(sm);
	}
	
	cal.set(year, month-1, 1);
	
	year = cal.get(Calendar.YEAR);
	month = cal.get(Calendar.MONTH)+1;
	int week = cal.get(Calendar.DAY_OF_WEEK);
	
%>
<style type="text/css">

a{
	color: #000; text-decoration: none;
}

a:hover, a:active{
	color: #77AF9C; text-decoration: underline;
}

#layout{
	margin: 30px auto; width: 210px;
}

.calendar table{
	text-align : center;
	width: 100%; border-spacing: 0; border-collapse: collapse;
}

.calendar table tr{
	height: 30px; text-align: center;
}

.calendar table #day{
	height: 30px; text-align: center;
	width: 10px; height: 10px;
}

.calendar #day:hover{
	background : #77AF9C;
	color : white;
	border-radius: 100px;
}

/*


 .calendar td:nth-child(7n+1){
	color: red;
}

.calendar td:nth-child(7n){
	color: blue;
}

.calendar td .gray{
	 color: gray;
} */


</style>

<style type="text/css">
.homepage #main {
	margin-top: 0em;
	padding-top: 0em;
}

.ui-widget-header {
	background: none;
	border: none;
	height: 35px;
	line-height: 35px;
	border-bottom: 1px solid #cccccc;
	border-radius: 0px;
}

.alert-info {
	border: 1px solid #9acfea;
	border-radius: 4px;
	background-color: #d9edf7;
	color: #31708f;
	padding: 15px;
	margin-top: 10px;
	margin-bottom: 20px;
}

.btn {
	width: 100px;
	height: 30px;
	background-color: white;
	border-color: #cccccc;
	border-radius: 10px;
	margin: 20px 10px;
}

table td {
	padding-top: 6px;
}

.title {
	text-align: center;
	 width: 100px;
}

#train, #train2 {
	clear: both;
	margin-left: 10px;
	width: 95%;
}

#train tr, #train2 tr {
	width: 20%;
	text-align: center;
}

#train td, #train2 td {
	border: 1px solid #cccccc;
	//
	eaeaea
}

#travelTable tr {
	padding-top: 10px;
	padding-bottom: 10px;
}

.title {
	width: 200px;
	font-weight: bold;
}
</style>

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
	$(".calendar #day").click(function() {
		var year = <%=year%>;
		var month = <%=month%>;
		var day = $(this).attr("data-tab");
		var data = year + '년' + month + '월 ' + day + '일';
			
		$("#date").html(data);
	});
});

function reservation(){
	var f = document.travelArticleForm;
	var query = $(f).serialize();
	
	f.action="<%=cp%>/booking/reservation?"+query;

	console.log(query);
	f.submit();
	
}


</script>
	<p>상세</p>

<form name="travelArticleForm" method="get" enctype="multipart/form-data">
	<table id="travelTable"
		style="border-spacing: 0px; border-collapse: collapse;">
		<tr align="left" height="40"
			style="border-bottom: 1px solid #cccccc; border-top: 3px solid #cccccc;">
			<td class="title"  style="text-align: center;"
				colspan="2">여행 테마</td>
			<td style="padding-left: 10px;" colspan="3" width="100%">${dto.pmTitle}</td>
		</tr>


		<tr align="left" height="40"
			style=" border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
			<td rowspan="5" colspan="2" style="width: 100px; padding: 10px 10px;">
				<img src="<%=cp%>/resource/images/jeju.jpg" style="width: 300px;">				
			</td>
			<td class="title" style="text-align: center;">상품번호</td>
			<td style="padding-left: 10px; width: 200px;"><input type="text" name="pmCode" value="${dto.pmCode}">${dto.pmCode}</td>
			<td class="title" id="calendar" style="text-align: center; padding-top: 5px;" rowspan="7">
				<table style="width: 200px; margin-left: 10px;" class="calendar">
					<tr style="border-bottom: 2px solid #cccccc;">
						<td colspan="8" style="text-align: center; color: black; width: 50px;"><a
							href="article.jsp?year=<%=year%>&month=<%=month - 1%>"><i class="fas fa-arrow-circle-left"></i></a> 
								<%=year%>년 <%=month%>월
							 <a href="article.jsp?year=<%=year%>&month=<%=month + 1%>"><i class="fas fa-arrow-circle-right"></i></a>
						</td>
					</tr>
					<tr>
						<td>일</td>
						<td>월</td>
						<td>화</td>
						<td>수</td>
						<td>목</td>
						<td>금</td>
						<td>토</td>
					</tr>
					
				</table>
			</td>
		</tr>
 
		<tr align="left" height="40"
			style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
			<td class="title"   style="text-align: center;">상품가격</td>
			<td style="padding-left: 10px; width: 343px;">${dto.pmPrice}~</td>
		</tr>

		<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
		<td class="title"   style="text-align: center;">판매자</td>
			<td style="padding-left: 10px; width: 343px;">${dto.partnerName}</td>
		</tr>
		
		<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
		<td class="title"   style="text-align: center;">문의전화</td>
			<td style="padding-left: 10px; width: 343px;">${dto.partnerTel}</td>
		</tr>

		<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
		<td class="title"   style="text-align: center;">예약 인원</td>
			<td style="padding-left: 10px; width: 343px;">
				<select name="prPersonal">
					<option value="1">1명</option>
					<option value="2">2명</option>
					<option value="3">3명</option>
					<option value="4">4명</option>
					<option value="5">5명</option>
					<option value="6">6명</option>
					<option value="7">7명</option>
					<option value="8">8명</option>
					<option value="9">9명</option>
					<option value="10">10명</option>
				</select>
			</td>
		</tr>
		
		<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
			<td rowspan="2" style="width: 50px; padding: 10px 10px;">
				<img src="<%=cp%>/resource/images/jeju.jpg" style="width: 70px;">
			</td>
			<td rowspan="2" style="width: 50px; padding: 10px 10px;">
				<img src="<%=cp%>/resource/images/jeju.jpg" style="width: 70px;">
			</td>
			<td class="title"   style="text-align: center;">예약 최소 인원</td>
			<td style="padding-left: 10px; width: 343px;">
				1명
			</td>
		</tr>
		
		<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
		<td class="title"   style="text-align: center;">출발일자</td>
			<td style="padding-left: 10px; width: 343px;">
				<input type="date" name="pmStartDate" id="date">
			</td>
		</tr>
		
		<tr style="border-top: 3px solid #cccccc; border-bottom: 3px solid #cccccc;">
			<td colspan="5">&nbsp;</td>
		</tr>
	</table>	
		
	<table 
		style=" margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
		<tr align="left" height="40"
			style="border-bottom: 1px solid #cccccc; border-top: 3px solid #cccccc;">
			<td class="title">상품 그룹</td>
			<td class="title">선택</td>
			<td class="title">상품명</td>
			<td class="title">열차번호</td>
			<td class="title">출발시간</td>
			<td class="title">도착시간</td>
			<td class="title">재고</td>
			<td class="title">예약현황</td>
		</tr>
		
		<tbody>
			
		<c:forEach var="vo" items="${startList}">
			<tr align="left" style="border-bottom: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
				<c:if test="${vo == startList.get(0)}">
					<td class="title" rowspan="${startLength}">오는 열차</td>
				</c:if>
				<td class="title"><input type="checkbox" name="startTrain" value="${vo.trainCode}"></td>
				<td class="title">${vo.trainName}</td>
				<td class="title">${vo.trainCode}</td>
				<td class="title">${vo.startTime}</td>
				<td class="title">${vo.endTime}</td>
				<td class="title">재고</td>
				<td class="title">예약현황</td>
			</tr>
		</c:forEach>
		
			<tr align="left" style="border-bottom: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
				<td class="title">${dto.product}</td>
				<td class="title"><input type="radio" checked="checked"></td>
				<td class="title">${dto.productContent}</td>
				<td class="title"></td>
				<td class="title">-</td>
				<td class="title">-</td>
				<td class="title">-</td>
				<td class="title">-</td>
			</tr>
		
		<c:forEach var="vo" items="${endList}">
			<tr align="left" style="border-bottom: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
				<c:if test="${vo == endList.get(0)}">
					<td class="title"  rowspan="${endLength}">가는 열차</td>
				</c:if>
				<td class="title"><input type="checkbox" name="endTrain" value="${vo.trainCode}"></td>
				<td class="title">${vo.trainName}</td>
				<td class="title">${vo.trainCode}</td>
				<td class="title">${vo.startTime}</td>
				<td class="title">${vo.endTime}</td>
				<td class="title">재고</td>
				<td class="title">예약현황</td>
			</tr>
		</c:forEach>
			
		<tr align="left" height="40" style="float: right;">
			<td  class="title"><button type="button"  id="btn" class="btn" >리스트</button></td>
			<td class="title"><button type="button" id="btn" class="btn" onclick="reservation();">예약하기</button></td>
		</tr>
				
		
		</tbody>
		
	</table>
	
 
	
</form>


